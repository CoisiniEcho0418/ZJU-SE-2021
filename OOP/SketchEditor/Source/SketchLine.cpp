// SketchLine.cpp: implementation of the CSketchLine class.
//
//////////////////////////////////////////////////////////////////////

#include "stdafx.h"
#include "SketchEditor.h"
#include "SketchLine.h"

#ifdef _DEBUG
#undef THIS_FILE
static char THIS_FILE[]=__FILE__;
#define new DEBUG_NEW
#endif

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

CSketchLine::CSketchLine()
{
	//Initialize size of Vertices
	SizeOfVertices = 1024 * 3;
	SizeOfLines = SizeOfVertices / 3 * 2 - 2;

	//Initialize Current size
	CurSizeOfVertices = 1;
	CurSizeOfLines = 1;

	//Allocat Memory
	Vertices = new float [SizeOfVertices + 1];
	Lines = new int [SizeOfLines + 1];

	if(! Vertices || ! Lines)
	{
		//Something wrong happens here
	}

	NumOfLines = 0;
}

CSketchLine::~CSketchLine()
{
	delete [] Vertices;
	delete [] Lines;
}

void CSketchLine::Inflate()
{
	//Double Vertices Size
	SizeOfVertices *= 2;
	SizeOfLines = SizeOfVertices / 3 * 2 - 2;

	float *NewVertices = new float [SizeOfVertices];
	int *NewLines = new int [SizeOfLines];

	if(! NewVertices || ! NewLines)
	{
		//Something wrong happens here
	}
	//Copy data
	memcpy(NewVertices, Vertices, sizeof(float) * SizeOfVertices / 2);
	memcpy(NewLines, Lines, sizeof(int) * (NumOfLines * 2 + 1));

	//Delete old data
	delete [] Vertices;
	delete [] Lines;

	Vertices = NewVertices;
	Lines = NewLines;
}

BOOL CSketchLine::InsertLine(const C3DPoint &PtA, const C3DPoint &PtB)
{
	//Inflate if out of space
	if(CurSizeOfVertices + 6 > SizeOfVertices)
	{
		Inflate();
	}

	//Store two coordinates into Vertices
	Vertices[CurSizeOfVertices++] = PtA.X;
	Vertices[CurSizeOfVertices++] = PtA.Y;
	Vertices[CurSizeOfVertices++] = PtA.Z;
	Lines[CurSizeOfLines++] = CurSizeOfVertices - 3;

	Vertices[CurSizeOfVertices++] = PtB.X;
	Vertices[CurSizeOfVertices++] = PtB.Y;
	Vertices[CurSizeOfVertices++] = PtB.Z;
	Lines[CurSizeOfLines++] = CurSizeOfVertices - 3;

	//Increase Number Of Lines
	NumOfLines++;

	return TRUE;
}

void CSketchLine::Display()
{
	//Disable lighting
	glDisable(GL_LIGHTING);

	//Specify line color and width
	glColor3f(1.0f, 0.0f, 0.0f);
	glLineWidth(2.0f);

	//Initial point and end point
	C3DPoint PointA, PointB;
	//Vertex index
	int Index;

	for(int i = 0; i < NumOfLines; i++)
	{
		//Grab point A Coordinates
		Index = Lines[2 * i + 1];
		PointA.X = Vertices[(Index-1)*3 + 1];
		PointA.Y = Vertices[(Index-1)*3 + 2];
		PointA.Z = Vertices[(Index-1)*3 + 3];

		//Grab point B Coordinates
		Index = Lines[2 * i + 2];
		PointB.X = Vertices[(Index-1)*3 + 1];
		PointB.Y = Vertices[(Index-1)*3 + 2];
		PointB.Z = Vertices[(Index-1)*3 + 3];

		//Draw line
		glBegin(GL_LINES);
			glVertex3f(PointA.X, PointA.Y, PointA.Z);
			glVertex3f(PointB.X, PointB.Y, PointB.Z);
		glEnd();
	}

	//Enable lighting
	glEnable(GL_LIGHTING);
	//Restore line width
	glLineWidth(1.0f);
}

BOOL CSketchLine::LoadFromFile(CString FilePath)
{
	CStdioFile file;
	
	if(! file.Open(FilePath.GetBuffer(0), CFile::modeRead))
	{
		//Unable to open file
		return FALSE;
	}

	//Initialize
	CurSizeOfLines = 0;
	CurSizeOfVertices = 0;
	NumOfLines = 0;

	int VIndex = 0;
	int LIndex = 0;

	CString line;
	while(file.ReadString(line))
	{
		if(! line.GetLength())
			continue;

		if(CurSizeOfVertices + 3 >= SizeOfVertices || CurSizeOfLines + 2 >= SizeOfLines)
		{
			Inflate();
		}
		line.MakeLower();
		switch(line.GetAt(0))
		{
		//Read Vertices
		case 'v' :	line.Delete(0);
					sscanf(line.GetBuffer(0), "%f%f%f", 
						&Vertices[VIndex*3+1], &Vertices[VIndex*3+2], &Vertices[VIndex*3+3]);
					VIndex++;
					CurSizeOfVertices += 3;
					break;
		//Read Lines
		case 'l' :	line.Delete(0);
					sscanf(line.GetBuffer(0), "%d/%d",
						&Lines[LIndex*2+1], &Lines[LIndex*2+2]);
					LIndex++;
					CurSizeOfLines += 2;
					NumOfLines++;
					break;
		default :	break;
		}
	}

	file.Close();

	return TRUE;
}

BOOL CSketchLine::SaveToFile(CString FilePath)
{
	CStdioFile file;

	if(! file.Open(FilePath.GetBuffer(0), CFile::modeCreate | CFile::modeWrite))
	{
		//Fail to create file
		return FALSE;
	}

	CString line;

	//Write vertices into file
	for(int i = 0; i * 3 + 3 <= CurSizeOfVertices; i++)
	{
		line.Format("v	%f	%f	%f\n", Vertices[i*3+1], Vertices[i*3+2], Vertices[i*3+3]);
		file.WriteString(line.GetBuffer(0));
	}
	//Write lines into file
	for(int j = 0; j < NumOfLines; j++)
	{
		line.Format("l	%d/%d\n", Lines[j*2+1], Lines[j*2+2]);
		file.WriteString(line.GetBuffer(0));
	}

	//All done, close file
	file.Close();

	return TRUE;
}
