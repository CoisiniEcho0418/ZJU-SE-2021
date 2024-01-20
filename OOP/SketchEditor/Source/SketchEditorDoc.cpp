// SketchEditorDoc.cpp : implementation of the CSketchEditorDoc class
//

#include "stdafx.h"
#include "SketchEditor.h"

#include "SketchEditorDoc.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CSketchEditorDoc

IMPLEMENT_DYNCREATE(CSketchEditorDoc, CDocument)

BEGIN_MESSAGE_MAP(CSketchEditorDoc, CDocument)
	//{{AFX_MSG_MAP(CSketchEditorDoc)
	ON_COMMAND(ID_FILE_OPEN, OnFileOpen)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CSketchEditorDoc construction/destruction

CSketchEditorDoc::CSketchEditorDoc()
{
	// TODO: add one-time construction code here

}

CSketchEditorDoc::~CSketchEditorDoc()
{
}

BOOL CSketchEditorDoc::OnNewDocument()
{
	if (!CDocument::OnNewDocument())
		return FALSE;

	// TODO: add reinitialization code here
	// (SDI documents will reuse this document)

	return TRUE;
}



/////////////////////////////////////////////////////////////////////////////
// CSketchEditorDoc serialization

void CSketchEditorDoc::Serialize(CArchive& ar)
{
	if (ar.IsStoring())
	{
		// TODO: add storing code here
	}
	else
	{
		// TODO: add loading code here
	}
}

/////////////////////////////////////////////////////////////////////////////
// CSketchEditorDoc diagnostics

#ifdef _DEBUG
void CSketchEditorDoc::AssertValid() const
{
	CDocument::AssertValid();
}

void CSketchEditorDoc::Dump(CDumpContext& dc) const
{
	CDocument::Dump(dc);
}
#endif //_DEBUG

/////////////////////////////////////////////////////////////////////////////
// CSketchEditorDoc commands

void CSketchEditorDoc::OnFileOpen() 
{
	// TODO: Add your command handler code here
	CFileDialog OpenObjDlg(TRUE, NULL, NULL, OFN_OVERWRITEPROMPT,
			"Obj Files (*.obj)|*.obj||All Files (*.*)|*.*||");
	if(OpenObjDlg.DoModal() == IDOK)
	{
		//Load obj file
		CString path = OpenObjDlg.GetPathName();
		LoadModelsFromFiles(path);
		UpdateAllViews(NULL);
//		InvalidateRect(NULL, FALSE);
	}
}

void CSketchEditorDoc::LoadModelsFromFiles(CString FilePath)
{
	GLfloat scalefactor = 0.0;
	GLfloat scalefactor_ = 0.0;

	//Load Object from file
//	GLMmodel *object;
	m_GeomModelObject = new GeomModel;

//	m_GeomObject = glmReadOBJ(FilePath.GetBuffer(0));
	m_GeomModelObject->glmReadOBJ(FilePath.GetBuffer(0));

	if(! scalefactor)
	{
		//Create Unit vectors
//		scalefactor = glmUnitize( m_GeomObject);
		scalefactor = m_GeomModelObject->glmUnitize();

	}
	else
	{
		//Scale object properly
//		glmScale(m_GeomObject, scalefactor);
		m_GeomModelObject->glmScale(scalefactor);
	}

	//Scale object
//	glmScale( m_GeomObject, 1.0);
	m_GeomModelObject->glmScale(1.0);


//	glmFacetNormals( m_GeomObject);
	m_GeomModelObject->glmFacetNormals();
    //glmVertexNormals(object, 90.0);

	//build a display list
//	m_ObjectList = glmList( m_GeomObject, GLM_SMOOTH | GLM_MATERIAL);
	m_ObjectList = m_GeomModelObject->glmList(GLM_SMOOTH | GLM_MATERIAL);
	
	//Nuke the object
	m_GeomModelObject->glmDelete();

}
