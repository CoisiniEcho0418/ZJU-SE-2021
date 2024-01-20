#if !defined(AFX_SRFRENDERDLG_H__C3E78397_CC64_4AF2_A096_53764FB10B78__INCLUDED_)
#define AFX_SRFRENDERDLG_H__C3E78397_CC64_4AF2_A096_53764FB10B78__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// SRFRenderDlg.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CSRFRenderDlg dialog

class CSRFRenderDlg : public CDialog
{
// Construction
public:
	CSRFRenderDlg(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CSRFRenderDlg)
	enum { IDD = IDD_SRF_RENDER };
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CSRFRenderDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CSRFRenderDlg)
	afx_msg void OnSrfRdnone();
	afx_msg void OnSrfRbsmooth();
	afx_msg void OnSrfUserEdge();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_SRFRENDERDLG_H__C3E78397_CC64_4AF2_A096_53764FB10B78__INCLUDED_)
