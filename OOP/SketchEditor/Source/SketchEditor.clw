; CLW file contains information for the MFC ClassWizard

[General Info]
Version=1
LastClass=CSketchEditorDoc
LastTemplate=CDialog
NewFileInclude1=#include "stdafx.h"
NewFileInclude2=#include "SketchEditor.h"
LastPage=0

ClassCount=16
Class1=CSketchEditorApp
Class2=CSketchEditorDoc
Class3=CSketchEditorView
Class4=CMainFrame

ResourceCount=22
Resource1=IDD_SRF_RENDER
Resource2=IDD_MODIFY
Class5=CAboutDlg
Class6=CSRFRenderDlg
Resource3=IDD_CAMERA_CALIB
Class7=CTSRFRenderDlg
Resource4=IDD_SURFACING
Class8=CEdgeDlg
Resource5=IDD_TRIMMING
Class9=CCreateDlg
Resource6=IDD_ABOUTBOX
Class10=CModifyDlg
Resource7=IDD_TSRF_RENDER
Class11=CSurfacingDlg
Resource8=IDD_CREATE
Class12=CCameraCalibDlg
Resource9=IDR_MAINFRAME
Class13=CTrimmingDlg
Class14=CUpperTab
Class15=CLowerTab
Resource10=IDD_EDGE
Class16=CRightBar
Resource11=IDD_RIGHTBAR
Resource12=IDD_CAMERA_CALIB (English (U.S.))
Resource13=IDD_TRIMMING (English (U.S.))
Resource14=IDR_MAINFRAME (English (U.S.))
Resource15=IDD_MODIFY (English (U.S.))
Resource16=IDD_SRF_RENDER (English (U.S.))
Resource17=IDD_EDGE (English (U.S.))
Resource18=IDD_CREATE (English (U.S.))
Resource19=IDD_TSRF_RENDER (English (U.S.))
Resource20=IDD_SURFACING (English (U.S.))
Resource21=IDD_ABOUTBOX (English (U.S.))
Resource22=IDD_RIGHTBAR (English (U.S.))

[CLS:CSketchEditorApp]
Type=0
HeaderFile=SketchEditor.h
ImplementationFile=SketchEditor.cpp
Filter=N

[CLS:CSketchEditorDoc]
Type=0
HeaderFile=SketchEditorDoc.h
ImplementationFile=SketchEditorDoc.cpp
Filter=N
BaseClass=CDocument
VirtualFilter=DC

[CLS:CSketchEditorView]
Type=0
HeaderFile=SketchEditorView.h
ImplementationFile=SketchEditorView.cpp
Filter=C
BaseClass=CView
VirtualFilter=VWC
LastObject=CSketchEditorView


[CLS:CMainFrame]
Type=0
HeaderFile=MainFrm.h
ImplementationFile=MainFrm.cpp
Filter=T
LastObject=ID_FILE_OPEN




[CLS:CAboutDlg]
Type=0
HeaderFile=SketchEditor.cpp
ImplementationFile=SketchEditor.cpp
Filter=D
LastObject=CAboutDlg

[DLG:IDD_ABOUTBOX]
Type=1
Class=CAboutDlg
ControlCount=4
Control1=IDC_STATIC,static,1342177283
Control2=IDC_STATIC,static,1342308480
Control3=IDC_STATIC,static,1342308352
Control4=IDOK,button,1342373889

[MNU:IDR_MAINFRAME]
Type=1
Class=CMainFrame
Command1=ID_FILE_NEW
Command2=ID_FILE_OPEN
Command3=ID_FILE_SAVE
Command4=ID_FILE_SAVE_AS
Command5=ID_FILE_PRINT
Command6=ID_FILE_PRINT_PREVIEW
Command7=ID_FILE_PRINT_SETUP
Command8=ID_FILE_MRU_FILE1
Command9=ID_APP_EXIT
Command10=ID_EDIT_UNDO
Command11=ID_EDIT_CUT
Command12=ID_EDIT_COPY
Command13=ID_EDIT_PASTE
Command14=ID_VIEW_TOOLBAR
Command15=ID_VIEW_STATUS_BAR
Command16=ID_APP_ABOUT
CommandCount=16

[ACL:IDR_MAINFRAME]
Type=1
Class=CMainFrame
Command1=ID_FILE_NEW
Command2=ID_FILE_OPEN
Command3=ID_FILE_SAVE
Command4=ID_FILE_PRINT
Command5=ID_EDIT_UNDO
Command6=ID_EDIT_CUT
Command7=ID_EDIT_COPY
Command8=ID_EDIT_PASTE
Command9=ID_EDIT_UNDO
Command10=ID_EDIT_CUT
Command11=ID_EDIT_COPY
Command12=ID_EDIT_PASTE
Command13=ID_NEXT_PANE
Command14=ID_PREV_PANE
CommandCount=14

[TB:IDR_MAINFRAME]
Type=1
Class=?
Command1=ID_FILE_NEW
Command2=ID_FILE_OPEN
Command3=ID_FILE_SAVE
Command4=ID_EDIT_CUT
Command5=ID_EDIT_COPY
Command6=ID_EDIT_PASTE
Command7=ID_FILE_PRINT
Command8=ID_APP_ABOUT
CommandCount=8

[DLG:IDD_SRF_RENDER]
Type=1
Class=CSRFRenderDlg
ControlCount=13
Control1=IDC_SRF_BOUNDING_BOX,button,1342242819
Control2=IDC_SRF_BOUNDING_SPHERE,button,1342242819
Control3=IDC_SRF_POINTS,button,1342242819
Control4=IDC_SRF_WIREFRAME,button,1342242819
Control5=IDC_SRF_RBFLAT,button,1342177289
Control6=IDC_SRF_RBSMOOTH,button,1342177289
Control7=IDC_SRF_RBGHOST,button,1342177289
Control8=IDC_SRF_RBZEBRA,button,1342177289
Control9=IDC_SRF_RDNONE,button,1342177289
Control10=IDC_STATIC,button,1342177287
Control11=IDC_SRF_CNORMALS,button,1342242819
Control12=IDC_SRF_ORIG_EDGE,button,1342242819
Control13=IDC_SRF_USER_EDGE,button,1342242819

[CLS:CSRFRenderDlg]
Type=0
HeaderFile=SRFRenderDlg.h
ImplementationFile=SRFRenderDlg.cpp
BaseClass=CDialog
Filter=D
LastObject=CSRFRenderDlg
VirtualFilter=dWC

[DLG:IDD_TSRF_RENDER]
Type=1
Class=CTSRFRenderDlg
ControlCount=9
Control1=IDC_TSRF_POINTS,button,1342242819
Control2=IDC_TSRF_WIREFRAME,button,1342242819
Control3=IDC_TSRF_RBFLAT,button,1342177289
Control4=IDC_TSRF_RBSMOOTH,button,1342177289
Control5=IDC_TSRF_RBGHOST,button,1342177289
Control6=IDC_TSRF_RBZEBRA,button,1342177289
Control7=IDC_TSRF_RDNONE,button,1342177289
Control8=IDC_STATIC,button,1342177287
Control9=IDC_TSRF_CNORMALS,button,1342242819

[CLS:CTSRFRenderDlg]
Type=0
HeaderFile=TSRFRenderDlg.h
ImplementationFile=TSRFRenderDlg.cpp
BaseClass=CDialog
Filter=D
LastObject=CTSRFRenderDlg

[DLG:IDD_EDGE]
Type=1
Class=CEdgeDlg
ControlCount=0

[CLS:CEdgeDlg]
Type=0
HeaderFile=EdgeDlg.h
ImplementationFile=EdgeDlg.cpp
BaseClass=CDialog
Filter=D
LastObject=CEdgeDlg
VirtualFilter=dWC

[DLG:IDD_CREATE]
Type=1
Class=CCreateDlg
ControlCount=3
Control1=IDC_CREATE_SURFACE,button,1342242816
Control2=IDC_CREATE_SPACE,button,1342242816
Control3=IDC_CREATE_CLEAR,button,1342242816

[CLS:CCreateDlg]
Type=0
HeaderFile=CreateDlg.h
ImplementationFile=CreateDlg.cpp
BaseClass=CDialog
Filter=D
LastObject=CCreateDlg

[DLG:IDD_MODIFY]
Type=1
Class=CModifyDlg
ControlCount=4
Control1=IDC_MODIFY_MODIFY,button,1342242816
Control2=IDC_MODIFY_MODIFY_LOCAL,button,1342242816
Control3=IDC_MODIFY_SMOOTH,button,1342242816
Control4=IDC_MODIFY_CLEAR,button,1342242816

[CLS:CModifyDlg]
Type=0
HeaderFile=ModifyDlg.h
ImplementationFile=ModifyDlg.cpp
BaseClass=CDialog
Filter=D
LastObject=ID_FILE_NEW

[DLG:IDD_SURFACING]
Type=1
Class=CSurfacingDlg
ControlCount=19
Control1=IDC_SURFACING_SURFACE,button,1342242816
Control2=IDC_SURFACING_INFLATE,button,1342242816
Control3=IDC_SURFACE_LAPLC1,button,1342242816
Control4=IDC_SURFACING_LAPLC50,button,1342242816
Control5=IDC_SURFACING_SMOOTH,button,1342242816
Control6=IDC_SURFACING_FLIP,button,1342242816
Control7=IDC_SURFACING_PICK,button,1342242816
Control8=IDC_SURFACING_CHGCOLOR,button,1342242816
Control9=IDC_SURFACING_DELETE,button,1342242816
Control10=IDC_SBPRESSURE,msctls_trackbar32,1342242842
Control11=IDC_STATIC,static,1342308352
Control12=IDC_STATIC,static,1342308352
Control13=IDC_STATIC,static,1342308352
Control14=IDC_STATIC,button,1342177287
Control15=IDC_SURFACING_SHOWSRF,button,1342242819
Control16=IDC_STATIC,static,1342308352
Control17=IDC_EMAXPRESSURE,edit,1350631552
Control18=IDC_BMAXPRESSUREMINUS,button,1342242816
Control19=IDC_BMAXPRESSUREPLUS,button,1342242816

[CLS:CSurfacingDlg]
Type=0
HeaderFile=SurfacingDlg.h
ImplementationFile=SurfacingDlg.cpp
BaseClass=CDialog
Filter=D
LastObject=CSurfacingDlg

[DLG:IDD_CAMERA_CALIB]
Type=1
Class=CCameraCalibDlg
ControlCount=0

[CLS:CCameraCalibDlg]
Type=0
HeaderFile=CameraCalibDlg.h
ImplementationFile=CameraCalibDlg.cpp
BaseClass=CDialog
Filter=D
LastObject=CCameraCalibDlg

[DLG:IDD_TRIMMING]
Type=1
Class=CTrimmingDlg
ControlCount=5
Control1=IDC_STATIC,static,1342308352
Control2=IDC_STATIC,static,1342308352
Control3=IDC_TRIM_RBLJOINT,button,1342177289
Control4=IDC_TRIM_RTJOINT,button,1342177289
Control5=IDC_STATIC,button,1342177287

[CLS:CTrimmingDlg]
Type=0
HeaderFile=TrimmingDlg.h
ImplementationFile=TrimmingDlg.cpp
BaseClass=CDialog
Filter=D
LastObject=CTrimmingDlg

[CLS:CUpperTab]
Type=0
HeaderFile=UpperTab.h
ImplementationFile=UpperTab.cpp
BaseClass=CTabCtrl
Filter=W
LastObject=CUpperTab
VirtualFilter=UWC

[CLS:CLowerTab]
Type=0
HeaderFile=LowerTab.h
ImplementationFile=LowerTab.cpp
BaseClass=CTabCtrl
Filter=W
LastObject=CLowerTab
VirtualFilter=UWC

[DLG:IDD_RIGHTBAR]
Type=1
Class=CRightBar
ControlCount=2
Control1=IDC_TABUPPER,SysTabControl32,1342177280
Control2=IDC_TABLOWER,SysTabControl32,1342177280

[CLS:CRightBar]
Type=0
HeaderFile=RightBar.h
ImplementationFile=RightBar.cpp
BaseClass=CDialogBar
Filter=D
LastObject=CRightBar
VirtualFilter=dWC

[MNU:IDR_MAINFRAME (English (U.S.))]
Type=1
Class=CMainFrame
Command1=ID_FILE_NEW
Command2=ID_FILE_OPEN
Command3=ID_FILE_SAVE
Command4=ID_FILE_SAVE_AS
Command5=ID_FILE_PRINT
Command6=ID_FILE_PRINT_PREVIEW
Command7=ID_FILE_PRINT_SETUP
Command8=ID_FILE_MRU_FILE1
Command9=ID_APP_EXIT
Command10=ID_EDIT_UNDO
Command11=ID_EDIT_CUT
Command12=ID_EDIT_COPY
Command13=ID_EDIT_PASTE
Command14=ID_VIEW_TOOLBAR
Command15=ID_VIEW_STATUS_BAR
Command16=ID_FILE_OPEN
Command17=ID_INPUT_SKETCH
Command18=ID_OUTPUT_SKETCH
Command19=ID_APP_ABOUT
CommandCount=19

[DLG:IDD_TRIMMING (English (U.S.))]
Type=1
Class=CTrimmingDlg
ControlCount=5
Control1=IDC_STATIC,static,1342308352
Control2=IDC_STATIC,static,1342308352
Control3=IDC_TRIM_RBLJOINT,button,1342177289
Control4=IDC_TRIM_RTJOINT,button,1342177289
Control5=IDC_STATIC,button,1342177287

[DLG:IDD_TSRF_RENDER (English (U.S.))]
Type=1
Class=CTSRFRenderDlg
ControlCount=9
Control1=IDC_TSRF_POINTS,button,1342242819
Control2=IDC_TSRF_WIREFRAME,button,1342242819
Control3=IDC_TSRF_RBFLAT,button,1342177289
Control4=IDC_TSRF_RBSMOOTH,button,1342177289
Control5=IDC_TSRF_RBGHOST,button,1342177289
Control6=IDC_TSRF_RBZEBRA,button,1342177289
Control7=IDC_TSRF_RDNONE,button,1342177289
Control8=IDC_STATIC,button,1342177287
Control9=IDC_TSRF_CNORMALS,button,1342242819

[DLG:IDD_CAMERA_CALIB (English (U.S.))]
Type=1
Class=CCameraCalibDlg
ControlCount=0

[DLG:IDD_ABOUTBOX (English (U.S.))]
Type=1
Class=CAboutDlg
ControlCount=4
Control1=IDC_STATIC,static,1342177283
Control2=IDC_STATIC,static,1342308480
Control3=IDC_STATIC,static,1342308352
Control4=IDOK,button,1342373889

[DLG:IDD_MODIFY (English (U.S.))]
Type=1
Class=CModifyDlg
ControlCount=4
Control1=IDC_MODIFY_MODIFY,button,1342242816
Control2=IDC_MODIFY_MODIFY_LOCAL,button,1342242816
Control3=IDC_MODIFY_SMOOTH,button,1342242816
Control4=IDC_MODIFY_CLEAR,button,1342242816

[DLG:IDD_CREATE (English (U.S.))]
Type=1
Class=CCreateDlg
ControlCount=3
Control1=IDC_CREATE_SURFACE,button,1342242816
Control2=IDC_CREATE_SPACE,button,1342242816
Control3=IDC_CREATE_CLEAR,button,1342242816

[DLG:IDD_EDGE (English (U.S.))]
Type=1
Class=CEdgeDlg
ControlCount=0

[DLG:IDD_RIGHTBAR (English (U.S.))]
Type=1
Class=CRightBar
ControlCount=2
Control1=IDC_TABUPPER,SysTabControl32,1342177280
Control2=IDC_TABLOWER,SysTabControl32,1342177280

[DLG:IDD_SRF_RENDER (English (U.S.))]
Type=1
Class=CSRFRenderDlg
ControlCount=13
Control1=IDC_SRF_BOUNDING_BOX,button,1342242819
Control2=IDC_SRF_BOUNDING_SPHERE,button,1342242819
Control3=IDC_SRF_POINTS,button,1342242819
Control4=IDC_SRF_WIREFRAME,button,1342242819
Control5=IDC_SRF_RBFLAT,button,1342308361
Control6=IDC_SRF_RBSMOOTH,button,1342177289
Control7=IDC_SRF_RBGHOST,button,1342177289
Control8=IDC_SRF_RBZEBRA,button,1342177289
Control9=IDC_SRF_RDNONE,button,1342177289
Control10=IDC_STATIC,button,1342177287
Control11=IDC_SRF_CNORMALS,button,1342242819
Control12=IDC_SRF_ORIG_EDGE,button,1342242819
Control13=IDC_SRF_USER_EDGE,button,1342242819

[DLG:IDD_SURFACING (English (U.S.))]
Type=1
Class=CSurfacingDlg
ControlCount=19
Control1=IDC_SURFACING_SURFACE,button,1342242816
Control2=IDC_SURFACING_INFLATE,button,1342242816
Control3=IDC_SURFACE_LAPLC1,button,1342242816
Control4=IDC_SURFACING_LAPLC50,button,1342242816
Control5=IDC_SURFACING_SMOOTH,button,1342242816
Control6=IDC_SURFACING_FLIP,button,1342242816
Control7=IDC_SURFACING_PICK,button,1342242816
Control8=IDC_SURFACING_CHGCOLOR,button,1342242816
Control9=IDC_SURFACING_DELETE,button,1342242816
Control10=IDC_SBPRESSURE,msctls_trackbar32,1342242842
Control11=IDC_STATIC,static,1342308352
Control12=IDC_STATIC,static,1342308352
Control13=IDC_STATIC,static,1342308352
Control14=IDC_STATIC,button,1342177287
Control15=IDC_SURFACING_SHOWSRF,button,1342242819
Control16=IDC_STATIC,static,1342308352
Control17=IDC_EMAXPRESSURE,edit,1350631552
Control18=IDC_BMAXPRESSUREMINUS,button,1342242816
Control19=IDC_BMAXPRESSUREPLUS,button,1342242816

[TB:IDR_MAINFRAME (English (U.S.))]
Type=1
Class=?
Command1=ID_FILE_NEW
Command2=ID_FILE_OPEN
Command3=ID_FILE_SAVE
Command4=ID_EDIT_CUT
Command5=ID_EDIT_COPY
Command6=ID_EDIT_PASTE
Command7=ID_FILE_PRINT
Command8=ID_APP_ABOUT
CommandCount=8

[ACL:IDR_MAINFRAME (English (U.S.))]
Type=1
Class=?
Command1=ID_FILE_NEW
Command2=ID_FILE_OPEN
Command3=ID_FILE_SAVE
Command4=ID_FILE_PRINT
Command5=ID_EDIT_UNDO
Command6=ID_EDIT_CUT
Command7=ID_EDIT_COPY
Command8=ID_EDIT_PASTE
Command9=ID_EDIT_UNDO
Command10=ID_EDIT_CUT
Command11=ID_EDIT_COPY
Command12=ID_EDIT_PASTE
Command13=ID_NEXT_PANE
Command14=ID_PREV_PANE
CommandCount=14

