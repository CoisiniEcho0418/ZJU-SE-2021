//��������
void selectFont(int size, int charset, const char* face);
//�������ַ�
void drawCNString(const char* str);

//��ɫ�˵�
void colorSubMenu(int colorOption);
//ͼ�β˵�
void shapeSubMenu(int shapeOption);
//��ϸ�˵�
void ptsizeSubMenu(int size);
//���˵�
void fillmodelSubMenu(int _model);
//���ڲ˵�������λ�ã�
void WindowSubMenu(int data);
//���˵�
void mainMenu(int renderingOption);
//�����˵�
void createGLUTMenus();

//���̴�����
void keyboard(unsigned char key, int x, int y);

//����
void drawThread(int x1, int y1, int x2, int y2, float _x, float _y, float _z, int _ptsize, int _fillmodel);
//������
void drawRectangle(int x1, int y1, int x2, int y2, float _x, float _y, float _z, int _ptsize, int _fillmodel);
//�����ı��� 2���а�Բ
void DrawSiBianxing(int x1, int y1, int x2, int y2, float _x, float _y, float _z, int _ptsize, int _fillmodel);
//��ƽ���ı���
void drawRectangleParral(int x1, int y1, int x2, int y2, float _x, float _y, float _z, int _ptsize, int _fillmodel);
//����������
void DrawSixBianXing(int x1, int y1, int x2, int y2, float _x, float _y, float _z, int _ptsize, int _fillmodel);
//��������
void drawTriangle(int x1, int y1, int x2, int y2, int x3, int y3, float _x, float _y, float _z, int _ptsize, int _fillmodel);
//��Բ
void drawCircle(int x1, int y1, int x2, int y2, float _x, float _y, float _z, int _ptsize, int _fillmodel);
//��ʾ����1
void myDisplay();
//��ʾ����2
void itDisplay();
//����¼�
void myMouse(int button, int state, int x, int y);
//��갴ס�ƶ��¼�
void myMotion(int x, int y);
//����ɿ��ƶ��¼�
void myPassiveMotion(int x, int y);
//���ص㼯



