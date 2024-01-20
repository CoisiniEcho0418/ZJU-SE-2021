#if !defined(AFX_LOWERTAB_H__259389FB_9051_45FC_A1EC_2B9AB7BB7FC0__INCLUDED_)
#define AFX_LOWERTAB_H__259389FB_9051_45FC_A1EC_2B9AB7BB7FC0__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// LowerTab.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CLowerTab window

class CLowerTab : public CTabCtrl
{
// Construction
public:
	CLowerTab();

// Attributes
public:

// Operations
public:

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CLowerTab)
	//}}AFX_VIRTUAL

// Implementation
public:
	void ActivateTabDialogs();
	void InitDialogs();
	virtual ~CLowerTab();

	// Generated message map functions
protected:
	//{{AFX_MSG(CLowerTab)
	afx_msg void OnSelchange(NMHDR* pNMHDR, LRESULT* pResult);
	//}}AFX_MSG

	DECLARE_MESSAGE_MAP()
private:

	int m_nPageCount;
	CDialog* m_Dialog[5];
	int m_iDialogID[5];
};

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_LOWERTAB_H__259389FB_9051_45FC_A1EC_2B9AB7BB7FC0__INCLUDED_)
