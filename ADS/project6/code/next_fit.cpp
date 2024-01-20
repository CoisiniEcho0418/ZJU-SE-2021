#include <vector>
#include "defs.h"
using namespace std; 
extern vector<Rectangle>data;
extern int max_width;
#define max(a,b) ((a>b)?(a):(b))

/*
    Next Fit Strategy.
    For each line, we maintain some attributes. 
    now_width - the width for this line.
    now_height - the total height (except the now line)
    max_height - the maximum height for this line(can be updated during insertion of this line)
    So we try to insert the rectangle into this line, if ok we just update some attributes.
    Otherwise, we close this line and start a new line.
*/
int Pack_NextFit() 
{
    int now_width = 0;
    int now_height = 0, max_height = 0;
    for (auto tmp : data) {
        if (tmp.GetWidth() + now_width <= max_width) {  /* We can put it in the now line */
            now_width = tmp.GetWidth() + now_width;
            max_height = max(max_height, tmp.GetHeight());
        }
        else {          /* Create a new line.(close the preivous one) */
            now_height += max_height;
            max_height = tmp.GetHeight();
            now_width = tmp.GetWidth();
        }
    }
    now_height += max_height;   /* The rest height for the newest line. */
    return now_height;
}
