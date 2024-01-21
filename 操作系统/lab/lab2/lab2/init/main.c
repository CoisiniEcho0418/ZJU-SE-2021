#include "printk.h"
#include "sbi.h"
#include "defs.h"
#include "proc.h"
extern void test();

int start_kernel() {
    printk("Hello RISC-V\n");
    printk("idle process is running!\n");
    test(); // DO NOT DELETE !!!
	return 0;
}
