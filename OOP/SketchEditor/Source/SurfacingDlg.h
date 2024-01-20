#if !defined(AFX_SURFACINGDLG_H__6636B54B_E77A_4392_BACF_4E7C4CA382B0__INCLUDED_)
#define AFX_SURFACINGDLG_H__6636B54B_E77A_4392_BACF_4E7C4CA382B0__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// SurfacingDlg.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CSurfacingDlg dialog

class CSurfacingDlg : public CDialog
{
// Construction
public:
	CSurfacingDlg(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CSurfacingDlg)
	enum { IDD = IDD_SURFACING };
		// NOTE: the ClassWizard will add data members here
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CSurfacingDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CSurfacingDlg)
		// NOTE: the ClassWizard will add member functions here
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_SURFACINGDLG_H__6636B54B_E77A_4392_BACF_4E7C4CA382B0__INCLUDED_)
