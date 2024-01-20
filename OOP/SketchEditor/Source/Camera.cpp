// Camera.cpp: implementation of the CCamera class.
//
//////////////////////////////////////////////////////////////////////

#include "stdafx.h"
#include "SketchEditor.h"
#include "Camera.h"

#ifdef _DEBUG
#undef THIS_FILE
static char THIS_FILE[]=__FILE__;
#define new DEBUG_NEW
#endif

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

CCamera::CCamera()
{
	m_xAngle = 0;
	m_yAngle = 0;
	m_zPos	 = -5.0;
	m_ptMouseDown.x = 0;
	m_ptMouseDown.y = 0;
}

CCamera::~CCamera()
{
}

void CCamera::ResetCamera()
{
	//Reset members to initial value
	m_xAngle = 0;
	m_yAngle = 0;
	m_zPos	 = -5.0;
	m_ptMouseDown.x = 0;
	m_ptMouseDown.y = 0;

	//Update the view
	UpdateView();
}

void CCamera::UpdateView(int n)
{
	/*
	CString Info;
	Info.Format("x Angle = %f, y Angle = %f, z Pos = %f", m_xAngle, m_yAngle, m_zPos);
	CWnd *pWnd = AfxGetMainWnd();
	pWnd->SetWindowText(Info.GetBuffer(0));
	*/

	//Update view
	if(n != 0)
	{
		glTranslatef(0.0f, 0.0f, m_zPos);
	}
	else
		glTranslatef(0.0f, 0.0f, -5.0f);
	glRotatef(m_xAngle, 1.0f, 0.0f, 0.0f);
	glRotatef(m_yAngle, 0.0f, 1.0f, 0.0f);

}

void CCamera::SetMouseDownPoint(const CPoint &ptMouseDown)
{
	//Save point
	m_ptMouseDown = ptMouseDown;
}

void CCamera::UpdateAngle(const CPoint &MousePoint)
{
	//Calculate rotate angle
	m_xAngle += (MousePoint.y - m_ptMouseDown.y) / 3.6;
	m_yAngle += (MousePoint.x - m_ptMouseDown.x) / 3.6;
	m_ptMouseDown = MousePoint;
}

void CCamera::UpdateDistance(const short &zDelta)
{
	//Calculate zoom in & zoom out
	m_zPos += zDelta / WHEEL_DELTA;
}
