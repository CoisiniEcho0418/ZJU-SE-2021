// SketchLine.h: interface for the CSketchLine class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_SKETCHLINE_H__CCABE12A_E0BE_47C2_9D5B_C48AEA3D4640__INCLUDED_)
#define AFX_SKETCHLINE_H__CCABE12A_E0BE_47C2_9D5B_C48AEA3D4640__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#include "3DPoint.h"

class CSketchLine  
{
private:
	void Inflate();
	//Vertices composed by point
	float *Vertices;
	//Lines composed by index into Vertices
	int *Lines;
	//Number of Lines
	int NumOfLines;
	//Size of Vertices
	int SizeOfVertices;
	//size of Lines
	int SizeOfLines;
	//Current Size of Vertices
	int CurSizeOfVertices;
	//Current Size of Lines
	int CurSizeOfLines;
public:
	BOOL SaveToFile(CString FilePath);
	BOOL LoadFromFile(CString FilePath);
	void Display();
	BOOL InsertLine(const C3DPoint &PtA, const C3DPoint &PtB);
	CSketchLine();
	virtual ~CSketchLine();
};

#endif // !defined(AFX_SKETCHLINE_H__CCABE12A_E0BE_47C2_9D5B_C48AEA3D4640__INCLUDED_)
