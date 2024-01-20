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
#pragma comment( lib, "glaux.lib")		// GLaux���ӿ�

//��ʱû��
#define RED 1
#define GREEN 2
#define BLUE 3
#define WHITE 4

//
//global  ���ڵĴ�С����
float g_fWidth = 600;
float g_fHeight = 600;
float g_fDepth = 100;
float g_fAngle = .0;

extern int shape;//��¼����Ҫ������״����
extern int color;//��¼����Ҫ������ɫ
extern int ptsize;//��С
extern int fillmodel;


struct Button
{
	float m_fPosX;		//��ʾ������ͶӰ����ϵ(���½�Ϊ����ԭ��)�����꣬
	float m_fPosY;
	float m_fWidth;		//��Ļ���ص�λ
	float m_fHeight;

	bool m_bPressed;
	void Render()
	{
		glPushMatrix();
		{
			//������λ��ԭ���cube�ƶ���ʹcube���½�����Ϊm_fPosX,m_fPosY��λ��
			//���뿼��cube��������
			glTranslatef(m_fPosX + m_fWidth / 2, m_fPosY + m_fHeight / 2, -2.0);	//-2.0ֻ��Ϊ�˰�ť�ɼ�
			if (m_bPressed)
			{
				//double scaleAmt = 10.0 * sin( (double)rand() );
				//double scaleAmt = sin( (double)rand() );
				glScalef(0.9, 0.9, 1.0);
			}
			//cube����λ��ԭ��
			glScalef(m_fWidth, m_fHeight, 5.0);
			glutSolidCube(1.0);

		}
		glPopMatrix();
	}
	bool OnMouseDown(int mousex, int mousey)
	{
		//����λ�ã�mousex��mousey����ϵ��ԭ��λ�����Ͻ�
		//���뽫mousey�任��ԭ��λ�����½ǵ�����ϵ��
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
	glClearColor(0.0, 1.0, 1.0, 1.0);//���ñ��������ɫ
	//glShadeModel(GL_SMOOTH);
	glViewport(0, g_fWidth, 0, g_fHeight);
	glMatrixMode(GL_PROJECTION);
	//glFrustum(0.0,640.0,0.0,480.0,-10,1000);
	gluOrtho2D(0.0, g_fWidth, 0.0, g_fHeight);

	/*
	pBtn = new Button;
	pBtn->m_bPressed = false;
	pBtn->m_fPosX = 60;//��ť�ĺ�����
	pBtn->m_fPosY = 670;//��ť��������
	pBtn->m_fWidth = 60;//��ť�Ŀ��
	pBtn->m_fHeight = 30;//��ť�ĸ߶�
	*/
}
/*
void display(void)
{
	glClear(GL_COLOR_BUFFER_BIT);//���������Ļ��ɫ��������Ļ���������ص㶼��ԭΪ ����ɫ ��
	glColor3f(0.0, 1.0, 1.0);//���������û��ʵ���ɫ������ͼ��ɫ������RGBAģʽ
	
	
	//���ư�ť
	glMatrixMode(GL_PROJECTION);
	{

		glLoadIdentity();
		glOrtho(0, g_fWidth, 0, g_fHeight, 0, g_fDepth);//����ʹ��ʲô�����Ӿ�������ȡͼ��
		glMatrixMode(GL_MODELVIEW);
		glLoadIdentity();
		pBtn->Render();
	}
	
	// ����cube���壨display�����ڻ���3D�����壬����ת��
	glMatrixMode(GL_PROJECTION);//�ָ�ԭ�е�����  GL_PROJECTION,��ͶӰ�����ջӦ�����ľ��������������ִ�д������Ϊ���ǵĳ�������͸�ӡ�
	{
		glLoadIdentity();//�ָ���ʼ����ϵ����Ļ����Ϊ����ϵԭ��
		gluPerspective(60, 1.0, 1.5, 20);//����������
		glMatrixMode(GL_MODELVIEW);//GL_MODELVIEW,��ģ����ͼ�����ջӦ�����ľ��������������ִ�д����������Լ�������ͼ���ˡ�
		glLoadIdentity();
		//viewing transformation  
		gluLookAt(0.0, 0.0, 5.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0);//����������
		glRotatef(g_fAngle, 0.0, 1.0, 0.0);//��ת��������(0,0,0)��(x,y,z)Ϊ����ת������������
		glScalef(1.0, 2.0, 1.0);      // modeling transformation 
		glutWireCube(1.0);
	}

	glutSolidCube(1.0);

	glColor3f(0.1, 1, 0.1);
	glRectf(-0.3, 0.1, 0.3, -0.15);
	glRectf(-0.3, -0.3, 0.3, -0.55);

	glColor3f(1, 0, 0);
	selectFont(18, DEFAULT_CHARSET, "���ķ���");
	glRasterPos2f(-0.9, 0.8);
	drawCNString("��ת��ť");

	// glFlush();
	glutSwapBuffers();
}
*/

//�������ڳߴ�
/*
void reshape(int w, int h)//��������״�ı��¼�����ʱ ���õĴ����� reshape
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
			//������£�
			
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
	glutPostRedisplay();//��ǵ�ǰ������Ҫ���»���;
}


int main(int argc, char** argv)
{
	glutInit(&argc, argv);//��ʼ��glut��
	glutInitDisplayMode(GLUT_SINGLE | GLUT_RGB);
	glutInitWindowSize(g_fWidth, g_fHeight);//���ô��ڴ�С
	glutInitWindowPosition(100, 100);//���ô�������
	glutCreateWindow("���λ���");
	init();
	//�����˵�
	createGLUTMenus();

	//����չʾ�Ļص�����
	//glutDisplayFunc(display);
	//glutReshapeFunc(reshape);
	glutDisplayFunc(myDisplay);
	
	//���������̵Ļص�����
	glutKeyboardFunc(keyboard);
	glutMouseFunc(myMouse);
	glutMotionFunc(myMotion);
	glutPassiveMotionFunc(myPassiveMotion);
	
	glutMainLoop();//�����߳̿�ʼѭ��
	return 0;
}







/*
	// ����cube���壨display�����ڻ���3D�����壬����ת��
	glMatrixMode(GL_PROJECTION);//�ָ�ԭ�е�����  GL_PROJECTION,��ͶӰ�����ջӦ�����ľ��������������ִ�д������Ϊ���ǵĳ�������͸�ӡ�
	{
		glLoadIdentity();//�ָ���ʼ����ϵ����Ļ����Ϊ����ϵԭ��
		gluPerspective(60, 1.0, 1.5, 20);//����������
		glMatrixMode(GL_MODELVIEW);//GL_MODELVIEW,��ģ����ͼ�����ջӦ�����ľ��������������ִ�д����������Լ�������ͼ���ˡ�
		glLoadIdentity();
		//viewing transformation  
		gluLookAt(0.0, 0.0, 5.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0);//����������
		glRotatef(g_fAngle, 0.0, 1.0, 0.0);//��ת��������(0,0,0)��(x,y,z)Ϊ����ת������������
		glScalef(1.0, 2.0, 1.0);      // modeling transformation 
		glutWireCube(1.0);
	}

*/


