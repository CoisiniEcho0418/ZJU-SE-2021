#include "printk.h"
#include "clock.h"
#include "syscall.h"
#include "stdint.h"
#include "proc.h"
extern void do_timer(void);
extern struct task_struct *current;   ;  
void trap_handler(uint64_t scause, uint64_t sepc, struct pt_regs *regs) 
{   

    //判断是否是Interrupt
    if (scause>>63)
    {   

        //判断是否是timer interrupt
        unsigned long long exception = scause & ~(0x1ULL<<63);
        if (exception == 5)
        {        
            
            clock_set_next_event();   
            do_timer();
            
        }
        
    }
    else if(scause == 8)
        {        
            syscall(regs);
        }
    else if(scause==12){
             printk("Instruction page fault!\n");
        }
    else {
            printk("%lx\n",scause);
    }
    return;   
}
 
void syscall(struct pt_regs* regs) {
     if (regs->x[17] == SYS_WRITE) {
        if (regs->x[10] == 1) {
            int i;
            char* buf = (char*)regs->x[11];
            for ( i = 0; i < regs->x[12]; i++) {
                printk("%c", buf[i]);
            }
            regs->x[10] = i;
        } else {
            regs->x[10] = -1;
        }
     }
    else if (regs->x[17] == SYS_GETPID) {
        regs->x[10] = current->pid;
        // printk("SYS_GETPID:%ld\n",regs->x[10]);
    }
    regs->sepc+=4;
}