// CreateDlg.cpp : implementation file
//

#include "stdafx.h"
#include "SketchEditor.h"
#include "CreateDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CCreateDlg dialog


CCreateDlg::CCreateDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CCreateDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CCreateDlg)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
}


void CCreateDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CCreateDlg)
		// NOTE: the ClassWizard will add DDX and DDV calls here
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CCreateDlg, CDialog)
	//{{AFX_MSG_MAP(CCreateDlg)
		// NOTE: the ClassWizard will add message map macros here
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CCreateDlg message handlers
