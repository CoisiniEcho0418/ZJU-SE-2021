#include "printk.h"
#include "sbi.h"
#include "defs.h"
#include "proc.h"
extern void test();
extern uint64 _srodata[];
extern uint64 _stext[];

int start_kernel() {
    printk(" [S-MODE] Hello RISC-V\n");
    schedule();
    test(); // DO NOT DELETE !!!
	return 0;
}
