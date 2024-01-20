#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include "glut.h"
#include <windows.h>
#include "GLAUX.H"	

#include <iostream>
using namespace std;

#define Pi 3.1415926536f


float z_num = 0;
//基类（点）——抽象类
class Point {
public:
	//坐标
	long x;
	long y;
	//定义RGB颜色用的
	float cx;
	float cy;
	float cz;
	int pointsize;//粗细
	int model;//是否填充
	Point() {
		x = 0;
		y = 0;
		cx = 0;
		cy = 0;
		cz = 0;
		pointsize = 1;
		model = 0;
	}
	Point(long a, long b, float c, float d, float e, int f, int g) :x(a), y(b), cx(c), cy(d), cz(e), pointsize(f), model(g) {}

	virtual double getnum() = 0; //纯虚函数，统计点的个数

};
//线类
class LinePoint :public Point {
public:
	static int count1;//记录个数
	LinePoint() :Point(0, 0, 0, 0, 0, 1, 0) {}
	LinePoint(long a, long b, float c, float d, float e, int f, int g):Point(a,b,c,d,e,f,g){}
	double getnum() { return count1; }
};
int LinePoint::count1 = 0;
//三角形类
class TrianglePoint :public Point {
public:
	static int count2;//记录个数
	TrianglePoint() :Point(0, 0, 0, 0, 0, 1, 0) {}
	TrianglePoint(long a, long b, float c, float d, float e, int f, int g) :Point(a, b, c, d, e, f, g) {}
	double getnum() { return count2; }
};
int TrianglePoint::count2 = 0;
//矩形类
class RectanglePoint :public Point {
public:
	static int count3;//记录个数
	RectanglePoint() :Point(0, 0, 0, 0, 0, 1, 0) {}
	RectanglePoint(long a, long b, float c, float d, float e, int f, int g) :Point(a, b, c, d, e, f, g) {}
	double getnum() { return count3; }
};
int RectanglePoint::count3 = 0;
//圆类
class CirclePoint :public Point {
public:
	static int count4;//记录个数
	CirclePoint() :Point(0, 0, 0, 0, 0, 1, 0) {}
	CirclePoint(long a, long b, float c, float d, float e, int f, int g) :Point(a, b, c, d, e, f, g) {}
	double getnum() { return count4; }
};
int CirclePoint::count4 = 0;
//平行四边形类
class RectangleParralPoint :public Point {
public:
	static int count5;//记录个数
	RectangleParralPoint() :Point(0, 0, 0, 0, 0, 1, 0) {}
	RectangleParralPoint(long a, long b, float c, float d, float e, int f, int g) :Point(a, b, c, d, e, f, g) {}
	double getnum() { return count5; }
};
int RectangleParralPoint::count5 = 0;
//六边形类
class SixBianXingPoint :public Point {
public:
	static int count6;//记录个数
	SixBianXingPoint() :Point(0, 0, 0, 0, 0, 1, 0) {}
	SixBianXingPoint(long a, long b, float c, float d, float e, int f, int g) :Point(a, b, c, d, e, f, g) {}
	double getnum() { return count6; }
};
int SixBianXingPoint::count6 = 0;
//椭圆类
class TuoYuanPoint :public Point {
public:
	static int count7;//记录个数
	TuoYuanPoint() :Point(0, 0, 0, 0, 0, 1, 0) {}
	TuoYuanPoint(long a, long b, float c, float d, float e, int f, int g) :Point(a, b, c, d, e, f, g) {}
	double getnum() { return count7; }
};
int TuoYuanPoint::count7 = 0;


LinePoint point1[400];
TrianglePoint point2[400];
RectanglePoint point3[400];
CirclePoint point4[400];
RectangleParralPoint point5[400];
SixBianXingPoint point6[400];
TuoYuanPoint point7[400];


/*
struct point {
	//坐标
	long x;
	long y;
	//定义RGB颜色用的
	float cx;
	float cy;
	float cz;
	int pointsize;//粗细
	int model;//是否填充
};//定义点的结构体
int count1 = 0;//点的个数 线
point point1[400];//点的数组集
int count2 = 0;//点的个数 三角形
point point2[400];//点的数组集
int count3 = 0;//点的个数 矩形
point point3[400];//点的数组集
int count4 = 0;//点的个数 圆
point point4[400];//点的数组集

int count5 = 0;//点的个数 平行四边形
point point5[400];//点的数组集

int count6 = 0;//点的个数 六边形
point point6[400];//点的数组集

int count7 = 0;//点的个数 椭圆
point point7[400];//点的数组集
*/

float cx = 1.0, cy = 0, cz = 0;
int n = 30000;//控制圆的精度
int shape = 1;//记录你想要画的形状类型
int color = 1;//记录你想要画的颜色
int ptsize = 1.0;//粗细
int fillmodel = 0;//（0：线框，1：填充）
int screenWidth = 600;
int screenHeight = 600;

//加载点集
void LoadPoints();
//保存点集
void SavePoints();
//显示函数
void myDisplay();

//设置字体
void selectFont(int size, int charset, const char* face) {
	HFONT hFont = CreateFontA(size, 0, 0, 0, FW_MEDIUM, 0, 0, 0,
		charset, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS,
		DEFAULT_QUALITY, DEFAULT_PITCH | FF_SWISS, face);
	HFONT hOldFont = (HFONT)SelectObject(wglGetCurrentDC(), hFont);
	DeleteObject(hOldFont);
}
//画中文字符
void drawCNString(const char* str) {
	int len, i;
	wchar_t* wstring;
	HDC hDC = wglGetCurrentDC();
	GLuint lista = glGenLists(1);

	// 计算字符的个数
	// 如果是双字节字符的（比如中文字符），两个字节才算一个字符
	// 否则一个字节算一个字符
	len = 0;
	for (i = 0; str[i] != '\0'; ++i)
	{
		if (IsDBCSLeadByte(str[i]))
			++i;
		++len;
	}
	// 将混合字符转化为宽字符
	wstring = (wchar_t*)malloc((len + 1) * sizeof(wchar_t));
	MultiByteToWideChar(CP_ACP, MB_PRECOMPOSED, str, -1, wstring, len);
	wstring[len] = L'\0';
	// 逐个输出字符
	for (i = 0; i < len; ++i)
	{
		wglUseFontBitmapsW(hDC, wstring[i], 1, lista);
		glCallList(lista);
	}
	// 回收所有临时资源
	free(wstring);
	glDeleteLists(lista, 1);
}

//颜色菜单
void colorSubMenu(int colorOption)
{
	color = colorOption;
}
//图形菜单
void shapeSubMenu(int shapeOption)
{
	shape = shapeOption;
}
//粗细菜单
void ptsizeSubMenu(int size)
{
	switch (size)
	{
	case 1:
		ptsize = 1.0;
		break;
	case 2:
		ptsize = 4.0;
		break;
	case 3:
		ptsize = 10.0;
		break;

	}
}
//填充菜单
void fillmodelSubMenu(int _model)
{
	switch (_model)
	{
	case 1:
		fillmodel = 1;
		break;
	case 2:
		fillmodel = 0;
		break;

	}
}
//窗口菜单（窗口位置）
void WindowSubMenu(int data) {
	int wwidth, wheight;//屏幕的尺寸参数
	int swidth, sheight;//画板的窗口参数
	int x, y;//画板的位置参数
	wwidth = glutGet(GLUT_WINDOW_WIDTH);
	wheight = glutGet(GLUT_WINDOW_HEIGHT);
	swidth = glutGet(GLUT_SCREEN_WIDTH);
	sheight = glutGet(GLUT_SCREEN_HEIGHT);
	switch (data)
	{
	case 1:
		x = (swidth - wwidth) / 2;
		y = (sheight - wheight) / 2;
		glutPositionWindow(x, y);
		glutReshapeWindow(wwidth, wheight);
		break;
	case 2:
		glutPositionWindow(0, 0);
		glutReshapeWindow(wwidth, wheight);
		break;
	case 3:
		x = swidth - wwidth;
		y = 0;
		glutPositionWindow(x, y);
		glutReshapeWindow(wwidth, wheight);
		break;
	case 4:
		x = 0;
		y = sheight - wheight;
		glutPositionWindow(x, y);
		glutReshapeWindow(wwidth, wheight);
		break;
	case 5:
		x = swidth - wwidth;
		y = sheight - wheight;
		glutPositionWindow(x, y);
		glutReshapeWindow(wwidth, wheight);
		break;
	case 6:
		glutFullScreen();
		break;
	default:
		break;
	}
}
//主菜单
void mainMenu(int renderingOption)
{
	switch (renderingOption)
	{
	case 1:
		LinePoint::count1 = 0;
		TrianglePoint::count2 = 0;
		RectanglePoint::count3 = 0;
		CirclePoint::count4 = 0;
		RectangleParralPoint::count5 = 0;
		SixBianXingPoint::count6 = 0;
		TuoYuanPoint::count7 = 0;
		LoadPoints();
		
		break;
	case 2:
		SavePoints();
		break;
	case 3:
		LinePoint::count1 = 0;
		TrianglePoint::count2 = 0;
		RectanglePoint::count3 = 0;
		CirclePoint::count4 = 0;
		RectangleParralPoint::count5 = 0;
		SixBianXingPoint::count6 = 0;
		TuoYuanPoint::count7 = 0;

		break;
	}

	glutPostRedisplay();
}


//创建菜单
void createGLUTMenus() {

	int menu;//定义主菜单
	int subMenu1; //定义子菜单
	int subMenu2; //定义子菜单
	int subMenu3; //定义子菜单
	int subMenu4; //定义子菜单
	int subMenu5; //定义子菜单

	subMenu1 = glutCreateMenu(shapeSubMenu);
	glutAddMenuEntry("直线", 1);
	glutAddMenuEntry("三角形", 2);
	glutAddMenuEntry("矩形", 3);
	glutAddMenuEntry("圆形", 4);
	glutAddMenuEntry("平行四边形", 5);
	glutAddMenuEntry("六边形", 6);
	glutAddMenuEntry("椭圆", 7);

	subMenu2 = glutCreateMenu(colorSubMenu);
	glutAddMenuEntry("红", 1);
	glutAddMenuEntry("绿", 2);
	glutAddMenuEntry("蓝", 3);
	glutAddMenuEntry("紫", 4);
	glutAddMenuEntry("黑", 5);
	subMenu3 = glutCreateMenu(ptsizeSubMenu);
	glutAddMenuEntry("1", 1);
	glutAddMenuEntry("2", 2);
	glutAddMenuEntry("3", 3);
	subMenu4 = glutCreateMenu(fillmodelSubMenu);
	glutAddMenuEntry("填充", 1);
	glutAddMenuEntry("线框", 2);

	subMenu5 = glutCreateMenu(WindowSubMenu);
	glutAddMenuEntry("居中", 1);
	glutAddMenuEntry("左上", 2);
	glutAddMenuEntry("右上", 3);
	glutAddMenuEntry("左下", 4);
	glutAddMenuEntry("右下", 5);
	glutAddMenuEntry("全屏", 6);
	glutAddMenuEntry("退出全屏(请按d或D键)", 7);
	glutAttachMenu(GLUT_RIGHT_BUTTON);

	//构建主菜单的内容
	menu = glutCreateMenu(mainMenu);
	//将两个菜单变为另一个菜单的子菜单
	glutAddSubMenu("图形", subMenu1);
	glutAddSubMenu("颜色", subMenu2);
	glutAddSubMenu("粗细", subMenu3);
	glutAddSubMenu("模式", subMenu4);
	glutAddSubMenu("窗口", subMenu5);
	glutAddMenuEntry("加载", 1);
	glutAddMenuEntry("保存", 2);
	glutAddMenuEntry("清除", 3);
	//点击鼠标右键时显示菜单
	glutAttachMenu(GLUT_RIGHT_BUTTON);

}
//键盘处理函数
void keyboard(unsigned char key, int x, int y)
{
	switch (key)
	{
	case 27:
		exit(0);
		break;
	case 'd':
	case 'D':
		glutReshapeWindow(screenWidth, screenHeight);
		glutPositionWindow(100, 100);
		break;
	default:
		break;

	}
}


//画线
void drawThread(int x1, int y1, int x2, int y2, float _x, float _y, float _z, int _ptsize, int _fillmodel)
{
	if (_fillmodel)
		glPolygonMode(GL_FRONT_AND_BACK, GL_FILL);
	else
		glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);
	glLineWidth(_ptsize);
	glColor3f(_x, _y, _z);
	glBegin(GL_LINE_STRIP);
	glVertex2i(x1, y1);
	glVertex2i(x2, y2);
	glEnd();
}
//画矩形
void drawRectangle(int x1, int y1, int x2, int y2, float _x, float _y, float _z, int _ptsize, int _fillmodel)
{


	if (_fillmodel)
		glPolygonMode(GL_FRONT_AND_BACK, GL_FILL);
	else
		glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);
	glLineWidth(_ptsize);
	glColor3f(_x, _y, _z);
	glBegin(GL_QUADS);
	glVertex2f(x1, y1);
	glVertex2f(x1, y2);
	glVertex2f(x2, y2);
	glVertex2f(x2, y1);
	glEnd();


}
//绘制四边形 2边有半圆（伪椭圆）
void DrawSiBianxing(int x1, int y1, int x2, int y2, float _x, float _y, float _z, int _ptsize, int _fillmodel)
{
	float len = 0;

	if (_fillmodel)
		glPolygonMode(GL_FRONT_AND_BACK, GL_FILL);
	else
		glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);
	glLineWidth(_ptsize);
	glColor3f(_x, _y, _z);
	glBegin(GL_LINES);
	glVertex2f(x2, y1);
	glVertex2f(x1, y1);
	glEnd();

	glBegin(GL_LINES);
	glVertex2f(x1, y2);
	glVertex2f(x2, y2);
	glEnd();

	float x = x1, y = (float)(y1 + y2) / 2.0, R = fabs(float(y2 - y1)) / 2.0;
	glBegin(GL_LINES);
	for (int i = 0; i < n; ++i)
	{
		glVertex2f(x + R * cos(Pi / n * i + Pi / 2.0), y + R * sin(Pi / n * i + Pi / 2.0));
		glVertex2f(x + R * cos(Pi / n * (i + 1) + Pi / 2.0), y + R * sin(Pi / n * (i + 1) + Pi / 2.0));
	}

	glEnd();

	x = x2;
	glBegin(GL_LINES);
	for (int i = 0; i < n; ++i)
	{

		glVertex2f(x + R * cos(Pi / n * i - Pi / 2.0), y + R * sin(Pi / n * i - Pi / 2.0));
		glVertex2f(x + R * cos(Pi / n * (i + 1) - Pi / 2.0), y + R * sin(Pi / n * (i + 1) - Pi / 2.0));
	}

	glEnd();
}
//画平行四边形
void drawRectangleParral(int x1, int y1, int x2, int y2, float _x, float _y, float _z, int _ptsize, int _fillmodel)
{
	float len = (x2 - x1) / 5;
	if (_fillmodel)
		glPolygonMode(GL_FRONT_AND_BACK, GL_FILL);
	else
		glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);
	glLineWidth(_ptsize);
	glColor3f(_x, _y, _z);
	glBegin(GL_QUADS);
	glVertex2i(x1, y1);
	glVertex2i(x1 - len, y2);
	glVertex2i(x2 - len, y2);
	glVertex2i(x2, y1);
	glEnd();


}
//绘制六边形
void DrawSixBianXing(int x1, int y1, int x2, int y2, float _x, float _y, float _z, int _ptsize, int _fillmodel)
{
	int m = 6;
	if (_fillmodel)
		glPolygonMode(GL_FRONT_AND_BACK, GL_FILL);
	else
		glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);
	glLineWidth(_ptsize);
	glColor3f(_x, _y, _z);
	float  _m = (x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2);
	GLfloat R = sqrt(_m) / 2;//半径
	GLfloat x = (x1 + x2) / 2;//圆心横坐标
	GLfloat y = (y1 + y2) / 2;//圆心纵坐标
	glBegin(GL_LINE_LOOP);
	for (int i = 0; i < m; ++i)
		glVertex2f(x + R * cos(2 * Pi / m * i), y + R * sin(2 * Pi / m * i));
	glEnd();
	//绘制填充六边形
	if (_fillmodel) {
		for (int i = 0; i < m; i++) {
			glBegin(GL_TRIANGLES);
				glVertex2f(x, y);
				glVertex2f(x + R * cos(2 * Pi / m * i), y + R * sin(2 * Pi / m * i));
				glVertex2f(x + R * cos(2 * Pi / m * (i+1)), y + R * sin(2 * Pi / m * (i+1)));
			glEnd();
		}
			
	}

}
//画三角形
void drawTriangle(int x1, int y1, int x2, int y2, int x3, int y3, float _x, float _y, float _z, int _ptsize, int _fillmodel)
{
	if (_fillmodel)
		glPolygonMode(GL_FRONT_AND_BACK, GL_FILL);
	else
		glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);
	glLineWidth(_ptsize);
	glColor3f(_x, _y, _z);
	glBegin(GL_LINE_LOOP);
	glVertex2i(x1, y1);
	glVertex2i(x2, y2);
	glVertex2i(x3, y3);
	glEnd();

	glBegin(GL_TRIANGLES);
	glVertex2i(x1, y1);
	glVertex2i(x2, y2);
	glVertex2i(x3, y3);
	glEnd();
}
//画圆
void drawCircle(int x1, int y1, int x2, int y2, float _x, float _y, float _z, int _ptsize, int _fillmodel)
{
	if (_fillmodel)
		glPolygonMode(GL_FRONT_AND_BACK, GL_FILL);
	else
		glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);
	glLineWidth(_ptsize);
	glColor3f(_x, _y, _z);
	float  _m = (x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2);
	GLfloat R = sqrt(_m) / 2;//半径
	GLfloat x = (x1 + x2) / 2;//圆心横坐标
	GLfloat y = (y1 + y2) / 2;//圆心纵坐标
	glBegin(GL_LINE_LOOP);
	for (int i = 0; i < n; ++i)
		glVertex2f(x + R * cos(2 * Pi / n * i), y + R * sin(2 * Pi / n * i));
	glEnd();

	/*	glBegin(GL_POLYGON);
		for(int i=0;i<n;i++)
			glVertex2f(x+R*cos(2*Pi/n*i), y+R*sin(2*Pi/n*i));
		glEnd()*/;
}
//显示函数
void myDisplay()
{
	glMatrixMode(GL_MODELVIEW);
	glLoadIdentity();
	glClear(GL_COLOR_BUFFER_BIT);            //清屏

	
	/*
	//画字符
	glColor3f(0, 0, 0);
	selectFont(18, DEFAULT_CHARSET, "华文仿宋");
	glRasterPos2f(0.1, 0.1);
	drawCNString("旋转按钮");
	*/

	if (LinePoint::count1 > 1)
	{
		for (int i = 0; i < LinePoint::count1 - 1; i = i + 2)
		{

			drawThread(point1[i].x, point1[i].y, point1[i + 1].x, point1[i + 1].y, point1[i].cx, point1[i].cy, point1[i].cz, point1[i].pointsize, point1[i].model);
		}
	}
	if (TrianglePoint::count2 % 3 == 0 || TrianglePoint::count2 % 3 == 1)
	{

		for (int i = 0; i + 2 <= TrianglePoint::count2 - 1; i = i + 3)
		{

			drawTriangle(point2[i].x, point2[i].y, point2[i + 1].x, point2[i + 1].y, point2[i + 2].x, point2[i + 2].y, point2[i].cx, point2[i].cy, point2[i].cz, point2[i].pointsize, point2[i].model);
		}
	}
	if (TrianglePoint::count2 % 3 == 2)
	{

		for (int i = 0; i + 2 <= TrianglePoint::count2 - 1; i = i + 3)
		{

			drawTriangle(point2[i].x, point2[i].y, point2[i + 1].x, point2[i + 1].y, point2[i + 2].x, point2[i + 2].y, point2[i].cx, point2[i].cy, point2[i].cz, point2[i].pointsize, point2[i].model);
		}
		drawThread(point2[TrianglePoint::count2 - 2].x, point2[TrianglePoint::count2 - 2].y, point2[TrianglePoint::count2 - 1].x, point2[TrianglePoint::count2 - 1].y, point2[TrianglePoint::count2 - 2].cx, point2[TrianglePoint::count2 - 2].cy, point2[TrianglePoint::count2 - 2].cz, point2[TrianglePoint::count2 - 2].pointsize, point2[TrianglePoint::count2 - 2].model);
	}
	if (RectanglePoint::count3 > 1)
	{
		for (int i = 0; i < RectanglePoint::count3 - 1; i = i + 2)
		{

			drawRectangle(point3[i].x, point3[i].y, point3[i + 1].x, point3[i + 1].y, point3[i].cx, point3[i].cy, point3[i].cz, point3[i].pointsize, point3[i].model);
		}
	}
	if (CirclePoint::count4 > 1)
	{
		for (int i = 0; i < CirclePoint::count4 - 1; i = i + 2)
		{

			drawCircle(point4[i].x, point4[i].y, point4[i + 1].x, point4[i + 1].y, point4[i].cx, point4[i].cy, point4[i].cz, point4[i].pointsize, point4[i].model);
		}
	}
	if (RectangleParralPoint::count5 > 1) {
		for (int i = 0; i <= RectangleParralPoint::count5 - 1; i = i + 2)
		{

			drawRectangleParral(point5[i].x, point5[i].y, point5[i + 1].x, point5[i + 1].y, point5[i].cx, point5[i].cy, point5[i].cz, point5[i].pointsize, point5[i].model);
		}
	}
	if (SixBianXingPoint::count6 > 1) {
		for (int i = 0; i <= SixBianXingPoint::count6 - 1; i = i + 2)
		{

			DrawSixBianXing(point6[i].x, point6[i].y, point6[i + 1].x, point6[i + 1].y, point6[i].cx, point6[i].cy, point6[i].cz, point6[i].pointsize, point6[i].model);
		}
	}
	if (TuoYuanPoint::count7 > 1) {
		for (int i = 0; i <= TuoYuanPoint::count7 - 1; i = i + 2)
		{

			DrawSiBianxing(point7[i].x, point7[i].y, point7[i + 1].x, point7[i + 1].y, point7[i].cx, point7[i].cy, point7[i].cz, point7[i].pointsize, point7[i].model);
		}
	}
	//glFlush();       //送所有输出到显示设备
	glutSwapBuffers();

}
//显示函数
void itDisplay()
{
	glMatrixMode(GL_MODELVIEW);
	glLoadIdentity();
	glClear(GL_COLOR_BUFFER_BIT);            //清屏
	switch (color)
	{
	case 1:
		//glColor3f(1.0,0.0,0.0);
		cx = 1.0; cy = 0; cz = 0;
		break;
	case 2:
		//glColor3f(0.0,1.0,0.0);
		cx = 0.0; cy = 1.0; cz = 0.0;
		break;
	case 3:
		//glColor3f(0.0,0.0,1.0);
		cx = 0.0; cy = 0; cz = 1.0;
		break;
	}
	for (int i = 0; i <= LinePoint::count1 - 1; i = i + 2)
	{

		drawThread(point1[i].x, point1[i].y, point1[i + 1].x, point1[i + 1].y, point1[i].cx, point1[i].cy, point1[i].cz, point1[i].pointsize, point1[i].model);
	}
	for (int i = 0; i + 2 <= TrianglePoint::count2; i = i + 3)
	{

		drawTriangle(point2[i].x, point2[i].y, point2[i + 1].x, point2[i + 1].y, point2[i + 2].x, point2[i + 2].y, point2[i].cx, point2[i].cy, point2[i].cz, point2[i].pointsize, point2[i].model);
	}
	if ((TrianglePoint::count2 + 1) % 3 == 2)
	{
		drawThread(point2[TrianglePoint::count2 - 1].x, point2[TrianglePoint::count2 - 1].y, point2[TrianglePoint::count2].x, point2[TrianglePoint::count2].y, point2[TrianglePoint::count2 - 1].cx, point2[TrianglePoint::count2 - 1].cy, point2[TrianglePoint::count2 - 1].cz, point2[TrianglePoint::count2 - 1].pointsize, point2[TrianglePoint::count2 - 1].model);
	}
	for (int i = 0; i <= RectanglePoint::count3 - 1; i = i + 2)
	{

		drawRectangle(point3[i].x, point3[i].y, point3[i + 1].x, point3[i + 1].y, point3[i].cx, point3[i].cy, point3[i].cz, point3[i].pointsize, point3[i].model);
	}
	for (int i = 0; i <= CirclePoint::count4 - 1; i = i + 2)
	{

		drawCircle(point4[i].x, point4[i].y, point4[i + 1].x, point4[i + 1].y, point4[i].cx, point4[i].cy, point4[i].cz, point4[i].pointsize, point4[i].model);
	}
	for (int i = 0; i <= RectangleParralPoint::count5 - 1; i = i + 2)
	{

		drawRectangleParral(point5[i].x, point5[i].y, point5[i + 1].x, point5[i + 1].y, point5[i].cx, point5[i].cy, point5[i].cz, point5[i].pointsize, point5[i].model);
	}
	for (int i = 0; i <= SixBianXingPoint::count6 - 1; i = i + 2)
	{

		DrawSixBianXing(point6[i].x, point6[i].y, point6[i + 1].x, point6[i + 1].y, point6[i].cx, point6[i].cy, point6[i].cz, point6[i].pointsize, point6[i].model);
	}
	for (int i = 0; i <= TuoYuanPoint::count7 - 1; i = i + 2)
	{

		DrawSiBianxing(point7[i].x, point7[i].y, point7[i + 1].x, point7[i + 1].y, point7[i].cx, point7[i].cy, point7[i].cz, point7[i].pointsize, point7[i].model);
	}
	glFlush();       //送所有输出到显示设备
	//glutPostRedisplay();
}
//鼠标事件
void myMouse(int button, int state, int x, int y)
{

	switch (color)
	{
	case 1:
		//glColor3f(1.0,0.0,0.0);
		cx = 1.0; cy = 0; cz = 0;
		break;
	case 2:
		//glColor3f(0.0,1.0,0.0);
		cx = 0.0; cy = 1.0; cz = 0.0;
		break;
	case 3:
		//glColor3f(0.0,0.0,1.0);
		cx = 0.0; cy = 0.0; cz = 1.0;
		break;
	case 4:
		//glColor3f(0.0,0.0,1.0);
		cx = 1.0; cy = 0.0; cz = 1.0;
		break;
	case 5:
		//glColor3f(0.0,0.0,1.0);
		cx = 0.0; cy = 0.0; cz = 0.0;
		break;
	}
	if (button == GLUT_LEFT_BUTTON)
	{
		if (state == GLUT_DOWN || state == GLUT_UP)
		{
			switch (shape)
			{
			case 1:
				point1[LinePoint::count1].x = x;
				point1[LinePoint::count1].y = screenHeight - y;
				point1[LinePoint::count1].cx = cx;
				point1[LinePoint::count1].cy = cy;
				point1[LinePoint::count1].cz = cz;
				point1[LinePoint::count1].pointsize = ptsize;
				point1[LinePoint::count1].model = fillmodel;
				LinePoint::count1++;
				myDisplay();
				break;
			case 3:
				point3[RectanglePoint::count3].x = x;
				point3[RectanglePoint::count3].y = screenHeight - y;
				point3[RectanglePoint::count3].cx = cx;
				point3[RectanglePoint::count3].cy = cy;
				point3[RectanglePoint::count3].cz = cz;
				point3[RectanglePoint::count3].pointsize = ptsize;
				point3[RectanglePoint::count3].model = fillmodel;
				RectanglePoint::count3++;
				myDisplay();
				break;
			case 4:
				point4[CirclePoint::count4].x = x;
				point4[CirclePoint::count4].y = screenHeight - y;
				point4[CirclePoint::count4].cx = cx;
				point4[CirclePoint::count4].cy = cy;
				point4[CirclePoint::count4].cz = cz;
				point4[CirclePoint::count4].pointsize = ptsize;
				point4[CirclePoint::count4].model = fillmodel;
				CirclePoint::count4++;
				myDisplay();
				break;
			case 5:
				point5[RectangleParralPoint::count5].x = x;
				point5[RectangleParralPoint::count5].y = screenHeight - y;
				point5[RectangleParralPoint::count5].cx = cx;
				point5[RectangleParralPoint::count5].cy = cy;
				point5[RectangleParralPoint::count5].cz = cz;
				point5[RectangleParralPoint::count5].pointsize = ptsize;
				point5[RectangleParralPoint::count5].model = fillmodel;
				RectangleParralPoint::count5++;
				myDisplay();
				break;
			case 6:
				point6[SixBianXingPoint::count6].x = x;
				point6[SixBianXingPoint::count6].y = screenHeight - y;
				point6[SixBianXingPoint::count6].cx = cx;
				point6[SixBianXingPoint::count6].cy = cy;
				point6[SixBianXingPoint::count6].cz = cz;
				point6[SixBianXingPoint::count6].pointsize = ptsize;
				point6[SixBianXingPoint::count6].model = fillmodel;
				SixBianXingPoint::count6++;
				myDisplay();
				break;
			case 7:
				point7[TuoYuanPoint::count7].x = x;
				point7[TuoYuanPoint::count7].y = screenHeight - y;
				point7[TuoYuanPoint::count7].cx = cx;
				point7[TuoYuanPoint::count7].cy = cy;
				point7[TuoYuanPoint::count7].cz = cz;
				point7[TuoYuanPoint::count7].pointsize = ptsize;
				point7[TuoYuanPoint::count7].model = fillmodel;
				TuoYuanPoint::count7++;
				myDisplay();
				break;
			}
		}
	}
	if (button == GLUT_LEFT_BUTTON)
	{
		if (state == GLUT_DOWN && shape == 2)
		{
			point2[TrianglePoint::count2].x = x;
			point2[TrianglePoint::count2].x = x;
			point2[TrianglePoint::count2].y = screenHeight - y;
			point2[TrianglePoint::count2].cx = cx;
			point2[TrianglePoint::count2].cy = cy;
			point2[TrianglePoint::count2].cz = cz;
			point2[TrianglePoint::count2].pointsize = ptsize;
			point2[TrianglePoint::count2].model = fillmodel;
			TrianglePoint::count2++;
			myDisplay();
		}
	}
}
//鼠标按住移动事件
void myMotion(int x, int y)
{
	switch (shape)
	{
	case 1://线
		point1[LinePoint::count1].x = x;
		point1[LinePoint::count1].y = screenHeight - y;
		itDisplay();
		break;
	case 3:
		point3[RectanglePoint::count3].x = x;
		point3[RectanglePoint::count3].y = screenHeight - y;
		itDisplay();
		break;
	case 4:
		point4[CirclePoint::count4].x = x;
		point4[CirclePoint::count4].y = screenHeight - y;
		itDisplay();
		break;
	case 5:
		point5[RectangleParralPoint::count5].x = x;
		point5[RectangleParralPoint::count5].y = screenHeight - y;
		itDisplay();
		break;
	case 6:
		point6[SixBianXingPoint::count6].x = x;
		point6[SixBianXingPoint::count6].y = screenHeight - y;
		itDisplay();
		break;
	case 7:
		point7[TuoYuanPoint::count7].x = x;
		point7[TuoYuanPoint::count7].y = screenHeight - y;
		itDisplay();
		break;
	}
}
//鼠标松开移动事件
void myPassiveMotion(int x, int y)
{
	point2[TrianglePoint::count2].x = x;
	point2[TrianglePoint::count2].y = screenHeight - y;
	itDisplay();
}

//加载点集
void LoadPoints()
{
	int count, mode;
	//Point pt;  不能定义纯虚类的对象（error）
	LinePoint pt;  //用来接收数据
	FILE* fp;
	fopen_s(&fp, "1.txt", "r");//读取文件
	
	if (fp == NULL)
	{
		printf("文件打开失败\n");
		return;
	}
	fscanf_s(fp, "%d\n", &count);//获取点的个数
	for (int i = 0; i < count; i++)
	{
		fscanf_s(fp, "%d %d %d %f %f %f %d %d \n", &mode, &pt.x, &pt.y, &pt.cx, &pt.cy, &pt.cz, &pt.pointsize, &pt.model);
		if (mode == 1)
		{
			point1[LinePoint::count1].x = pt.x;
			point1[LinePoint::count1].y = pt.y;
			point1[LinePoint::count1].cx = pt.cx;
			point1[LinePoint::count1].cy = pt.cy;
			point1[LinePoint::count1].cz = pt.cz;
			point1[LinePoint::count1].pointsize = pt.pointsize;
			point1[LinePoint::count1].model = pt.model;
			LinePoint::count1 += 1;
		}
		if (mode == 2)
		{
			point2[TrianglePoint::count2].x = pt.x;
			point2[TrianglePoint::count2].y = pt.y;
			point2[TrianglePoint::count2].cx = pt.cx;
			point2[TrianglePoint::count2].cy = pt.cy;
			point2[TrianglePoint::count2].cz = pt.cz;
			point2[TrianglePoint::count2].pointsize = pt.pointsize;
			point2[TrianglePoint::count2].model = pt.model;
			TrianglePoint::count2 += 1;
		}
		if (mode == 3)
		{
			point3[RectanglePoint::count3].x = pt.x;
			point3[RectanglePoint::count3].y = pt.y;
			point3[RectanglePoint::count3].cx = pt.cx;
			point3[RectanglePoint::count3].cy = pt.cy;
			point3[RectanglePoint::count3].cz = pt.cz;
			point3[RectanglePoint::count3].pointsize = pt.pointsize;
			point3[RectanglePoint::count3].model = pt.model;
			RectanglePoint::count3 += 1;
		}
		if (mode == 4)
		{
			point4[CirclePoint::count4].x = pt.x;
			point4[CirclePoint::count4].y = pt.y;
			point4[CirclePoint::count4].cx = pt.cx;
			point4[CirclePoint::count4].cy = pt.cy;
			point4[CirclePoint::count4].cz = pt.cz;
			point4[CirclePoint::count4].pointsize = pt.pointsize;
			point4[CirclePoint::count4].model = pt.model;
			CirclePoint::count4 += 1;
		}
		if (mode == 5)
		{
			point5[RectangleParralPoint::count5].x = pt.x;
			point5[RectangleParralPoint::count5].y = pt.y;
			point5[RectangleParralPoint::count5].cx = pt.cx;
			point5[RectangleParralPoint::count5].cy = pt.cy;
			point5[RectangleParralPoint::count5].cz = pt.cz;
			point5[RectangleParralPoint::count5].pointsize = pt.pointsize;
			point5[RectangleParralPoint::count5].model = pt.model;
			RectangleParralPoint::count5 += 1;
		}
		if (i > 400)
		{
			int a = 0;
		}
		if (mode == 6)
		{
			point6[SixBianXingPoint::count6].x = pt.x;
			point6[SixBianXingPoint::count6].y = pt.y;
			point6[SixBianXingPoint::count6].cx = pt.cx;
			point6[SixBianXingPoint::count6].cy = pt.cy;
			point6[SixBianXingPoint::count6].cz = pt.cz;
			point6[SixBianXingPoint::count6].pointsize = pt.pointsize;
			point6[SixBianXingPoint::count6].model = pt.model;
			SixBianXingPoint::count6 += 1;
		}
		if (mode == 7)
		{
			point7[TuoYuanPoint::count7].x = pt.x;
			point7[TuoYuanPoint::count7].y = pt.y;
			point7[TuoYuanPoint::count7].cx = pt.cx;
			point7[TuoYuanPoint::count7].cy = pt.cy;
			point7[TuoYuanPoint::count7].cz = pt.cz;
			point7[TuoYuanPoint::count7].pointsize = pt.pointsize;
			point7[TuoYuanPoint::count7].model = pt.model;
			TuoYuanPoint::count7 += 1;
		}

	}
	fclose(fp);
	//count4 -= 1;
}
//保存点集
void SavePoints()
{
	FILE* fp;
	fopen_s(&fp,"1.txt", "w");//写入文件
	if (fp == NULL)
	{
		printf("文件打开失败\n");
		return;
	}
	fprintf(fp, "%d\n", LinePoint::count1 + TrianglePoint::count2 + RectanglePoint::count3 + CirclePoint::count4 + RectangleParralPoint::count5 + SixBianXingPoint::count6 + TuoYuanPoint::count7);//写入点的个数
	for (int i = 0; i < LinePoint::count1; i++)
	{
		fprintf(fp, "%d %d %d %f %f %f %d %d\n", 1, point1[i].x, point1[i].y, point1[i].cx, point1[i].cy, point1[i].cz, point1[i].pointsize, point1[i].model);
	}
	for (int i = 0; i < TrianglePoint::count2; i++)
	{
		fprintf(fp, "%d %d %d %f %f %f %d %d\n", 2, point2[i].x, point2[i].y, point2[i].cx, point2[i].cy, point2[i].cz, point2[i].pointsize, point2[i].model);
	}
	for (int i = 0; i < RectanglePoint::count3; i++)
	{
		fprintf(fp, "%d %d %d %f %f %f %d %d\n", 3, point3[i].x, point3[i].y, point3[i].cx, point3[i].cy, point3[i].cz, point3[i].pointsize, point3[i].model);
	}
	for (int i = 0; i < CirclePoint::count4; i++)
	{
		fprintf(fp, "%d %d %d %f %f %f %d %d\n", 4, point4[i].x, point4[i].y, point4[i].cx, point4[i].cy, point4[i].cz, point4[i].pointsize, point4[i].model);
	}
	for (int i = 0; i < RectangleParralPoint::count5; i++)
	{
		fprintf(fp, "%d %d %d %f %f %f %d %d\n", 5, point5[i].x, point5[i].y, point5[i].cx, point5[i].cy, point5[i].cz, point5[i].pointsize, point5[i].model);
	}
	for (int i = 0; i < SixBianXingPoint::count6; i++)
	{
		fprintf(fp, "%d %d %d %f %f %f %d %d\n", 6, point6[i].x, point6[i].y, point6[i].cx, point6[i].cy, point6[i].cz, point6[i].pointsize, point6[i].model);
	}
	for (int i = 0; i < TuoYuanPoint::count7; i++)
	{
		fprintf(fp, "%d %d %d %f %f %f %d %d\n", 7, point7[i].x, point7[i].y, point7[i].cx, point7[i].cy, point7[i].cz, point7[i].pointsize, point7[i].model);
	}
	fclose(fp);



}

