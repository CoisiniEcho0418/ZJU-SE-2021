// UpperTab.cpp : implementation file
//

#include "stdafx.h"
#include "SketchEditor.h"
#include "UpperTab.h"

#include "SRFRenderDlg.h"
#include "TSRFRenderDlg.h"
#include "EdgeDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CUpperTab

CUpperTab::CUpperTab()
{
	m_iDialogID[0] = IDD_SRF_RENDER;
	m_iDialogID[1] = IDD_TSRF_RENDER;
	m_iDialogID[2] = IDD_EDGE;

	m_Dialog[0] = new CSRFRenderDlg();
	m_Dialog[1] = new CTSRFRenderDlg();
	m_Dialog[2] = new CEdgeDlg();
}

CUpperTab::~CUpperTab()
{
}


BEGIN_MESSAGE_MAP(CUpperTab, CTabCtrl)
	//{{AFX_MSG_MAP(CUpperTab)
	ON_NOTIFY_REFLECT(TCN_SELCHANGE, OnSelchange)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CUpperTab message handlers

void CUpperTab::InitDialogs()
{
	//create dialog boxes
	m_Dialog[0]->Create(m_iDialogID[0], GetParent());
	m_Dialog[1]->Create(m_iDialogID[1], GetParent());
	m_Dialog[2]->Create(m_iDialogID[2], GetParent());

	m_nPageCount = 3;
}

void CUpperTab::OnSelchange(NMHDR* pNMHDR, LRESULT* pResult) 
{
	// TODO: Add your control notification handler code here
	ActivateTabDialogs();
	*pResult = 0;
}

void CUpperTab::ActivateTabDialogs()
{
	int nSel = GetCurSel();
	if(m_Dialog[nSel]->m_hWnd)
		m_Dialog[nSel]->ShowWindow(SW_HIDE);

	CRect l_rectClient;
	CRect l_rectWnd;

	GetClientRect(&l_rectClient);
	AdjustRect(FALSE, &l_rectClient);
	GetWindowRect(&l_rectWnd);
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
