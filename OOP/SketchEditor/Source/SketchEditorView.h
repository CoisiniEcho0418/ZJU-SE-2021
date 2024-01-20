// SketchEditorView.h : interface of the CSketchEditorView class
//
/////////////////////////////////////////////////////////////////////////////

#if !defined(AFX_SKETCHEDITORVIEW_H__36A0516F_A055_4B2B_8FF2_DAB94B8E2B9D__INCLUDED_)
#define AFX_SKETCHEDITORVIEW_H__36A0516F_A055_4B2B_8FF2_DAB94B8E2B9D__INCLUDED_

#include "Camera.h"	// Added by ClassView
#include "SketchLine.h"	// Added by ClassView

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000


class CSketchEditorView : public CView
{
protected: // create from serialization only
	CSketchEditorView();
	DECLARE_DYNCREATE(CSketchEditorView)

// Attributes
public:
	CSketchEditorDoc* GetDocument();

// Operations
public:

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CSketchEditorView)
	public:
	virtual void OnDraw(CDC* pDC);  // overridden to draw this view
	virtual BOOL PreCreateWindow(CREATESTRUCT& cs);
	protected:
	virtual BOOL OnPreparePrinting(CPrintInfo* pInfo);
	virtual void OnBeginPrinting(CDC* pDC, CPrintInfo* pInfo);
	virtual void OnEndPrinting(CDC* pDC, CPrintInfo* pInfo);
	//}}AFX_VIRTUAL

// Implementation
public:
	virtual ~CSketchEditorView();
#ifdef _DEBUG
	virtual void AssertValid() const;
	virtual void Dump(CDumpContext& dc) const;
#endif

protected:

// Generated message map functions
protected:
	//{{AFX_MSG(CSketchEditorView)
	afx_msg int OnCreate(LPCREATESTRUCT lpCreateStruct);
	afx_msg void OnSize(UINT nType, int cx, int cy);
	afx_msg void OnLButtonDown(UINT nFlags, CPoint point);
	afx_msg void OnLButtonUp(UINT nFlags, CPoint point);
	afx_msg void OnMouseMove(UINT nFlags, CPoint point);
	afx_msg BOOL OnMouseWheel(UINT nFlags, short zDelta, CPoint pt);
	afx_msg void OnInputSketch();
	afx_msg void OnRButtonDown(UINT nFlags, CPoint point);
	afx_msg void OnRButtonUp(UINT nFlags, CPoint point);
	afx_msg void OnOutputSketch();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
private:
	BOOL m_bDrawing;
	CSketchLine m_SketchLine;
	void DrawBackGround();
	void SetupLighting();
	void DrawScene();
//	GLuint m_ObjectList;
	CCamera m_Camera;
	void RenderScene();
	HGLRC m_hRC;
	CDC*  m_pDC;
	BOOL SetupPixelFormat();
	BOOL InitializeOpenGL();
};

#ifndef _DEBUG  // debug version in SketchEditorView.cpp
inline CSketchEditorDoc* CSketchEditorView::GetDocument()
   { return (CSketchEditorDoc*)m_pDocument; }
#endif

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_SKETCHEDITORVIEW_H__36A0516F_A055_4B2B_8FF2_DAB94B8E2B9D__INCLUDED_)
