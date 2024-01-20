// EdgeDlg.cpp : implementation file
//

#include "stdafx.h"
#include "SketchEditor.h"
#include "EdgeDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CEdgeDlg dialog


CEdgeDlg::CEdgeDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CEdgeDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CEdgeDlg)
	//}}AFX_DATA_INIT
}


void CEdgeDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CEdgeDlg)
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CEdgeDlg, CDialog)
	//{{AFX_MSG_MAP(CEdgeDlg)
		// NOTE: the ClassWizard will add message map macros here
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CEdgeDlg message handlers
