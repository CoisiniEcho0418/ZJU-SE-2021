#if !defined(AFX_UPPERTAB_H__9F846240_CEC6_4468_B118_7C97AC2E69DE__INCLUDED_)
#define AFX_UPPERTAB_H__9F846240_CEC6_4468_B118_7C97AC2E69DE__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// UpperTab.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CUpperTab window

class CUpperTab : public CTabCtrl
{
// Construction
public:
	CUpperTab();

// Attributes
public:

// Operations
public:

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CUpperTab)
	//}}AFX_VIRTUAL

// Implementation
public:
	void ActivateTabDialogs();
	void InitDialogs();
	virtual ~CUpperTab();

	// Generated message map functions
protected:
	//{{AFX_MSG(CUpperTab)
	afx_msg void OnSelchange(NMHDR* pNMHDR, LRESULT* pResult);
	//}}AFX_MSG

	DECLARE_MESSAGE_MAP()
private:
	int m_nPageCount;
	int m_iDialogID[3];
	CDialog* m_Dialog[3];
};

/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_UPPERTAB_H__9F846240_CEC6_4468_B118_7C97AC2E69DE__INCLUDED_)
