#ifndef _DEFS_H_
#define _DEFS_H_
#define MAX_HEIGHT 100
#define MAX_WIDTH 100 

class Rectangle {
public:
    Rectangle(int a, int b): height(a), width(b) {}
    int GetHeight() {return height;}
    int GetWidth() {return width;}
    void SetWidth(int a) {width = a;}
private:
    int height;
    int width;
}; 

// data.cpp
void GenerateData(int size);

// next_fit.cpp
int Pack_NextFit();

// first_fit.cpp
int Pack_FirstFit();

#endif
