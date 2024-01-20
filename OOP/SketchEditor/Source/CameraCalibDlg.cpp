// CameraCalibDlg.cpp : implementation file
//

#include "stdafx.h"
#include "SketchEditor.h"
#include "CameraCalibDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CCameraCalibDlg dialog


CCameraCalibDlg::CCameraCalibDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CCameraCalibDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CCameraCalibDlg)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
}


void CCameraCalibDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CCameraCalibDlg)
		// NOTE: the ClassWizard will add DDX and DDV calls here
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CCameraCalibDlg, CDialog)
	//{{AFX_MSG_MAP(CCameraCalibDlg)
		// NOTE: the ClassWizard will add message map macros here
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CCameraCalibDlg message handlers
