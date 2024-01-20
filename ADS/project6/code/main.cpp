#include <iostream>
#include <algorithm>
#include <vector>
#include <time.h>
#include "defs.h"
using namespace std;
int n, max_width;
vector<Rectangle>data;      /* store the data we generate */
bool cmp (Rectangle A, Rectangle B)     /* used for sorting(by height) */
{
    return A.GetHeight() > B.GetHeight();
}
void Print(string msg, int (*func)(), bool sorted) 
{
    double st = clock();
    if (sorted) sort(data.begin(), data.end(), cmp);        /* For A3, we need to sort first. */
    int ans = (*func)();
    double ed = clock();            /* count time */
    cout << msg << " Answer: " << ans << "    " << "Time: " << (ed-st) << endl;
    /* Unit: ms */
}
int main()
{
    cout << "请输入矩形数量 N 和箱子的宽度 M " << endl;
    cin >> n >> max_width;
    /* generate ramdom data */
    GenerateData(n);
    /* Algorithm 1: Next Fit */
    Print("NextFit", Pack_NextFit, false);
    /* Algortihm 2: First Fit */
    Print("FirstFit(not sorted)", Pack_FirstFit, false);
    /* Algorithm 3: First Fit with sorting */
    Print("FirstFit(sorted)", Pack_FirstFit, true);
    system("pause");
    return 0;
    
}
