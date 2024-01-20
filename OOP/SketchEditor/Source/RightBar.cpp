// RightBar.cpp : implementation file
//

#include "stdafx.h"
#include "SketchEditor.h"
#include "RightBar.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CRightBar dialog



//CRightBar::CRightBar(CWnd* pParent /*=NULL*/)
//	: CDialog(CRightBar::IDD, pParent)
//{
//	//{{AFX_DATA_INIT(CRightBar)
//		// NOTE: the ClassWizard will add member initialization here
//	//}}AFX_DATA_INIT
//}


CRightBar::CRightBar()
{
	//{{AFX_DATA_INIT(CRightBar)
	//}}AFX_DATA_INIT
}


//void CRightBar::DoDataExchange(CDataExchange* pDX)
//{
//	CDialog::DoDataExchange(pDX);
//	//{{AFX_DATA_MAP(CRightBar)
//	DDX_Control(pDX, IDC_TABUPPER, m_LowerTab);
//	DDX_Control(pDX, IDC_TABLOWER, m_UpperTab);
//	//}}AFX_DATA_MAP
//}


void CRightBar::DoDataExchange(CDataExchange* pDX)
{
	CDialogBar::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CRightBar)
	DDX_Control(pDX, IDC_TABUPPER, m_UpperTab);
	DDX_Control(pDX, IDC_TABLOWER, m_LowerTab);
	//}}AFX_DATA_MAP
}



BEGIN_MESSAGE_MAP(CRightBar, CDialogBar)
	//{{AFX_MSG_MAP(CRightBar)
	//}}AFX_MSG_MAP
	ON_MESSAGE(WM_INITDIALOG, OnInitDialog )
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CRightBar message handlers

LONG CRightBar::OnInitDialog(UINT wParam, LONG lParam) 
{
	//CDialog::OnInitDialog();
	BOOL bRet = HandleInitDialog(wParam, lParam);
	if (!UpdateData(FALSE))
	{
		TRACE0("Warning: UpdateData failed during dialog init.\n");
    }
	
	// TODO: Add extra initialization here
	m_UpperTab.InitDialogs();

	m_UpperTab.InsertItem(0, "SRF Render");
	m_UpperTab.InsertItem(1, "TSRF Render");
	m_UpperTab.InsertItem(2, "Edge");

	m_UpperTab.ActivateTabDialogs();

	m_LowerTab.InitDialogs();

	m_LowerTab.InsertItem(0, "Create");
	m_LowerTab.InsertItem(1, "Modify");
	m_LowerTab.InsertItem(2, "Surfacing");
	m_LowerTab.InsertItem(3, "Camera Calib");
	m_LowerTab.InsertItem(4, "Trimming");

	m_LowerTab.ActivateTabDialogs();
	return TRUE;  // return TRUE unless you set the focus to a control
	              // EXCEPTION: OCX Property Pages should return FALSE
}
