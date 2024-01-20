#if !defined(AFX_RIGHTBAR_H__7F9E0332_F030_47E7_9691_7762DDD1D231__INCLUDED_)
#define AFX_RIGHTBAR_H__7F9E0332_F030_47E7_9691_7762DDD1D231__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// RightBar.h : header file
//
#include "UpperTab.h"
#include "LowerTab.h"

/////////////////////////////////////////////////////////////////////////////
// CRightBar dialog

class CRightBar : public CDialogBar
{
// Construction
public:
	//CRightBar(CWnd* pParent = NULL);   // standard constructor
	CRightBar();

// Dialog Data
	//{{AFX_DATA(CRightBar)
	enum { IDD = IDD_RIGHTBAR };
	CUpperTab	m_UpperTab;
	CLowerTab	m_LowerTab;
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CRightBar)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CRightBar)
	//}}AFX_MSG
	afx_msg LONG OnInitDialog ( UINT, LONG );
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_RIGHTBAR_H__7F9E0332_F030_47E7_9691_7762DDD1D231__INCLUDED_)
