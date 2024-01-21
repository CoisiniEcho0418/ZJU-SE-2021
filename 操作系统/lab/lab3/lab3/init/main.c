#include "printk.h"
#include "sbi.h"
#include "defs.h"
#include "proc.h"
extern void test();
extern unsigned long *_stext;
extern unsigned long *_srodata;

int start_kernel() {
    printk("Hello RISC-V\n");
    printk("idle process is running!\n");
    printk("_stext(address) = %lx\n", _stext);
    printk("_srodata(address) = %lx\n", _srodata);
    unsigned long stext_value = read_memory((unsigned long)_stext);
    unsigned long srodata_value = read_memory((unsigned long)_srodata);
    // 使用 %lx 打印16进制数
    printk("Value at _stext = 0x%lx\n", stext_value); 
    printk("Value at _srodata = 0x%lx\n", srodata_value);
    test(); // DO NOT DELETE !!!
	return 0;
}
