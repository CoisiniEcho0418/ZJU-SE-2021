// Camera.h: interface for the CCamera class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_CAMERA_H__4FA7CA49_60B2_49EC_BECE_9013697E23BA__INCLUDED_)
#define AFX_CAMERA_H__4FA7CA49_60B2_49EC_BECE_9013697E23BA__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

class CCamera  
{
public:
	void UpdateDistance(const short &zDelta);
	void UpdateAngle(const CPoint &MousePoint);
	void SetMouseDownPoint(const CPoint &ptMouseDown);
	void UpdateView(int n = 0);
	void ResetCamera();
	CCamera();
	virtual ~CCamera();

private:
	CPoint m_ptMouseDown;
	GLdouble m_zPos;
	GLdouble m_yAngle;
	GLdouble m_xAngle;
};

#endif // !defined(AFX_CAMERA_H__4FA7CA49_60B2_49EC_BECE_9013697E23BA__INCLUDED_)
