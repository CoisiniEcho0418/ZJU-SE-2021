// 3DPoint.cpp: implementation of the C3DPoint class.
//
//////////////////////////////////////////////////////////////////////

#include "stdafx.h"
#include "SketchEditor.h"
#include "3DPoint.h"

#ifdef _DEBUG
#undef THIS_FILE
static char THIS_FILE[]=__FILE__;
#define new DEBUG_NEW
#endif

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

C3DPoint::C3DPoint()
{
	C3DPoint(0.0f, 0.0f, 0.0f);
}

C3DPoint::~C3DPoint()
{
}

C3DPoint::C3DPoint(float fX, float fY, float fZ)
{
	X = fX;
	Y = fY;
	Z = fZ;
}
