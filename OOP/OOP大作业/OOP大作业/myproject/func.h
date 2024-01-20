//设置字体
void selectFont(int size, int charset, const char* face);
//画中文字符
void drawCNString(const char* str);

//颜色菜单
void colorSubMenu(int colorOption);
//图形菜单
void shapeSubMenu(int shapeOption);
//粗细菜单
void ptsizeSubMenu(int size);
//填充菜单
void fillmodelSubMenu(int _model);
//窗口菜单（窗口位置）
void WindowSubMenu(int data);
//主菜单
void mainMenu(int renderingOption);
//创建菜单
void createGLUTMenus();

//键盘处理函数
void keyboard(unsigned char key, int x, int y);

//画线
void drawThread(int x1, int y1, int x2, int y2, float _x, float _y, float _z, int _ptsize, int _fillmodel);
//画矩形
void drawRectangle(int x1, int y1, int x2, int y2, float _x, float _y, float _z, int _ptsize, int _fillmodel);
//绘制四边形 2边有半圆
void DrawSiBianxing(int x1, int y1, int x2, int y2, float _x, float _y, float _z, int _ptsize, int _fillmodel);
//画平行四边形
void drawRectangleParral(int x1, int y1, int x2, int y2, float _x, float _y, float _z, int _ptsize, int _fillmodel);
//绘制六边形
void DrawSixBianXing(int x1, int y1, int x2, int y2, float _x, float _y, float _z, int _ptsize, int _fillmodel);
//画三角形
void drawTriangle(int x1, int y1, int x2, int y2, int x3, int y3, float _x, float _y, float _z, int _ptsize, int _fillmodel);
//画圆
void drawCircle(int x1, int y1, int x2, int y2, float _x, float _y, float _z, int _ptsize, int _fillmodel);
//显示函数1
void myDisplay();
//显示函数2
void itDisplay();
//鼠标事件
void myMouse(int button, int state, int x, int y);
//鼠标按住移动事件
void myMotion(int x, int y);
//鼠标松开移动事件
void myPassiveMotion(int x, int y);
//加载点集



