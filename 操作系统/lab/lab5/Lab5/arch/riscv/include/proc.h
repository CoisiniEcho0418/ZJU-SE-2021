#include "types.h"
#include "defs.h"
#include "mm.h"
#include "rand.h"
#include "printk.h"
#include "test.h"
#include "string.h"
#define NR_TASKS  (1 + 4) // 用于控制 最大线程数量 （idle 线程 + 31 内核线程）
#define TASK_RUNNING    0 // 为了简化实验, 所有的线程都只有一种状态
#define PRIORITY_MIN 1
#define PRIORITY_MAX 10
#define COUNTER_MIN 1
#define COUNTER_MAX 10

#define VM_X_MASK         0x0000000000000008
#define VM_W_MASK         0x0000000000000004
#define VM_R_MASK         0x0000000000000002
#define VM_ANONYM         0x0000000000000001

typedef unsigned long* pagetable_t;

/* 线程状态段数据结构 */
struct thread_struct {
    uint64 ra;
    uint64 sp;
    uint64 s[12];
    uint64 sepc, sstatus, sscratch; 
};

struct vm_area_struct {
    uint64_t vm_start;          /* VMA 对应的用户态虚拟地址的开始   */
    uint64_t vm_end;            /* VMA 对应的用户态虚拟地址的结束   */
    uint64_t vm_flags;          /* VMA 对应的 flags */

    /* uint64_t file_offset_on_disk */  /* 原本需要记录对应的文件在磁盘上的位置，
                                但是我们只有一个文件 uapp，所以暂时不需要记录 */

    uint64_t vm_content_offset_in_file;                /* 如果对应了一个文件，
                        那么这块 VMA 起始地址对应的文件内容相对文件起始位置的偏移量，
                                          也就是 ELF 中各段的 p_offset 值 */

    uint64_t vm_content_size_in_file;                /* 对应的文件内容的长度。
                                                      思考为什么还需要这个域?
                                                      和 (vm_end-vm_start)
                                                      一比，不是冗余了吗? */
};

/* 线程数据结构 */
struct task_struct {
    uint64 state;    // 线程状态
    uint64 counter;  // 运行剩余时间
    uint64 priority; // 运行优先级 1最低 10最高
    uint64 pid;      // 线程id
    uint64 kernel_sp;
    uint64 user_sp;
    struct thread_struct thread;
    //uint64* satp;
    pagetable_t pgd;
    
    uint64_t vma_cnt;                       /* 下面这个数组里的元素的数量 */
    struct vm_area_struct vmas[0];          /* 为什么可以开大小为 0 的数组?
                                这个定义可以和前面的 vma_cnt 换个位置吗? */
    
};

/* 线程初始化 创建 NR_TASKS 个线程 */
void task_init();

/* 在时钟中断处理中被调用 用于判断是否需要进行调度 */
void do_timer();

/* 调度程序 选择出下一个运行的线程 */
void schedule();

/* 线程切换入口函数*/
void switch_to(struct task_struct* next);

/* dummy funciton: 一个循环程序, 循环输出自己的 pid 以及一个自增的局部变量 */
void dummy();

static uint64_t load_bin(struct task_struct* task);
static uint64_t load_program(struct task_struct* task);
static uint64_t demand_pageing(struct task_struct* task);

void do_mmap(struct task_struct *task, uint64_t addr, uint64_t length, uint64_t flags,
    uint64_t vm_content_offset_in_file, uint64_t vm_content_size_in_file);

struct vm_area_struct *find_vma(struct task_struct *task, uint64_t addr);
