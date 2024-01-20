// LowerTab.cpp : implementation file
//

#include "stdafx.h"
#include "SketchEditor.h"
#include "LowerTab.h"

#include "CreateDlg.h"
#include "ModifyDlg.h"
#include "SurfacingDlg.h"
#include "CameraCalibDlg.h"
#include "TrimmingDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CLowerTab

CLowerTab::CLowerTab()
{
	m_iDialogID[0] = IDD_CREATE;
	m_iDialogID[1] = IDD_MODIFY;
	m_iDialogID[2] = IDD_SURFACING;
	m_iDialogID[3] = IDD_CAMERA_CALIB;
	m_iDialogID[4] = IDD_TRIMMING;

	m_Dialog[0] = new CCreateDlg();
	m_Dialog[1] = new CModifyDlg();
	m_Dialog[2] = new CSurfacingDlg();
	m_Dialog[3] = new CCameraCalibDlg();
	m_Dialog[4] = new CTrimmingDlg();

	m_nPageCount = 5;
}

CLowerTab::~CLowerTab()
{
}


BEGIN_MESSAGE_MAP(CLowerTab, CTabCtrl)
	//{{AFX_MSG_MAP(CLowerTab)
	ON_NOTIFY_REFLECT(TCN_SELCHANGE, OnSelchange)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CLowerTab message handlers

void CLowerTab::ActivateTabDialogs()
{
	int nSel = GetCurSel();
	if(m_Dialog[nSel]->m_hWnd)
		m_Dialog[nSel]->ShowWindow(SW_HIDE);

	CRect l_rectClient;
	CRect l_rectWnd;

	GetClientRect(l_rectClient);
	AdjustRect(FALSE, l_rectClient);
	GetWindowRect(l_rectWnd);
	GetParent()->ScreenToClient(l_rectWnd);
	l_rectClient.OffsetRect(l_rectWnd.left, l_rectWnd.top);

	for(int nCount = 0; nCount < m_nPageCount; nCount++)
	{
		m_Dialog[nCount]->SetWindowPos(&wndTop, l_rectClient.left, l_rectClient.top, 
			l_rectClient.Width(), l_rectClient.Height(), SWP_HIDEWINDOW);
	}
	m_Dialog[nSel]->SetWindowPos(&wndTop, l_rectClient.left, l_rectClient.top, 
		l_rectClient.Width(), l_rectClient.Height(), SWP_SHOWWINDOW);

	m_Dialog[nSel]->ShowWindow(SW_SHOW);
}

void CLowerTab::InitDialogs()
{
	m_Dialog[0]->Create(m_iDialogID[0], GetParent());
	m_Dialog[1]->Create(m_iDialogID[1], GetParent());
	m_Dialog[2]->Create(m_iDialogID[2], GetParent());
	m_Dialog[3]->Create(m_iDialogID[3], GetParent());
	m_Dialog[4]->Create(m_iDialogID[4], GetParent());

}

void CLowerTab::OnSelchange(NMHDR* pNMHDR, LRESULT* pResult) 
{
	// TODO: Add your control notification handler code here
	ActivateTabDialogs();
	*pResult = 0;
}
