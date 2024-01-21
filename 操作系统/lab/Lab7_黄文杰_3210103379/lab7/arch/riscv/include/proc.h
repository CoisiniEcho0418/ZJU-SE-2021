#include "types.h"
#include "defs.h"
#include "mm.h"
#include "rand.h"
#include "printk.h"
#include "test.h"
#include "string.h"
#define NR_TASKS  (1 + 1) // 用于控制 最大线程数量 （idle 线程 + 31 内核线程）
#define TASK_RUNNING    0 // 为了简化实验, 所有的线程都只有一种状态
#define PRIORITY_MIN 1
#define PRIORITY_MAX 10
#define COUNTER_MIN 1
#define COUNTER_MAX 10


/* 线程状态段数据结构 */
struct thread_struct {
    uint64 ra;
    uint64 sp;
    uint64 s[12];
    uint64 sepc, sstatus, sscratch; 
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
    uint64* satp;
    struct file *files;
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