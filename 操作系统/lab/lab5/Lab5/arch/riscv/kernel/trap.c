#include "printk.h"
#include "clock.h"
#include "syscall.h"
#include "stdint.h"
#include "proc.h"
#include "types.h"
extern void do_timer(void);
extern struct task_struct *current;   
extern char uapp_start[];
extern char uapp_end[];   
void trap_handler(uint64_t scause, uint64_t sepc, struct pt_regs *regs) 
{   
	
	if (scause == 0x8000000000000005){
    	clock_set_next_event();   
        do_timer();
    }
    else if(scause == 8)
        {        
            syscall(regs);
        }
    else if(scause==0xc||scause==0xd||scause==0xf){
             printk("[S] Page Fault, scause: %lx, stval: %lx, sepc: %lx \n",scause,regs->stval,regs->sepc);
             //while(1);
             do_page_fault(regs);
        }
    else {
    	//printk("%lx\n",scause);
        printk("[S] Unhandled trap, ");
        printk("scause: %lx, ", scause);
        printk("stval: %lx, ", regs->stval);
        printk("sepc: %lx\n", regs->sepc);
        while (1);     
    }
    return;   
}

void do_page_fault(struct pt_regs *regs) {

	/*
     1. 通过 stval 获得访问出错的虚拟内存地址（Bad Address）
     2. 通过 find_vma() 查找 Bad Address 是否在某个 vma 中
     3. 分配一个页，将这个页映射到对应的用户地址空间
     4. 通过 (vma->vm_flags | VM_ANONYM) 获得当前的 VMA 是否是匿名空间
     5. 根据 VMA 匿名与否决定将新的页清零或是拷贝 uapp 中的内容
    */
    
    uint64 bad_addr = regs->stval;  //获得访问出错的虚拟内存地址
    struct vm_area_struct *result_vma = find_vma(current,bad_addr);    //查找bad_addr是否在某个vma中
    if(result_vma == NULL) {
        printk("Can't find vma in address %lx! pid: %d\n", bad_addr, current->pid);
        while (1);
        return;
    }
    if(result_vma != NULL){   
        uint64 new_addr = alloc_page();
        int perm = ((result_vma->vm_flags) & (~VM_ANONYM)) | 0x11;
        if( !(result_vma->vm_flags & VM_ANONYM) ){ // 不是匿名页
            uint64 begin_addr = (uint64)(uapp_start) + result_vma->vm_content_offset_in_file;
            uint64 page_offset = (bad_addr - result_vma->vm_start) / PGSIZE;
		    begin_addr += page_offset * PGSIZE;
		    memcpy((void *)new_addr, (void *)PGROUNDDOWN(begin_addr), PGSIZE);
        }else{
        	memset((void *)new_addr, 0x0, PGSIZE);
        }
        // X|R|W|V
        create_mapping(current->pgd,PGROUNDDOWN(bad_addr),(uint64)new_addr-PA2VA_OFFSET,PGSIZE,perm);
    }
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
