// TSRFRenderDlg.cpp : implementation file
//

#include "stdafx.h"
#include "SketchEditor.h"
#include "TSRFRenderDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CTSRFRenderDlg dialog


CTSRFRenderDlg::CTSRFRenderDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CTSRFRenderDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CTSRFRenderDlg)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
}


void CTSRFRenderDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CTSRFRenderDlg)
		// NOTE: the ClassWizard will add DDX and DDV calls here
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CTSRFRenderDlg, CDialog)
	//{{AFX_MSG_MAP(CTSRFRenderDlg)
		// NOTE: the ClassWizard will add message map macros here
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CTSRFRenderDlg message handlers
