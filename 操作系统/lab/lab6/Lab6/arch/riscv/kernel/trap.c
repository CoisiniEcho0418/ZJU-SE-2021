#include "printk.h"
#include "clock.h"
#include "syscall.h"
#include "stdint.h"
#include "proc.h"
#include "types.h"
#include "vm.h"
extern void do_timer(void);
extern struct task_struct *current;   
extern char uapp_start[];
extern char uapp_end[];  
extern struct task_struct* task[NR_TASKS];
extern char __ret_from_fork[];
extern uint64  swapper_pg_dir[512] __attribute__((__aligned__(0x1000))); 
void trap_handler(uint64_t scause, uint64_t sepc, struct pt_regs *regs) 
{   
	
	if (scause == 0x8000000000000005){
		printk("[S] Supervisor Mode Timer Interrupt\n");
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


uint64_t sys_clone(struct pt_regs *regs) {
    /*
     1. 参考 task_init 创建一个新的 task, 将的 parent task 的整个页复制到新创建的 
        task_struct 页上(这一步复制了哪些东西?）。将 thread.ra 设置为 
        __ret_from_fork, 并正确设置 thread.sp
        (仔细想想，这个应该设置成什么值?可以根据 child task 的返回路径来倒推)

     2. 利用参数 regs 来计算出 child task 的对应的 pt_regs 的地址，
        并将其中的 a0, sp, sepc 设置成正确的值(为什么还要设置 sp?)

     3. 为 child task 申请 user stack, 并将 parent task 的 user stack 
        数据复制到其中。 

     4. 为 child task 分配一个根页表，并仿照 setup_vm_final 来创建内核空间的映射

     5. 根据 parent task 的页表和 vma 来分配并拷贝 child task 在用户态会用到的内存

     6. 返回子 task 的 pid
    */
    
    
    /*1. 参考 task_init 创建一个新的 task, 将的 parent task 的整个页复制到新创建的 
        task_struct 页上。将 thread.ra 设置为__ret_from_fork */
    uint64_t new_pid = -1;
    for(new_pid=2;new_pid<NR_TASKS;new_pid++){
    	if (task[new_pid] == NULL){
    		break;
    	}
    }
    if(new_pid >= NR_TASKS){
        printk("[Error] Task space is full!\n");
        return -1;
    }
    task[new_pid] = (struct task_struct*)alloc_page();
    memcpy(task[new_pid], current, PGSIZE);
    task[new_pid]->thread.ra = (uint64)(__ret_from_fork);
    task[new_pid]->pid = new_pid;
    
    /* 2. 利用参数 regs 来计算出 child task 的对应的 pt_regs 的地址
    	 并将其中的 a0, sp, sepc 设置成正确的值 */
    uint64 offset = (uint64)regs - PGROUNDDOWN((uint64)regs);
    struct pt_regs *child_regs = (struct pt_regs*)((uint64)task[new_pid] +offset);
	child_regs->x[10] = 0; 
	child_regs->x[2] = (uint64)child_regs;
    task[new_pid]->thread.sp = (uint64)child_regs;
    child_regs->sepc = regs->sepc + 4;
    task[new_pid]->thread.sepc = regs->sepc + 4; 

	/* 4. 为 child task 分配一个根页表，并仿照 setup_vm_final 来创建内核空间的映射 */
    uint64* child_pgtbl  = (uint64*) alloc_page();
    memcpy((void*)(child_pgtbl ), (void*)(swapper_pg_dir), PGSIZE);
    task[new_pid]->pgd = child_pgtbl;
    
    /* 3. 为 child task 申请 user stack, 并将 parent task 的 user stack 
        数据复制到其中。 */
    uint64 stack = alloc_page();
    memcpy(stack,USER_END-PGSIZE,PGSIZE);
    uint64 va = USER_END-PGSIZE;
    uint64 pa = stack-PA2VA_OFFSET;
    create_mapping(child_pgtbl, va, pa, PGSIZE, 23);
    task[new_pid]->user_sp = stack;
    // user stack for user program
    task[new_pid]->thread.sscratch = USER_END;
    
    /* 5. 根据 parent task 的页表和 vma 来分配并拷贝 child task 在用户态会用到的内存 */
    for (int i=0;i<current->vma_cnt;i++) {
        struct vm_area_struct *vma = &(current->vmas[i]);
        if(vma->vm_flags & VM_ANONYM != 0){
        	continue;
        }
        for(int addr=vma->vm_start;addr<vma->vm_end;addr+=PGSIZE){
            if(check_mapped(current->pgd,PGROUNDDOWN(addr))){
            	uint64 page = alloc_page();
            	create_mapping(child_pgtbl, PGROUNDDOWN(addr), page-PA2VA_OFFSET, PGSIZE, (vma->vm_flags & (~VM_ANONYM) | 0x11));
            memcpy((void*)page, (void*)PGROUNDDOWN(addr), PGSIZE);
            }
        }
    }
    
    //6 返回子task的pid
    printk("[S] New task: %d\n", new_pid);
    return new_pid;
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
    }else if(regs->x[17] == SYS_CLONE){
		regs->x[10] = sys_clone(regs);
    }
    regs->sepc+=4;
}
