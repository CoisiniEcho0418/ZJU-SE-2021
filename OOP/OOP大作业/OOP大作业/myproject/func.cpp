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
//���ࣨ�㣩����������
class Point {
public:
	//����
	long x;
	long y;
	//����RGB��ɫ�õ�
	float cx;
	float cy;
	float cz;
	int pointsize;//��ϸ
	int model;//�Ƿ����
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

	virtual double getnum() = 0; //���麯����ͳ�Ƶ�ĸ���

};
//����
class LinePoint :public Point {
public:
	static int count1;//��¼����
	LinePoint() :Point(0, 0, 0, 0, 0, 1, 0) {}
	LinePoint(long a, long b, float c, float d, float e, int f, int g):Point(a,b,c,d,e,f,g){}
	double getnum() { return count1; }
};
int LinePoint::count1 = 0;
//��������
class TrianglePoint :public Point {
public:
	static int count2;//��¼����
	TrianglePoint() :Point(0, 0, 0, 0, 0, 1, 0) {}
	TrianglePoint(long a, long b, float c, float d, float e, int f, int g) :Point(a, b, c, d, e, f, g) {}
	double getnum() { return count2; }
};
int TrianglePoint::count2 = 0;
//������
class RectanglePoint :public Point {
public:
	static int count3;//��¼����
	RectanglePoint() :Point(0, 0, 0, 0, 0, 1, 0) {}
	RectanglePoint(long a, long b, float c, float d, float e, int f, int g) :Point(a, b, c, d, e, f, g) {}
	double getnum() { return count3; }
};
int RectanglePoint::count3 = 0;
//Բ��
class CirclePoint :public Point {
public:
	static int count4;//��¼����
	CirclePoint() :Point(0, 0, 0, 0, 0, 1, 0) {}
	CirclePoint(long a, long b, float c, float d, float e, int f, int g) :Point(a, b, c, d, e, f, g) {}
	double getnum() { return count4; }
};
int CirclePoint::count4 = 0;
//ƽ���ı�����
class RectangleParralPoint :public Point {
public:
	static int count5;//��¼����
	RectangleParralPoint() :Point(0, 0, 0, 0, 0, 1, 0) {}
	RectangleParralPoint(long a, long b, float c, float d, float e, int f, int g) :Point(a, b, c, d, e, f, g) {}
	double getnum() { return count5; }
};
int RectangleParralPoint::count5 = 0;
//��������
class SixBianXingPoint :public Point {
public:
	static int count6;//��¼����
	SixBianXingPoint() :Point(0, 0, 0, 0, 0, 1, 0) {}
	SixBianXingPoint(long a, long b, float c, float d, float e, int f, int g) :Point(a, b, c, d, e, f, g) {}
	double getnum() { return count6; }
};
int SixBianXingPoint::count6 = 0;
//��Բ��
class TuoYuanPoint :public Point {
public:
	static int count7;//��¼����
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
	//����
	long x;
	long y;
	//����RGB��ɫ�õ�
	float cx;
	float cy;
	float cz;
	int pointsize;//��ϸ
	int model;//�Ƿ����
};//�����Ľṹ��
int count1 = 0;//��ĸ��� ��
point point1[400];//������鼯
int count2 = 0;//��ĸ��� ������
point point2[400];//������鼯
int count3 = 0;//��ĸ��� ����
point point3[400];//������鼯
int count4 = 0;//��ĸ��� Բ
point point4[400];//������鼯

int count5 = 0;//��ĸ��� ƽ���ı���
point point5[400];//������鼯

int count6 = 0;//��ĸ��� ������
point point6[400];//������鼯

int count7 = 0;//��ĸ��� ��Բ
point point7[400];//������鼯
*/

float cx = 1.0, cy = 0, cz = 0;
int n = 30000;//����Բ�ľ���
int shape = 1;//��¼����Ҫ������״����
int color = 1;//��¼����Ҫ������ɫ
int ptsize = 1.0;//��ϸ
int fillmodel = 0;//��0���߿�1����䣩
int screenWidth = 600;
int screenHeight = 600;

//���ص㼯
void LoadPoints();
//����㼯
void SavePoints();
//��ʾ����
void myDisplay();

//��������
void selectFont(int size, int charset, const char* face) {
	HFONT hFont = CreateFontA(size, 0, 0, 0, FW_MEDIUM, 0, 0, 0,
		charset, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS,
		DEFAULT_QUALITY, DEFAULT_PITCH | FF_SWISS, face);
	HFONT hOldFont = (HFONT)SelectObject(wglGetCurrentDC(), hFont);
	DeleteObject(hOldFont);
}
//�������ַ�
void drawCNString(const char* str) {
	int len, i;
	wchar_t* wstring;
	HDC hDC = wglGetCurrentDC();
	GLuint lista = glGenLists(1);

	// �����ַ��ĸ���
	// �����˫�ֽ��ַ��ģ����������ַ����������ֽڲ���һ���ַ�
	// ����һ���ֽ���һ���ַ�
	len = 0;
	for (i = 0; str[i] != '\0'; ++i)
	{
		if (IsDBCSLeadByte(str[i]))
			++i;
		++len;
	}
	// ������ַ�ת��Ϊ���ַ�
	wstring = (wchar_t*)malloc((len + 1) * sizeof(wchar_t));
	MultiByteToWideChar(CP_ACP, MB_PRECOMPOSED, str, -1, wstring, len);
	wstring[len] = L'\0';
	// �������ַ�
	for (i = 0; i < len; ++i)
	{
		wglUseFontBitmapsW(hDC, wstring[i], 1, lista);
		glCallList(lista);
	}
	// ����������ʱ��Դ
	free(wstring);
	glDeleteLists(lista, 1);
}

//��ɫ�˵�
void colorSubMenu(int colorOption)
{
	color = colorOption;
}
//ͼ�β˵�
void shapeSubMenu(int shapeOption)
{
	shape = shapeOption;
}
//��ϸ�˵�
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
//���˵�
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
//���ڲ˵�������λ�ã�
void WindowSubMenu(int data) {
	int wwidth, wheight;//��Ļ�ĳߴ����
	int swidth, sheight;//����Ĵ��ڲ���
	int x, y;//�����λ�ò���
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
//���˵�
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


//�����˵�
void createGLUTMenus() {

	int menu;//�������˵�
	int subMenu1; //�����Ӳ˵�
	int subMenu2; //�����Ӳ˵�
	int subMenu3; //�����Ӳ˵�
	int subMenu4; //�����Ӳ˵�
	int subMenu5; //�����Ӳ˵�

	subMenu1 = glutCreateMenu(shapeSubMenu);
	glutAddMenuEntry("ֱ��", 1);
	glutAddMenuEntry("������", 2);
	glutAddMenuEntry("����", 3);
	glutAddMenuEntry("Բ��", 4);
	glutAddMenuEntry("ƽ���ı���", 5);
	glutAddMenuEntry("������", 6);
	glutAddMenuEntry("��Բ", 7);

	subMenu2 = glutCreateMenu(colorSubMenu);
	glutAddMenuEntry("��", 1);
	glutAddMenuEntry("��", 2);
	glutAddMenuEntry("��", 3);
	glutAddMenuEntry("��", 4);
	glutAddMenuEntry("��", 5);
	subMenu3 = glutCreateMenu(ptsizeSubMenu);
	glutAddMenuEntry("1", 1);
	glutAddMenuEntry("2", 2);
	glutAddMenuEntry("3", 3);
	subMenu4 = glutCreateMenu(fillmodelSubMenu);
	glutAddMenuEntry("���", 1);
	glutAddMenuEntry("�߿�", 2);

	subMenu5 = glutCreateMenu(WindowSubMenu);
	glutAddMenuEntry("����", 1);
	glutAddMenuEntry("����", 2);
	glutAddMenuEntry("����", 3);
	glutAddMenuEntry("����", 4);
	glutAddMenuEntry("����", 5);
	glutAddMenuEntry("ȫ��", 6);
	glutAddMenuEntry("�˳�ȫ��(�밴d��D��)", 7);
	glutAttachMenu(GLUT_RIGHT_BUTTON);

	//�������˵�������
	menu = glutCreateMenu(mainMenu);
	//�������˵���Ϊ��һ���˵����Ӳ˵�
	glutAddSubMenu("ͼ��", subMenu1);
	glutAddSubMenu("��ɫ", subMenu2);
	glutAddSubMenu("��ϸ", subMenu3);
	glutAddSubMenu("ģʽ", subMenu4);
	glutAddSubMenu("����", subMenu5);
	glutAddMenuEntry("����", 1);
	glutAddMenuEntry("����", 2);
	glutAddMenuEntry("���", 3);
	//�������Ҽ�ʱ��ʾ�˵�
	glutAttachMenu(GLUT_RIGHT_BUTTON);

}
//���̴�����
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


//����
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
//������
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
//�����ı��� 2���а�Բ��α��Բ��
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
//��ƽ���ı���
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
//����������
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
	GLfloat R = sqrt(_m) / 2;//�뾶
	GLfloat x = (x1 + x2) / 2;//Բ�ĺ�����
	GLfloat y = (y1 + y2) / 2;//Բ��������
	glBegin(GL_LINE_LOOP);
	for (int i = 0; i < m; ++i)
		glVertex2f(x + R * cos(2 * Pi / m * i), y + R * sin(2 * Pi / m * i));
	glEnd();
	//�������������
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
//��������
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
//��Բ
void drawCircle(int x1, int y1, int x2, int y2, float _x, float _y, float _z, int _ptsize, int _fillmodel)
{
	if (_fillmodel)
		glPolygonMode(GL_FRONT_AND_BACK, GL_FILL);
	else
		glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);
	glLineWidth(_ptsize);
	glColor3f(_x, _y, _z);
	float  _m = (x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2);
	GLfloat R = sqrt(_m) / 2;//�뾶
	GLfloat x = (x1 + x2) / 2;//Բ�ĺ�����
	GLfloat y = (y1 + y2) / 2;//Բ��������
	glBegin(GL_LINE_LOOP);
	for (int i = 0; i < n; ++i)
		glVertex2f(x + R * cos(2 * Pi / n * i), y + R * sin(2 * Pi / n * i));
	glEnd();

	/*	glBegin(GL_POLYGON);
		for(int i=0;i<n;i++)
			glVertex2f(x+R*cos(2*Pi/n*i), y+R*sin(2*Pi/n*i));
		glEnd()*/;
}
//��ʾ����
void myDisplay()
{
	glMatrixMode(GL_MODELVIEW);
	glLoadIdentity();
	glClear(GL_COLOR_BUFFER_BIT);            //����

	
	/*
	//���ַ�
	glColor3f(0, 0, 0);
	selectFont(18, DEFAULT_CHARSET, "���ķ���");
	glRasterPos2f(0.1, 0.1);
	drawCNString("��ת��ť");
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
	//glFlush();       //�������������ʾ�豸
	glutSwapBuffers();

}
//��ʾ����
void itDisplay()
{
	glMatrixMode(GL_MODELVIEW);
	glLoadIdentity();
	glClear(GL_COLOR_BUFFER_BIT);            //����
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
	glFlush();       //�������������ʾ�豸
	//glutPostRedisplay();
}
//����¼�
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
//��갴ס�ƶ��¼�
void myMotion(int x, int y)
{
	switch (shape)
	{
	case 1://��
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
//����ɿ��ƶ��¼�
void myPassiveMotion(int x, int y)
{
	point2[TrianglePoint::count2].x = x;
	point2[TrianglePoint::count2].y = screenHeight - y;
	itDisplay();
}

//���ص㼯
void LoadPoints()
{
	int count, mode;
	//Point pt;  ���ܶ��崿����Ķ���error��
	LinePoint pt;  //������������
	FILE* fp;
	fopen_s(&fp, "1.txt", "r");//��ȡ�ļ�
	
	if (fp == NULL)
	{
		printf("�ļ���ʧ��\n");
		return;
	}
	fscanf_s(fp, "%d\n", &count);//��ȡ��ĸ���
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
//����㼯
void SavePoints()
{
	FILE* fp;
	fopen_s(&fp,"1.txt", "w");//д���ļ�
	if (fp == NULL)
	{
		printf("�ļ���ʧ��\n");
		return;
	}
	fprintf(fp, "%d\n", LinePoint::count1 + TrianglePoint::count2 + RectanglePoint::count3 + CirclePoint::count4 + RectangleParralPoint::count5 + SixBianXingPoint::count6 + TuoYuanPoint::count7);//д���ĸ���
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

