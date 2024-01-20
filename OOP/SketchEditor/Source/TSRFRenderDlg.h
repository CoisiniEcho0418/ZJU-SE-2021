#if !defined(AFX_TSRFRENDERDLG_H__143CABCB_A295_4572_B50F_D4560A033282__INCLUDED_)
#define AFX_TSRFRENDERDLG_H__143CABCB_A295_4572_B50F_D4560A033282__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// TSRFRenderDlg.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CTSRFRenderDlg dialog

class CTSRFRenderDlg : public CDialog
{
// Construction
public:
	CTSRFRenderDlg(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CTSRFRenderDlg)
	enum { IDD = IDD_TSRF_RENDER };
		// NOTE: the ClassWizard will add data members here
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CTSRFRenderDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CTSRFRenderDlg)
		// NOTE: the ClassWizard will add member functions here
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_TSRFRENDERDLG_H__143CABCB_A295_4572_B50F_D4560A033282__INCLUDED_)
