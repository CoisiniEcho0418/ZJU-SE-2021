// 3DPoint.h: interface for the C3DPoint class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_3DPOINT_H__37207FF3_E4AB_4D84_A364_9A57E519AA71__INCLUDED_)
#define AFX_3DPOINT_H__37207FF3_E4AB_4D84_A364_9A57E519AA71__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

class C3DPoint  
{
public:
	float X;
	float Y;
	float Z;
public:
	C3DPoint(float fX, float fY, float fZ);
	C3DPoint();
	virtual ~C3DPoint();
};

#endif // !defined(AFX_3DPOINT_H__37207FF3_E4AB_4D84_A364_9A57E519AA71__INCLUDED_)
