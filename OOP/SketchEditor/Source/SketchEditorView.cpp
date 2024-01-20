// SketchEditorView.cpp : implementation of the CSketchEditorView class
//

#include "stdafx.h"
#include "SketchEditor.h"

#include "SketchEditorDoc.h"
#include "SketchEditorView.h"

//#include "glm.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CSketchEditorView

IMPLEMENT_DYNCREATE(CSketchEditorView, CView)

BEGIN_MESSAGE_MAP(CSketchEditorView, CView)
	//{{AFX_MSG_MAP(CSketchEditorView)
	ON_WM_CREATE()
	ON_WM_SIZE()
	ON_WM_LBUTTONDOWN()
	ON_WM_LBUTTONUP()
	ON_WM_MOUSEMOVE()
	ON_WM_MOUSEWHEEL()
	ON_COMMAND(ID_INPUT_SKETCH, OnInputSketch)
	ON_WM_RBUTTONDOWN()
	ON_WM_RBUTTONUP()
	ON_COMMAND(ID_OUTPUT_SKETCH, OnOutputSketch)
	//}}AFX_MSG_MAP
	// Standard printing commands
	ON_COMMAND(ID_FILE_PRINT, CView::OnFilePrint)
	ON_COMMAND(ID_FILE_PRINT_DIRECT, CView::OnFilePrint)
	ON_COMMAND(ID_FILE_PRINT_PREVIEW, CView::OnFilePrintPreview)
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CSketchEditorView construction/destruction

CSketchEditorView::CSketchEditorView()
{
	// TODO: add construction code here
}

CSketchEditorView::~CSketchEditorView()
{
}

BOOL CSketchEditorView::PreCreateWindow(CREATESTRUCT& cs)
{
	// TODO: Modify the Window class or styles here by modifying
	//  the CREATESTRUCT cs
	
	//set proper OpenGL window flags
	cs.style |= WS_CLIPSIBLINGS | WS_CLIPCHILDREN;

	return CView::PreCreateWindow(cs);
}

/////////////////////////////////////////////////////////////////////////////
// CSketchEditorView drawing

void CSketchEditorView::OnDraw(CDC* pDC)
{
	CSketchEditorDoc* pDoc = GetDocument();
	ASSERT_VALID(pDoc);
	// TODO: add draw code for native data here

	//Clear out the color & depth buffers
	::glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

	//Call render
	RenderScene();

	//Flush OpenGL's pipeline
	::glFinish();

	//Swap the buffers
	::SwapBuffers(m_pDC->GetSafeHdc());
}

/////////////////////////////////////////////////////////////////////////////
// CSketchEditorView printing

BOOL CSketchEditorView::OnPreparePrinting(CPrintInfo* pInfo)
{
	// default preparation
	return DoPreparePrinting(pInfo);
}

void CSketchEditorView::OnBeginPrinting(CDC* /*pDC*/, CPrintInfo* /*pInfo*/)
{
	// TODO: add extra initialization before printing
}

void CSketchEditorView::OnEndPrinting(CDC* /*pDC*/, CPrintInfo* /*pInfo*/)
{
	// TODO: add cleanup after printing
}

/////////////////////////////////////////////////////////////////////////////
// CSketchEditorView diagnostics

#ifdef _DEBUG
void CSketchEditorView::AssertValid() const
{
	CView::AssertValid();
}

void CSketchEditorView::Dump(CDumpContext& dc) const
{
	CView::Dump(dc);
}

CSketchEditorDoc* CSketchEditorView::GetDocument() // non-debug version is inline
{
	ASSERT(m_pDocument->IsKindOf(RUNTIME_CLASS(CSketchEditorDoc)));
	return (CSketchEditorDoc*)m_pDocument;
}
#endif //_DEBUG

/////////////////////////////////////////////////////////////////////////////
// CSketchEditorView message handlers

BOOL CSketchEditorView::InitializeOpenGL()
{
	GetDocument()->m_bShowObject = TRUE;
	GetDocument()->m_bShowUserEdge = FALSE;
	m_bDrawing = FALSE;

	//Get a DC for the client area
	m_pDC = new CClientDC(this);

	//If fail to do so
	if(m_pDC == NULL)
	{
		MessageBox("Error Obtaining DC");
		return FALSE;
	}

	//If fail to set the pixel format
	if(!SetupPixelFormat())
	{
		return FALSE;
	}

	//Create rendering context
	m_hRC = ::wglCreateContext(m_pDC->GetSafeHdc());

	//If fail to create rendering context
	if(m_hRC == 0)
	{
		MessageBox("Error Creating RC");
		return FALSE;
	}

	//Make the RC Current
	if(::wglMakeCurrent(m_pDC->GetSafeHdc(), m_hRC) == FALSE)
	{
		MessageBox("Error making RC Current");
		return FALSE;
	}

	//Specify Black as the clear color
	::glClearColor(0.0f, 0.0f, 0.0f, 1.0f);

	//Specify the back of the buffer as clear depth
	::glClearDepth(1.0f);

	SetupLighting();

	//Enable depth testing
	glDepthFunc (GL_LEQUAL);
    glEnable(GL_DEPTH_TEST);


    glEnable(GL_CULL_FACE);

	return TRUE;
}

BOOL CSketchEditorView::SetupPixelFormat()
{
	//Pixel format structure
	static PIXELFORMATDESCRIPTOR pfd = 
	{
		sizeof(PIXELFORMATDESCRIPTOR),			//size of thes pfd
		1,										//version number
		PFD_DRAW_TO_WINDOW |					//support window
		PFD_SUPPORT_OPENGL |					//support OpenL
		PFD_DOUBLEBUFFER,						//double buffered
		PFD_TYPE_RGBA,							//RGBA type
		24,										//24-bit color depth
		0, 0, 0, 0, 0, 0,						//color bits ignored
		0,										//no alpha buffer
		0,										//shift bit ignored
		0,										//no accumulation buffer
		0, 0, 0, 0,								//accumulation bits ignored
		16,										//16-bit z-buffer
		0,										//no auxiliary buffer
		PFD_MAIN_PLANE,							//main layer
		0,										//reserved
		0, 0, 0									//layer masks ignored
	};
	
	//Choose pixel format
	int m_nPixelFormat = ::ChoosePixelFormat(m_pDC->GetSafeHdc(), &pfd);

	//If fail to choose pixel format
	if(m_nPixelFormat == 0)
	{
		return FALSE;
	}

	//Set pixel format
	if(::SetPixelFormat(m_pDC->GetSafeHdc(), m_nPixelFormat, &pfd) == FALSE)
	{
		return FALSE;
	}

	//Everything is fine
	return TRUE;
}

int CSketchEditorView::OnCreate(LPCREATESTRUCT lpCreateStruct) 
{
	if (CView::OnCreate(lpCreateStruct) == -1)
		return -1;
	
	// TODO: Add your specialized creation code here
	InitializeOpenGL();
	
	return 0;
}

void CSketchEditorView::OnSize(UINT nType, int cx, int cy) 
{
	CView::OnSize(nType, cx, cy);
	
	// TODO: Add your message handler code here
	// width/height ratio
	GLdouble aspect_ratio;

	if(cx <= 0 || cy <=0)
	{
		return;
	}

	//Select the full client area
	::glViewport(0, 0, cx, cy);

	//Compute the aspect ratio
	aspect_ratio = (GLdouble)cx/(GLdouble)cy;

	//Select the projection matrix and clear it
	::glMatrixMode(GL_PROJECTION);
	::glLoadIdentity();

	//Select the viewing volume
	::gluPerspective(45.0f, aspect_ratio, 0.01f, 200.0f);

	//Switch back to the modelview matrix and clear it
	::glMatrixMode(GL_MODELVIEW);
	::glLoadIdentity();
}

void CSketchEditorView::RenderScene()
{
	DrawScene();
	/*
	DrawBackGround();

	glDisable(GL_LIGHTING);
	//Update Camera View
	m_Camera.UpdateView();
	glEnable(GL_LIGHTING);

	//Draw a teapot test purpose
	//glColor3f(0.0f,0.0f,0.0f);
	//glutWireTeapot(1.0f);

	DrawObject();
	//glPopMatrix();
	glFlush();
	*/
}

void CSketchEditorView::OnLButtonDown(UINT nFlags, CPoint point) 
{
	// TODO: Add your message handler code here and/or call default

	//Set Mouse down point
	m_Camera.SetMouseDownPoint(point);
	SetCapture();

	CView::OnLButtonDown(nFlags, point);
}

void CSketchEditorView::OnLButtonUp(UINT nFlags, CPoint point) 
{
	// TODO: Add your message handler code here and/or call default
	
	//Clear Mouse down point
	m_Camera.SetMouseDownPoint(CPoint(0, 0));
	ReleaseCapture();

	CView::OnLButtonUp(nFlags, point);
}

void CSketchEditorView::OnMouseMove(UINT nFlags, CPoint point) 
{
	// TODO: Add your message handler code here and/or call default
	
	if(m_bDrawing)
	{
		InvalidateRect(NULL, FALSE);
	}

	//Update Camera Anlge
	if(GetCapture() == this)
	{
		m_Camera.UpdateAngle(point);
		InvalidateRect(NULL, FALSE);
	}
	CView::OnMouseMove(nFlags, point);
}

BOOL CSketchEditorView::OnMouseWheel(UINT nFlags, short zDelta, CPoint pt) 
{
	// TODO: Add your message handler code here and/or call default

	//Update distance
	m_Camera.UpdateDistance(zDelta);
	InvalidateRect(NULL, FALSE);
	
	return CView::OnMouseWheel(nFlags, zDelta, pt);
}

//DEL void CSketchEditorView::LoadModelsFromFiles(CString FilePath)
//DEL {
//DEL 	CSketchEditorDoc* pDoc = GetDocument();
//DEL 	ASSERT_VALID(pDoc);
//DEL 	GLfloat scalefactor = 0.0;
//DEL 
//DEL 	//Load Object from file
//DEL //	GLMmodel *object;
//DEL 
//DEL 	pDoc->m_GeomObject = glmReadOBJ(FilePath.GetBuffer(0));
//DEL 
//DEL 	if(! scalefactor)
//DEL 	{
//DEL 		//Create Unit vectors
//DEL 		scalefactor = glmUnitize(pDoc->m_GeomObject);
//DEL 	}
//DEL 	else
//DEL 	{
//DEL 		//Scale object properly
//DEL 		glmScale(pDoc->m_GeomObject, scalefactor);
//DEL 	}
//DEL 
//DEL 	//Scale object
//DEL 	glmScale(pDoc->m_GeomObject, 1.0);
//DEL 
//DEL 	glmFacetNormals(pDoc->m_GeomObject);
//DEL     //glmVertexNormals(object, 90.0);
//DEL 
//DEL 	//build a display list
//DEL 	m_ObjectList = glmList(pDoc->m_GeomObject, GLM_SMOOTH | GLM_MATERIAL);
//DEL 	
//DEL 	//Nuke the object
//DEL 	glmDelete(pDoc->m_GeomObject);
//DEL }

void CSketchEditorView::DrawScene()
{
	CSketchEditorDoc* pDoc = GetDocument();
 	ASSERT_VALID(pDoc);
	//Get Client Rect
	RECT rect;
	GetClientRect(&rect);

	//Calculate window's height and width
	int window_width = rect.right - rect.left;
	int window_height = rect.bottom - rect.top;

	//Clear Screen
	glClear(GL_COLOR_BUFFER_BIT);

	if(!m_bDrawing)
	{
		CWnd *pWnd = ::AfxGetMainWnd();
		pWnd->SetWindowText("SketchEditor");
	}

	//Draw 3 sections on screen
	for(int loop = 0; loop < 3; loop++)
	{
		//Initialize backgroud drawing
		if(loop == 0)
		{
			//Set size of background to fill the whole client area
			glViewport(0, 0, window_width, window_height);
			glMatrixMode(GL_PROJECTION);
			glLoadIdentity();
			gluOrtho2D(0, window_width, window_height, 0);
		}
		//Initialize object drawing
		if(loop == 1)
		{
			glViewport(0, 0, window_width, window_height);
			glMatrixMode(GL_PROJECTION);
			glLoadIdentity();
			gluPerspective(45.0f, 1.0, 0.01f, 200.0f);
		}
		//Initialize coordinate indicator drawing
		if(loop == 2)
		{
			glViewport(17*window_width/20, window_height/32, 
						window_width/6, window_height/6);
			glMatrixMode(GL_PROJECTION);
			glLoadIdentity();
			gluPerspective(45.0f, 1.0, 0.01f, 200.0f);
		}
		
		glMatrixMode(GL_MODELVIEW);
		glLoadIdentity();

		glClear(GL_DEPTH_BUFFER_BIT);

		//Draw backgroud
		if(loop == 0)
		{
			glDisable(GL_LIGHTING);
			glBegin(GL_POLYGON);
				glColor3f(0.0f, 0.0f, 0.36f);
				glVertex2f(window_width, 0);
				glVertex2f(0, 0);
				glColor3f(1.0f, 1.0f, 1.0f);
				glVertex2f(0, window_height);
				glVertex2f(window_width, window_height);
			glEnd();
			glEnable(GL_LIGHTING);
		}
		//Draw object
		if(loop == 1)
		{
			m_Camera.UpdateView(1);
			if(m_bDrawing)
			{
				POINT pt;
				GetCursorPos(&pt);
				ScreenToClient(&pt);

				GLint viewport[4];
				GLdouble modelview[16];
				GLdouble projection[16];
				GLfloat winX, winY, winZ;
				GLdouble posX, posY, posZ;

				glGetDoublev( GL_MODELVIEW_MATRIX, modelview );
				glGetDoublev( GL_PROJECTION_MATRIX, projection );
				glGetIntegerv( GL_VIEWPORT, viewport );

				winX = (float)pt.x;
				winY = (float)viewport[3] - (float)pt.y;
				glReadPixels( pt.x, int(winY), 1, 1, GL_DEPTH_COMPONENT, GL_FLOAT, &winZ );

				gluUnProject( winX, winY, winZ, modelview, projection, viewport, &posX, &posY, &posZ);
				
				
				CString Info ;
				CWnd *pWnd = ::AfxGetMainWnd();
				Info.Format("X = %lf, Y = %lf, Z = %lf",	posX, posY, posZ);
				//Info.Format("X = %d, Y = %d", pt.x, pt.y);
				pWnd->SetWindowText(Info.GetBuffer(0));
				
			}

			//m_Camera.UpdateView(1);
			//Draw Sketch
			if(pDoc->m_bShowUserEdge)
			{
				m_SketchLine.Display();
			}
			//Draw Object
			if(pDoc->m_bShowObject)
			{
				glCallList(pDoc->m_ObjectList);
			}
		}
		//Draw coordinate indicator
		if(loop == 2)
		{
			m_Camera.UpdateView();
			glDisable(GL_LIGHTING);
			//Draw x axis
			glColor3f(1.0f, 0.0f, 0.0f);
			glBegin(GL_LINES);
				glVertex3f(0.0f, 0.0f, 0.0f);
				glVertex3f(1.2f, 0.0f, 0.0f);
			glEnd();
			
			//Draw y axis
			glColor3f(0.0f, 1.0f, 0.0f);
			glBegin(GL_LINES);
				glVertex3f(0.0f, 0.0f, 0.0f);
				glVertex3f(0.0f, 1.2f, 0.0f);
			glEnd();
			
			//Draw z axis
			glColor3f(0.0f, 0.0f, 1.0f);
			glBegin(GL_LINES);
				glVertex3f(0.0f, 0.0f, 0.0f);
				glVertex3f(0.0f, 0.0f, 1.2f);
			glEnd();

			glColor3ub(129, 129, 129);
			glRasterPos3f(1.3f, 0.0f, 0.0f);
			glutBitmapCharacter(GLUT_BITMAP_HELVETICA_12, 'X');

			glRasterPos3f(0.0f, 1.3f, 0.0f);
			glutBitmapCharacter(GLUT_BITMAP_HELVETICA_12, 'Y');

			glRasterPos3f(0.0f, 0.0f, 1.3f);
			glutBitmapCharacter(GLUT_BITMAP_HELVETICA_12, 'Z');

			glEnable(GL_LIGHTING);
		}
	}

	glFlush();
}

//DEL void CSketchEditorView::OnFileOpen() 
//DEL {
//DEL 	// TODO: Add your command handler code here
//DEL 	CFileDialog OpenObjDlg(TRUE, NULL, NULL, OFN_OVERWRITEPROMPT,
//DEL 			"Obj Files (*.obj)|*.obj||All Files (*.*)|*.*||");
//DEL 	if(OpenObjDlg.DoModal() == IDOK)
//DEL 	{
//DEL 		//Load obj file
//DEL 		CString path = OpenObjDlg.GetPathName();
//DEL 		LoadModelsFromFiles(path);
//DEL 		InvalidateRect(NULL, FALSE);
//DEL 	}
//DEL }

void CSketchEditorView::SetupLighting()
{
	GLfloat light_pos[] = {2.0f, 2.0f, 2.0f, 1.0f};
	GLfloat light_Ka[] = {0.0f, 0.0f, 0.0f, 1.0f};
	GLfloat light_Kd[] = {1.0f, 1.0f, 1.0f, 1.0f};
	GLfloat light_Ks[] = {1.0f, 1.0f, 1.0f, 1.0f};

	glLightfv(GL_LIGHT0, GL_POSITION, light_pos);
	glLightfv(GL_LIGHT0, GL_AMBIENT, light_Ka);
	glLightfv(GL_LIGHT0, GL_DIFFUSE, light_Kd);
	glLightfv(GL_LIGHT0, GL_SPECULAR, light_Ks);

	glEnable(GL_LIGHTING);
    glEnable(GL_LIGHT0);
	glEnable(GL_LIGHT1);
    glLightModeli(GL_LIGHT_MODEL_TWO_SIDE, GL_TRUE);
}

void CSketchEditorView::DrawBackGround()
{
	//Get Client Rect
	RECT rect;
	GetClientRect(&rect);

	//Calculate the width of client area
	int iwidth = rect.right - rect.left;
	//Calculate the height of client area
	int iheight = rect.bottom - rect.top;

	//Clear screen
	glClear(GL_COLOR_BUFFER_BIT);

	glViewport(0, 0, iwidth, iheight);
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	gluOrtho2D(0, iwidth, iheight, 0);

	glClear (GL_DEPTH_BUFFER_BIT);

	glDisable(GL_LIGHTING);
	glBegin(GL_POLYGON);
		glColor3f(0.0f, 0.0f, 1.0f);
		glVertex2f(iwidth, 0);
		glVertex2f(0, 0);
		glColor3f(1.0f, 1.0f, 1.0f);
		glVertex2f(0, iheight);
		glVertex2f(iwidth, iheight);
	glEnd();
	glEnable(GL_LIGHTING);

	//glFlush();

	glViewport(0, 0, iwidth, iheight);
	//Select the projection matrix and clear it
	::glMatrixMode(GL_PROJECTION);
	::glLoadIdentity();

	//Select the viewing volume
	::gluPerspective(45.0f, iwidth/iheight, 0.01f, 200.0f);

	//Switch back to the modelview matrix and clear it
	::glMatrixMode(GL_MODELVIEW);
	::glLoadIdentity();
}

void CSketchEditorView::OnInputSketch() 
{
	// TODO: Add your command handler code here
	CFileDialog OpenObjDlg(TRUE, NULL, NULL, OFN_OVERWRITEPROMPT,
			"Skt Files (*.Skt)|*.skt||All Files (*.*)|*.*||");

	if(OpenObjDlg.DoModal() == IDOK)
	{
		//Open and Load skt file
		CString FilePath = OpenObjDlg.GetFileName();
		m_SketchLine.LoadFromFile(FilePath);
		InvalidateRect(NULL, FALSE);
	}
}

void CSketchEditorView::OnRButtonDown(UINT nFlags, CPoint point) 
{
	// TODO: Add your message handler code here and/or call default
	m_bDrawing = TRUE;

	CView::OnRButtonDown(nFlags, point);
}

void CSketchEditorView::OnRButtonUp(UINT nFlags, CPoint point) 
{
	// TODO: Add your message handler code here and/or call default
	m_bDrawing = FALSE;

	CView::OnRButtonUp(nFlags, point);
}

void CSketchEditorView::OnOutputSketch() 
{
	// TODO: Add your command handler code here
	CFileDialog SaveObjDlg(FALSE, ".skt", NULL, OFN_OVERWRITEPROMPT,
			"Skt Files (*.Skt)|*.skt||All Files (*.*)|*.*||");

	if(SaveObjDlg.DoModal() == IDOK)
	{
		//Get path and Save Skt file
		CString FilePath = SaveObjDlg.GetFileName();
		m_SketchLine.SaveToFile(FilePath);
	}

}
