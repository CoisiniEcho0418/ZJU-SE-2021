#include "proc.h"
extern void _dummy();
extern void _switch_to(struct task_struct *prev, struct task_struct *next);
extern uint64 task_test_priority[];
extern uint64 task_test_counter[];
struct task_struct *idle;           // idle process
struct task_struct *current;        // 指向当前运行线程的 `task_struct`
struct task_struct *task[NR_TASKS]; // 线程数组, 所有的线程都保存在此

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

    for (int i = 1; i < NR_TASKS; i++)
    {
        task[i] = (struct task_struct *)kalloc();
        task[i]->state = TASK_RUNNING;
        task[i]->counter = task_test_counter[i];
        task[i]->priority = task_test_priority[i];
        task[i]->pid = i;
        task[i]->thread.ra = (uint64)&_dummy;
        task[i]->thread.sp = (uint64)(unsigned long long)task[i] + PGSIZE;
    }

    printk("...proc_init done!\n");
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
    uint64 min_counter=1ULL<<64;
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
