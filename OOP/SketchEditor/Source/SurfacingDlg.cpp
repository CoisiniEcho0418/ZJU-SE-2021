// SurfacingDlg.cpp : implementation file
//

#include "stdafx.h"
#include "SketchEditor.h"
#include "SurfacingDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CSurfacingDlg dialog


CSurfacingDlg::CSurfacingDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CSurfacingDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CSurfacingDlg)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
}


void CSurfacingDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CSurfacingDlg)
		// NOTE: the ClassWizard will add DDX and DDV calls here
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CSurfacingDlg, CDialog)
	//{{AFX_MSG_MAP(CSurfacingDlg)
		// NOTE: the ClassWizard will add message map macros here
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CSurfacingDlg message handlers
