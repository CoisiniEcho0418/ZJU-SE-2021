#if !defined(AFX_TRIMMINGDLG_H__494AABF6_3440_4E2E_A334_335F7DA0CEC1__INCLUDED_)
#define AFX_TRIMMINGDLG_H__494AABF6_3440_4E2E_A334_335F7DA0CEC1__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// TrimmingDlg.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CTrimmingDlg dialog

class CTrimmingDlg : public CDialog
{
// Construction
public:
	CTrimmingDlg(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CTrimmingDlg)
	enum { IDD = IDD_TRIMMING };
		// NOTE: the ClassWizard will add data members here
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CTrimmingDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CTrimmingDlg)
		// NOTE: the ClassWizard will add member functions here
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_TRIMMINGDLG_H__494AABF6_3440_4E2E_A334_335F7DA0CEC1__INCLUDED_)
