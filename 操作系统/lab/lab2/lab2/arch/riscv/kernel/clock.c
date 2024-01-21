// QEMU中时钟的频率是10MHz, 也就是1秒钟相当于10000000个时钟周期。
#include "sbi.h"
unsigned long TIMECLOCK = 10000000ul;

unsigned long get_cycles()
{
    // 编写内联汇编，使用 rdtime 获取 time 寄存器中 (也就是mtime 寄存器 )的值并返回
    // YOUR CODE HERE
    unsigned long long time;
    asm volatile("rdtime %0" : "=r"(time));
    return time;
}

void clock_set_next_event()
{
    // 下一次 时钟中断 的时间点
    unsigned long long next = get_cycles() + TIMECLOCK;
    // 使用 sbi_ecall 来完成对下一次时钟中断的设置

    sbi_ecall(0x0, 0x0, next, 0, 0, 0, 0, 0);
    return;
}
