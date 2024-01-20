#include <windows.h>
#include <cstdio>
#include <cstdlib>
#include <glut.h>
#include <cmath>
#include <ctime>
#include "func.h"
#include "GLAUX.H"
#include <iostream>
using namespace std;


#pragma comment(lib,"glut32.lib")
#pragma comment(lib,"glu32.lib")
#pragma comment(lib,"opengl32.lib")
#pragma comment( lib, "glaux.lib")		// GLaux连接库

//暂时没用
#define RED 1
#define GREEN 2
#define BLUE 3
#define WHITE 4

//
//global  窗口的大小参数
float g_fWidth = 600;
float g_fHeight = 600;
float g_fDepth = 100;
float g_fAngle = .0;

extern int shape;//记录你想要画的形状类型
extern int color;//记录你想要画的颜色
extern int ptsize;//大小
extern int fillmodel;


struct Button
{
	float m_fPosX;		//表示在正交投影坐标系(左下角为坐标原点)的坐标，
	float m_fPosY;
	float m_fWidth;		//屏幕像素单位
	float m_fHeight;

	bool m_bPressed;
	void Render()
	{
		glPushMatrix();
		{
			//将中心位于原点的cube移动到使cube左下角坐标为m_fPosX,m_fPosY的位置
			//必须考虑cube的自身长宽
			glTranslatef(m_fPosX + m_fWidth / 2, m_fPosY + m_fHeight / 2, -2.0);	//-2.0只是为了按钮可见
			if (m_bPressed)
			{
				//double scaleAmt = 10.0 * sin( (double)rand() );
				//double scaleAmt = sin( (double)rand() );
				glScalef(0.9, 0.9, 1.0);
			}
			//cube中心位于原点
			glScalef(m_fWidth, m_fHeight, 5.0);
			glutSolidCube(1.0);

		}
		glPopMatrix();
	}
	bool OnMouseDown(int mousex, int mousey)
	{
		//鼠标的位置：mousex，mousey坐标系是原点位于左上角
		//必须将mousey变换到原点位于左下角的坐标系中
		mousey = g_fHeight - mousey;
		if (mousex > m_fPosX && mousex < m_fPosX + m_fWidth &&
			mousey > m_fPosY && mousey < m_fPosY + m_fHeight)
		{

			m_bPressed = true;

			return true;
		}
		return false;
	}
	void OnMouseUp()
	{
		m_bPressed = false;
	}
};
Button* pBtn;



void init(void)
{
	glClearColor(0.0, 1.0, 1.0, 1.0);//设置背景板的颜色
	//glShadeModel(GL_SMOOTH);
	glViewport(0, g_fWidth, 0, g_fHeight);
	glMatrixMode(GL_PROJECTION);
	//glFrustum(0.0,640.0,0.0,480.0,-10,1000);
	gluOrtho2D(0.0, g_fWidth, 0.0, g_fHeight);

	/*
	pBtn = new Button;
	pBtn->m_bPressed = false;
	pBtn->m_fPosX = 60;//按钮的横坐标
	pBtn->m_fPosY = 670;//按钮的纵坐标
	pBtn->m_fWidth = 60;//按钮的宽度
	pBtn->m_fHeight = 30;//按钮的高度
	*/
}
/*
void display(void)
{
	glClear(GL_COLOR_BUFFER_BIT);//用来清除屏幕颜色，即将屏幕的所有像素点都还原为 “底色 ”
	glColor3f(0.0, 1.0, 1.0);//是用来设置画笔的颜色，即绘图颜色。属于RGBA模式
	
	
	//绘制按钮
	glMatrixMode(GL_PROJECTION);
	{

		glLoadIdentity();
		glOrtho(0, g_fWidth, 0, g_fHeight, 0, g_fDepth);//负责使用什么样的视景体来截取图像
		glMatrixMode(GL_MODELVIEW);
		glLoadIdentity();
		pBtn->Render();
	}
	
	// 绘制cube物体（display中用于绘制3D长方体，可旋转）
	glMatrixMode(GL_PROJECTION);//恢复原有的设置  GL_PROJECTION,对投影矩阵堆栈应用随后的矩阵操作。可以在执行此命令后，为我们的场景增加透视。
	{
		glLoadIdentity();//恢复初始坐标系，屏幕中心为坐标系原点
		gluPerspective(60, 1.0, 1.5, 20);//相机相关内容
		glMatrixMode(GL_MODELVIEW);//GL_MODELVIEW,对模型视图矩阵堆栈应用随后的矩阵操作。可以在执行此命令后，输出自己的物体图形了。
		glLoadIdentity();
		//viewing transformation  
		gluLookAt(0.0, 0.0, 5.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0);//相机相关内容
		glRotatef(g_fAngle, 0.0, 1.0, 0.0);//旋转函数，从(0,0,0)到(x,y,z)为轴旋转（右手螺旋）
		glScalef(1.0, 2.0, 1.0);      // modeling transformation 
		glutWireCube(1.0);
	}

	glutSolidCube(1.0);

	glColor3f(0.1, 1, 0.1);
	glRectf(-0.3, 0.1, 0.3, -0.15);
	glRectf(-0.3, -0.3, 0.3, -0.55);

	glColor3f(1, 0, 0);
	selectFont(18, DEFAULT_CHARSET, "华文仿宋");
	glRasterPos2f(-0.9, 0.8);
	drawCNString("旋转按钮");

	// glFlush();
	glutSwapBuffers();
}
*/

//调整窗口尺寸
/*
void reshape(int w, int h)//当窗的形状改变事件发生时 调用的处理函数 reshape
{
	glViewport(0, 0, (GLsizei)w, (GLsizei)h);
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	gluPerspective(60, 1.0, 1.5, 20);
	glMatrixMode(GL_MODELVIEW);
}
*/


void mouse(int button, int state, int x, int y)
{
	if (button == GLUT_LEFT_BUTTON)
		switch (state)
		{
		case GLUT_DOWN:
			//左键按下：
			
			if (pBtn->OnMouseDown(x, y))
			{
				g_fAngle += 2.0;
				if (g_fAngle > 360)
				{
					g_fAngle -= 360;
				}
			}
			break;

		case GLUT_UP:
			pBtn->OnMouseUp();
			break;
		}
	glutPostRedisplay();//标记当前窗口需要重新绘制;
}


int main(int argc, char** argv)
{
	glutInit(&argc, argv);//初始化glut库
	glutInitDisplayMode(GLUT_SINGLE | GLUT_RGB);
	glutInitWindowSize(g_fWidth, g_fHeight);//设置窗口大小
	glutInitWindowPosition(100, 100);//设置窗口坐标
	glutCreateWindow("几何画板");
	init();
	//创建菜单
	createGLUTMenus();

	//设置展示的回调方法
	//glutDisplayFunc(display);
	//glutReshapeFunc(reshape);
	glutDisplayFunc(myDisplay);
	
	//设置鼠标键盘的回调方法
	glutKeyboardFunc(keyboard);
	glutMouseFunc(myMouse);
	glutMotionFunc(myMotion);
	glutPassiveMotionFunc(myPassiveMotion);
	
	glutMainLoop();//绘制线程开始循环
	return 0;
}







/*
	// 绘制cube物体（display中用于绘制3D长方体，可旋转）
	glMatrixMode(GL_PROJECTION);//恢复原有的设置  GL_PROJECTION,对投影矩阵堆栈应用随后的矩阵操作。可以在执行此命令后，为我们的场景增加透视。
	{
		glLoadIdentity();//恢复初始坐标系，屏幕中心为坐标系原点
		gluPerspective(60, 1.0, 1.5, 20);//相机相关内容
		glMatrixMode(GL_MODELVIEW);//GL_MODELVIEW,对模型视图矩阵堆栈应用随后的矩阵操作。可以在执行此命令后，输出自己的物体图形了。
		glLoadIdentity();
		//viewing transformation  
		gluLookAt(0.0, 0.0, 5.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0);//相机相关内容
		glRotatef(g_fAngle, 0.0, 1.0, 0.0);//旋转函数，从(0,0,0)到(x,y,z)为轴旋转（右手螺旋）
		glScalef(1.0, 2.0, 1.0);      // modeling transformation 
		glutWireCube(1.0);
	}

*/


