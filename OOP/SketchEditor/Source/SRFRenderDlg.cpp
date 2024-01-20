// SRFRenderDlg.cpp : implementation file
//

#include "stdafx.h"
#include "SketchEditor.h"
#include "SRFRenderDlg.h"
#include "SketchEditorDoc.h"
#include "SketchEditorView.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CSRFRenderDlg dialog


CSRFRenderDlg::CSRFRenderDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CSRFRenderDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CSRFRenderDlg)
	//}}AFX_DATA_INIT
}


void CSRFRenderDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CSRFRenderDlg)
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CSRFRenderDlg, CDialog)
	//{{AFX_MSG_MAP(CSRFRenderDlg)
	ON_BN_CLICKED(IDC_SRF_RDNONE, OnSrfRdnone)
	ON_BN_CLICKED(IDC_SRF_RBSMOOTH, OnSrfRbsmooth)
	ON_BN_CLICKED(IDC_SRF_USER_EDGE, OnSrfUserEdge)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CSRFRenderDlg message handlers

void CSRFRenderDlg::OnSrfRdnone() 
{
	// TODO: Add your control notification handler code here
	CSketchEditorDoc *pDoc = (CSketchEditorDoc*)GetParentFrame()->GetActiveDocument();
	pDoc->m_bShowObject = FALSE;
	CSketchEditorView *pView = (CSketchEditorView*)GetParentFrame()->GetActiveView();
	pView->InvalidateRect(NULL, FALSE);
}

void CSRFRenderDlg::OnSrfRbsmooth() 
{
	// TODO: Add your control notification handler code here
	CSketchEditorDoc *pDoc = (CSketchEditorDoc*)GetParentFrame()->GetActiveDocument();
	pDoc->m_bShowObject = TRUE;
	CSketchEditorView *pView = (CSketchEditorView*)GetParentFrame()->GetActiveView();
	pView->InvalidateRect(NULL, FALSE);
}

void CSRFRenderDlg::OnSrfUserEdge() 
{
	// TODO: Add your control notification handler code here
	CSketchEditorDoc *pDoc = (CSketchEditorDoc*)GetParentFrame()->GetActiveDocument();
	pDoc->m_bShowUserEdge = ! pDoc->m_bShowUserEdge;
	CSketchEditorView *pView = (CSketchEditorView*)GetParentFrame()->GetActiveView();
	pView->InvalidateRect(NULL, FALSE);
}
