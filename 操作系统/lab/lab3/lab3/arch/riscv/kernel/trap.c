#include "printk.h"
#include "clock.h"
extern void do_timer(void);
void trap_handler(unsigned long long scause, unsigned long long sepc)
{   
    // printk("%llx\n",scause);
    //判断是否是Interrupt
    if ((scause & 0x1ULL<<63) == 0x1ULL<<63)
    {   

        //判断是否是timer interrupt
        unsigned long long cause1 = scause & ~(0x1ULL<<63);
        if (cause1 == 5)
        {        
            
            clock_set_next_event();   
            do_timer();
            
        }
    }
    return;
    
}