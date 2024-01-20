#if !defined(AFX_EDGEDLG_H__DE3DA0CC_8E0D_4F59_9EB3_EE34310841D4__INCLUDED_)
#define AFX_EDGEDLG_H__DE3DA0CC_8E0D_4F59_9EB3_EE34310841D4__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// EdgeDlg.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CEdgeDlg dialog

class CEdgeDlg : public CDialog
{
// Construction
public:
	CEdgeDlg(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CEdgeDlg)
	enum { IDD = IDD_EDGE };
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CEdgeDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CEdgeDlg)
		// NOTE: the ClassWizard will add member functions here
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_EDGEDLG_H__DE3DA0CC_8E0D_4F59_9EB3_EE34310841D4__INCLUDED_)
