#include <vector>
#include "defs.h"
using namespace std; 
extern vector<Rectangle>data;
extern int max_width;
#define max(a,b) ((a>b)?(a):(b))

/*
    First Fit Strategy.
    We maintain a free list for the line that has been closed. 
    For a new rectangle, we need first to scan the free list. Choose the first one that can contain the rectangele. 
    If no suitable one, we should try to insert it into the now line. If it's not done yet, we must create a new line 
	and insert. Meanwhile, creating a new line means closing the old line, so we should add the old line into the free list. 
*/
int Pack_FirstFit() 
{
    vector<Rectangle>free_list;
    int now_width = 0;
    int now_height = 0, max_height = 0;
    for (auto tmp : data) {
        bool bj = false;
        for (auto i : free_list) {      // Try to find whether we can put it in the previous space  
            if (i.GetHeight() >= tmp.GetHeight() && i.GetWidth() + tmp.GetWidth() <= max_width) {
                i.SetWidth(i.GetWidth() + tmp.GetWidth());      /* update */
                bj = true;      /* find it */
                break;
            }
        }
        if (bj) continue;
        if (tmp.GetWidth() + now_width <= max_width) {      /* Put it in the now line */
            now_width += tmp.GetWidth();
            max_height = max(max_height, tmp.GetHeight());
        }
        else {      /* now and previous lines cannot used. Create a new line. */
            if (now_width < max_width) {
                /* For a closed line, we should add it to the free list. */
                free_list.push_back(Rectangle(max_height, now_width));
            }
            now_height += max_height;
            now_width = tmp.GetWidth();
            max_height = tmp.GetHeight();
        }
    }
    now_height += max_height;       /* The rest height for the newest line. */
    return now_height;
}
