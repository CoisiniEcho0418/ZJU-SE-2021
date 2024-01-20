#if !defined(AFX_CAMERACALIBDLG_H__7ACAFB27_45E7_4317_A3F9_D7C2ED334E9F__INCLUDED_)
#define AFX_CAMERACALIBDLG_H__7ACAFB27_45E7_4317_A3F9_D7C2ED334E9F__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// CameraCalibDlg.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// CCameraCalibDlg dialog

class CCameraCalibDlg : public CDialog
{
// Construction
public:
	CCameraCalibDlg(CWnd* pParent = NULL);   // standard constructor

// Dialog Data
	//{{AFX_DATA(CCameraCalibDlg)
	enum { IDD = IDD_CAMERA_CALIB };
		// NOTE: the ClassWizard will add data members here
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CCameraCalibDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(CCameraCalibDlg)
		// NOTE: the ClassWizard will add member functions here
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_CAMERACALIBDLG_H__7ACAFB27_45E7_4317_A3F9_D7C2ED334E9F__INCLUDED_)
