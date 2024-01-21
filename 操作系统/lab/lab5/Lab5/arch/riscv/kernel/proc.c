#include "proc.h"
#include "vm.h"
#include "types.h"
#include "elf.h"
extern void _dummy();
extern void _switch_to(struct task_struct *prev, struct task_struct *next);
extern uint64 task_test_priority[];
extern uint64 task_test_counter[];
struct task_struct *idle;           // idle process
struct task_struct *current;        // 指向当前运行线程的 `task_struct`
struct task_struct *task[NR_TASKS]; // 线程数组, 所有的线程都保存在此
extern char uapp_start[];
extern char uapp_end[];
extern uint64  swapper_pg_dir[512] __attribute__((__aligned__(0x1000)));
void task_init()
{
    test_init(NR_TASKS);
    // 1. 调用 kalloc() 为 idle 分配一个物理页
    // 2. 设置 state 为 TASK_RUNNING;
    // 3. 由于 idle 不参与调度 可以将其 counter / priority 设置为 0
    // 4. 设置 idle 的 pid 为 0
    // 5. 将 current 和 task[0] 指向 idle

    idle = (struct task_struct *)kalloc();
    idle->state = TASK_RUNNING;
    idle->counter = 0;
    idle->priority = 0;
    idle->pid = 0;
    current = idle;
    task[0] = idle;

    // 1. 参考 idle 的设置, 为 task[1] ~ task[NR_TASKS - 1] 进行初始化
    // 2. 其中每个线程的 state 为 TASK_RUNNING,此外，为了单元测试的需要，counter 和 priority 进行如下赋值：
    // task[i].counter  = task_test_counter[i];
    // task[i].priority = task_test_priority[i];
    // 3. 为 task[1] ~ task[NR_TASKS - 1] 设置 `thread_struct` 中的 `ra` 和 `sp`,
    // 4. 其中 `ra` 设置为 __dummy （见 4.3.2）的地址,  `sp` 设置为 该线程申请的物理页的高地址

    for (int i = 1; i < NR_TASKS; i++){
        task[i] = (struct task_struct *)kalloc();
        task[i]->state = TASK_RUNNING;
        task[i]->counter = task_test_counter[i];
        task[i]->priority = task_test_priority[i];
        task[i]->pid = i;
        task[i]->thread.ra = (uint64)&_dummy;
        task[i]->thread.sp = (uint64)(task[i]) + PGSIZE;
        //load_bin(task[i]);
        //load_program(task[i]);
        //task[i]->pgd = alloc_page();
    	//memcpy(task[i]->pgd,swapper_pg_dir,PGSIZE);
        demand_pageing(task[i]);
    }
    printk("...proc_init done!\n");
}

static uint64_t demand_pageing(struct task_struct* task){
    Elf64_Ehdr* ehdr = (Elf64_Ehdr*)uapp_start;

    uint64_t phdr_start = (uint64_t)ehdr + ehdr->e_phoff;
    int phdr_cnt = ehdr->e_phnum;
  
    Elf64_Phdr* phdr;
    int load_phdr_cnt = 0;
    
    uint64* pgtbl = (uint64 *)alloc_page();
    memcpy(pgtbl, swapper_pg_dir, PGSIZE);
    task->pgd = pgtbl;
    //遍历所有egement
    for (int i = 0; i < phdr_cnt; i++) {    
        phdr = (Elf64_Phdr*)(phdr_start + sizeof(Elf64_Phdr) * i); 
        if (phdr->p_type == PT_LOAD) {
            uint64 offset = (uint64)(phdr->p_vaddr) - PGROUNDDOWN(phdr->p_vaddr);
            uint64 sz = (phdr->p_memsz + offset) / PGSIZE + 1;
            uint64 length = sz * PGSIZE;
            uint64 flags = phdr->p_flags << 1; // 将低位置0 表示该页不是一个匿名页
            do_mmap(task,phdr->p_vaddr,length,flags,phdr->p_offset,phdr->p_filesz);
        }
    }

    // allocate user stack and do mapping
    // code...
    // following code has been written for you
    do_mmap(task,USER_END-PGSIZE,PGSIZE,VM_R_MASK | VM_W_MASK | VM_ANONYM,0,0); 
    // pc for the user program
    task->thread.sepc = ehdr->e_entry;
    // sstatus bits set
    uint64 sstatus = csr_read(sstatus);
    sstatus = sstatus&(~(1<<8)); // set sstatus[SPP] = 0
    sstatus = sstatus|(1<<5); // set sstatus[SPIE] = 1
    sstatus = sstatus|(1<<18); // set sstatus[SUM] = 1
    task->thread.sstatus = sstatus;   
    // user stack for user program
     task->thread.sscratch = USER_END;
}

void do_mmap(struct task_struct *task, uint64_t addr, uint64_t length, uint64_t flags,
    uint64_t vm_content_offset_in_file, uint64_t vm_content_size_in_file){
    	struct vm_area_struct *new_vma = &(task->vmas[task->vma_cnt]);
    	new_vma->vm_start = addr;
    	new_vma->vm_end = addr+length;
    	new_vma->vm_flags = flags;
    	new_vma->vm_content_offset_in_file = vm_content_offset_in_file;
    	new_vma->vm_content_size_in_file = vm_content_size_in_file;
    	task->vma_cnt++;
    }

struct vm_area_struct *find_vma(struct task_struct *task, uint64_t addr){
	struct vm_area_struct *result = NULL;
	for(int i=0;i<task->vma_cnt;i++){
		if(addr>=task->vmas[i].vm_start && addr<task->vmas[i].vm_end){
			result = &(task->vmas[i]);
			break;
		}
	}
	return result;
}

void dummy()
{
    schedule_test();
    uint64 MOD = 1000000007;
    uint64 auto_inc_local_var = 0;
    int last_counter = -1;
    while (1)
    {
        if (((last_counter == -1) || (current->counter != last_counter)) && (current->counter > 0))
        {
            // if(current->counter == 1){
            //     current->counter=0;     // forced the counter to be zero if this thread is going to be scheduled
            // }                           // in case that the new counter is also 1，leading the information not printed.
            last_counter = current->counter;
            auto_inc_local_var = (auto_inc_local_var + 1) % MOD;

            // printk("[PID = %d] is running. auto_inc_local_var = %d\n", current->pid, auto_inc_local_var);
             printk("[PID = %d] is running. thread space begin at 0x%016lx\n", current->pid, current);
        }
    }
}

void switch_to(struct task_struct *next)
{
    if (current != next)
    {
        printk("\n");
#ifdef SJF
        printk("switch to [PID = %d COUNTER = %d]\n", next->pid, next->counter);
#endif

#ifdef PRIORITY
        printk("switch to [PID = %d PRIORITY = %d COUNTER = %d]\n", next->pid, next->priority, next->counter);
#endif
        struct task_struct *prev = current;
        current = next;
        _switch_to(prev, next);
    }
    else
        return;
}
void do_timer(void)
{
    // 1. 如果当前线程是 idle 线程 直接进行调度
    if (current == idle)
    {
        schedule();
        return;
    }
    // 2. 如果当前线程不是 idle 对当前线程的运行剩余时间减1 若剩余时间仍然大于0 则直接返回 否则进行调度
    else
    {
        current->counter--;
        if (current->counter <= 0)
            schedule();
        else
            return;
    }
}
#ifdef SJF
void schedule()
{
    struct task_struct *next = current;
    uint64 min_counter=1ULL<<63;
    while (1)
    {   
        min_counter = -1;
        for (int i = 1; i < NR_TASKS; i++)
        {
            if (task[i]->state == TASK_RUNNING && task[i]->counter > 0&&task[i]->counter < min_counter)
            {

            min_counter = task[i]->counter;
            next = task[i];
            
            }
        }

        if (min_counter == -1)
        {
            printk("\n");
            for (int i = 1; i < NR_TASKS; i++)
            {
                task[i]->counter = rand() % (COUNTER_MAX - COUNTER_MIN + 1) + COUNTER_MIN;
                task[i]->priority = rand() % (PRIORITY_MAX - PRIORITY_MIN + 1) + PRIORITY_MIN;
                printk("SET [PID = %d COUNTER = %d]\n", task[i]->pid, task[i]->counter);
            }
        }
        else
            break;
    }

    switch_to(next);
}
#endif
#ifdef PRIORITY
void schedule()
{
    struct task_struct *next = current;
    uint64 max_counter;
    while (1)
    {   
        max_counter = 0;
        for (int i = NR_TASKS-1; i > 0; i--)
        {
            if (task[i]->state == TASK_RUNNING && task[i]->counter > 0 && task[i]->counter > max_counter)
            {
                max_counter = task[i]->counter;
                next = task[i];
            }
        }
        if (max_counter)
            break;
        printk("\n");
        for (int i = NR_TASKS-1; i > 0; i--)
        {
            task[i]->counter = (task[i]->counter>>1)+task[i]->priority;
            printk("SET [PID = %d PRIORITY = %d COUNTER = %d]\n", task[i]->pid, task[i]->priority, task[i]->counter);
        }
    }
    switch_to(next);
}
#endif

static uint64_t load_program(struct task_struct* task) {
    Elf64_Ehdr* ehdr = (Elf64_Ehdr*)uapp_start;

    uint64_t phdr_start = (uint64_t)ehdr + ehdr->e_phoff;
    int phdr_cnt = ehdr->e_phnum;
  
    Elf64_Phdr* phdr;
    int load_phdr_cnt = 0;
    uint64* pgtbl = (uint64 *)alloc_page();
    memcpy(pgtbl, swapper_pg_dir, PGSIZE);
    uint64 va,pa;
    for (int i = 0; i < phdr_cnt; i++) {
        phdr = (Elf64_Phdr*)(phdr_start + sizeof(Elf64_Phdr) * i);
        if (phdr->p_type == PT_LOAD) {
        // 计算所需页面数量并分配空间
        uint64 phdr_num = PGROUNDUP((uint64)phdr->p_memsz + phdr->p_vaddr - PGROUNDDOWN(phdr->p_vaddr)) / PGSIZE;
        uint64 *phdr_temp = (uint64 *)alloc_pages(phdr_num);
        //从elf文件拷贝大小为p_filesz的内容
        memcpy((void *)((uint64)phdr_temp + phdr->p_vaddr - PGROUNDDOWN(phdr->p_vaddr)), 
        (void*)((uint64)&uapp_start + (uint64)phdr->p_offset), (uint64)phdr->p_filesz);
        //将 [p_vaddr + p_filesz, p_vaddr + p_memsz)对应的物理区间清零
         memset((void *)((uint64)phdr_temp + phdr->p_vaddr - PGROUNDDOWN(phdr->p_vaddr)+(uint64)phdr->p_filesz), 
        0, (uint64)phdr->p_memsz-(uint64)phdr->p_filesz);
         // do mapping
        va = (uint64)PGROUNDDOWN(phdr->p_vaddr);
        pa = (uint64)phdr_temp-PA2VA_OFFSET;
        create_mapping(pgtbl, va, pa, phdr_num*PGSIZE, (phdr->p_flags << 1) | 17);
        }
    }
  
    // allocate user stack and do mapping
    // code...
    // following code has been written for you
    // set user stack
    task->kernel_sp = (uint64)(task)+PGSIZE;
    task->user_sp = alloc_page();
    va = USER_END-PGSIZE;
    pa = task->user_sp-PA2VA_OFFSET;
    create_mapping(pgtbl, va, pa, PGSIZE, 23);
    uint64 satp = csr_read(satp);
    satp = (satp >> 44) << 44;
    satp = satp|(((uint64)pgtbl-PA2VA_OFFSET) >> 12);
    //task->satp = (uint64*)satp;
    task->pgd = (pagetable_t)satp;
    // pc for the user program
    task->thread.sepc = ehdr->e_entry;
    // sstatus bits set
    uint64 sstatus = csr_read(sstatus);
    sstatus = sstatus&(~(1<<8)); // set sstatus[SPP] = 0
    sstatus = sstatus|(1<<5); // set sstatus[SPIE] = 1
    sstatus = sstatus|(1<<18); // set sstatus[SUM] = 1
    task->thread.sstatus = sstatus;   
    // user stack for user program
     task->thread.sscratch = USER_END;
}
static uint64_t load_bin(struct task_struct* task){
            task->kernel_sp = (uint64)(task)+PGSIZE;
        task->user_sp = alloc_page();
        uint64* pgtbl = (uint64 *)alloc_page();
        memcpy(pgtbl, swapper_pg_dir, PGSIZE);
        uint64 va = USER_START;
        uint64 pa = (uint64)(uapp_start)-PA2VA_OFFSET;
        // printk("va:%lx pa:%lx\n",va,pa);
        create_mapping(pgtbl, va, pa, (uint64)(uapp_end)-(uint64)(uapp_start), 31);
        va = USER_END-PGSIZE;
        pa = task->user_sp-PA2VA_OFFSET;
        create_mapping(pgtbl, va, pa, PGSIZE, 23);
        uint64 satp = csr_read(satp);
        satp = (satp >> 44) << 44;
        satp = satp|(((uint64)pgtbl-PA2VA_OFFSET) >> 12);
        //task->satp = (uint64*)satp;
        task->pgd = (pagetable_t)satp;
        // printk("%d satp:%lx\n",i,satp);
        task->thread.sepc = USER_START;
        uint64 sstatus = csr_read(sstatus);
        sstatus = sstatus&(~(1<<8)); // set sstatus[SPP] = 0
        sstatus = sstatus|(1<<5); // set sstatus[SPIE] = 1
        sstatus = sstatus|(1<<18); // set sstatus[SUM] = 1
        task->thread.sstatus = sstatus;
        task->thread.sscratch = USER_END;

}
