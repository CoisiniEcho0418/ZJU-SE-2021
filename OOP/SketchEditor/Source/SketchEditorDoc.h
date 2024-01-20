// SketchEditorDoc.h : interface of the CSketchEditorDoc class
//
/////////////////////////////////////////////////////////////////////////////

#if !defined(AFX_SKETCHEDITORDOC_H__0913A723_C03B_45FB_97CD_E9C7D26D6F7C__INCLUDED_)
#define AFX_SKETCHEDITORDOC_H__0913A723_C03B_45FB_97CD_E9C7D26D6F7C__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
#include "glm.h"
#include "GeomModel.h"

class CSketchEditorDoc : public CDocument
{
protected: // create from serialization only
	CSketchEditorDoc();
	DECLARE_DYNCREATE(CSketchEditorDoc)

// Attributes
public:
//	GLMmodel*	m_GeomObject;
	GeomModel*	m_GeomModelObject;
	GLuint		m_ObjectList;
//	GLuint		m_ObjectList_;

// Operations
public:

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CSketchEditorDoc)
	public:
	virtual BOOL OnNewDocument();
	virtual void Serialize(CArchive& ar);
	//}}AFX_VIRTUAL

// Implementation
public:
	
	void LoadModelsFromFiles(CString FilePath);
	BOOL m_bShowObject;
	BOOL m_bShowUserEdge;
	virtual ~CSketchEditorDoc();
#ifdef _DEBUG
	virtual void AssertValid() const;
	virtual void Dump(CDumpContext& dc) const;
#endif

protected:

// Generated message map functions
protected:
	
	
	//{{AFX_MSG(CSketchEditorDoc)
	afx_msg void OnFileOpen();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_SKETCHEDITORDOC_H__0913A723_C03B_45FB_97CD_E9C7D26D6F7C__INCLUDED_)
