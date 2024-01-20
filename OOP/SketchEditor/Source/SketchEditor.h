// SketchEditor.h : main header file for the SKETCHEDITOR application
//

#if !defined(AFX_SKETCHEDITOR_H__52A9B35A_1BFA_42A7_810E_2A6F0538A476__INCLUDED_)
#define AFX_SKETCHEDITOR_H__52A9B35A_1BFA_42A7_810E_2A6F0538A476__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#ifndef __AFXWIN_H__
	#error include 'stdafx.h' before including this file for PCH
#endif

#include "resource.h"       // main symbols

/////////////////////////////////////////////////////////////////////////////
// CSketchEditorApp:
// See SketchEditor.cpp for the implementation of this class
//

class CSketchEditorApp : public CWinApp
{
public:
	CSketchEditorApp();

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CSketchEditorApp)
	public:
	virtual BOOL InitInstance();
	//}}AFX_VIRTUAL

// Implementation
	//{{AFX_MSG(CSketchEditorApp)
	afx_msg void OnAppAbout();
		// NOTE - the ClassWizard will add and remove member functions here.
		//    DO NOT EDIT what you see in these blocks of generated code !
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};


/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_SKETCHEDITOR_H__52A9B35A_1BFA_42A7_810E_2A6F0538A476__INCLUDED_)
