// TrimmingDlg.cpp : implementation file
//

#include "stdafx.h"
#include "SketchEditor.h"
#include "TrimmingDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CTrimmingDlg dialog


CTrimmingDlg::CTrimmingDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CTrimmingDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CTrimmingDlg)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
}


void CTrimmingDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CTrimmingDlg)
		// NOTE: the ClassWizard will add DDX and DDV calls here
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CTrimmingDlg, CDialog)
	//{{AFX_MSG_MAP(CTrimmingDlg)
		// NOTE: the ClassWizard will add message map macros here
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CTrimmingDlg message handlers
