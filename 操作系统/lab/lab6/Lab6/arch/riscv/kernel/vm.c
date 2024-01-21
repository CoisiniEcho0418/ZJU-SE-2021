#include "defs.h"
#include "types.h"
#include "vm.h"
#include "mm.h"
#include "string.h"
#include "printk.h"

/* early_pgtbl: 用于 setup_vm 进行 1GB 的 映射。 */
unsigned long  early_pgtbl[512] __attribute__((__aligned__(0x1000)));

void setup_vm(void) {
    /* 
    1. 由于是进行 1GB 的映射 这里不需要使用多级页表 
    2. 将 va 的 64bit 作为如下划分： | high bit | 9 bit | 30 bit |
        high bit 可以忽略
        中间9 bit 作为 early_pgtbl 的 index
        低 30 bit 作为 页内偏移 这里注意到 30 = 9 + 9 + 12， 即我们只使用根页表， 根页表的每个 entry 都对应 1GB 的区域。 
    3. Page Table Entry 的权限 V | R | W | X 位设置为 1
    */
    memset(early_pgtbl, 0x0, PGSIZE);
    unsigned long pa = PHY_START;
    unsigned long va = PHY_START;
    int index = (va >> 30) & 0x1ff;
    // early_pgtbl[index] = (((pa >> 30) & 0x3ffffff) << 28) | 0xf;
    va = VM_START;
    index = (va >> 30) & 0x1ff;
    early_pgtbl[index] = (((pa >> 30) & 0x3ffffff) << 28) | 0xf;
    printk("setup_vm is done !\n");
} 

/* swapper_pg_dir: kernel pagetable 根目录， 在 setup_vm_final 进行映射。 */
unsigned long  swapper_pg_dir[512] __attribute__((__aligned__(0x1000)));

extern char _srodata[];
extern char _stext[];
extern char _sdata[];

void setup_vm_final(void) {
    memset(swapper_pg_dir, 0x0, PGSIZE);
    // No OpenSBI mapping required

    // mapping kernel text X|-|R|V
    unsigned long pa = PHY_START + OPENSBI_SIZE;
    unsigned long va = VM_START  + OPENSBI_SIZE;
    unsigned long size = (unsigned long)_srodata-(unsigned long)_stext;\
    create_mapping(swapper_pg_dir,va,pa,size,11);
    printk("mapping kernel text !\n");

    // mapping kernel rodata -|-|R|V
    pa += size;
    va += size;
    size = (unsigned long)_sdata-(unsigned long)_srodata;
    create_mapping(swapper_pg_dir,va,pa,size,3);
    printk("mapping kernel rodata !\n");
    
    // mapping other memory -|W|R|V
    pa += size;
    va += size;
    size = PHY_SIZE - ((unsigned long)_sdata-(unsigned long)_stext);
    create_mapping(swapper_pg_dir,va,pa,size,7);
    printk("mapping other memory !\n");

    // set satp with swapper_pg_dir

    // YOUR CODE HERE
    asm volatile (
        "addi t0, x0, 8\n"
        "slli t0, t0, 60\n"
        "mv t1, %[addr]\n"
        "srli t1, t1, 12\n"
        "or t0, t0, t1\n"
        "csrw satp, t0"
        : 
        :[addr] "r" ((unsigned long)swapper_pg_dir - PA2VA_OFFSET)
        :"memory"
    );

    // flush TLB
    asm volatile("sfence.vma zero, zero");

    // flush icache
    asm volatile("fence.i");

    return;
}


/* 创建多级页表映射关系 */
void create_mapping(uint64 *pgtbl, uint64 va, uint64 pa, uint64 sz, int perm) {
/*
    pgtbl 为根页表的基地址
    va, pa 为需要映射的虚拟地址、物理地址
    sz 为映射的大小
    perm 为映射的读写权限

    创建多级页表的时候可以使用 kalloc() 来获取一页作为页表目录
    可以使用 V bit 来判断页表项是否存在
    */
    
    
    /* 
	1.从satp的PPN中获取根页表的物理地址
	2通过pagetable中的VPN段获取PTE。(可以把pagetable看成一个数组，VPN看成下标.PAGE SIZE为4KB，
	PTE为64bit(8B),所以一页中有4KB/8B=512个PTE，而每级VPN刚好有9位，与512个PTE一一对应)。
	3.检查PTE的 v bit，如果不合法，应该产生page fault异常。
	4检查PTE的 Rwx bits,如果全部为0，则从PTE中的PPN[2-0]得到的是下一级页表的物理地址则回到
	第二步。否则当前为最后一级页表，PPNI2-01得到的是最终物理页的地址。
	5.将得到最终的物理页地址，与偏移地址相加，得到最终的物理地址。
	6.对齐注意
    */
    
    unsigned long offset = 0;
    
    while (offset < sz) {
        unsigned long vpn2 = (va >> 30) & 0x1ff;
        unsigned long vpn1 = (va >> 21) & 0x1ff;
        unsigned long vpn0 = (va >> 12) & 0x1ff;
        unsigned long *pgtbl1;
        unsigned long *pgtbl0;
        // 处理第二层页表
        if (!(pgtbl[vpn2] & 0x1)) {
            // 给Invalid页新分配空间
            pgtbl1 = (unsigned long*)(kalloc());
            pgtbl[vpn2] = (((((unsigned long)pgtbl1 - PA2VA_OFFSET) >> 12) << 10) | 0x1);
        }
        else {
            pgtbl1 = (unsigned long*)(((pgtbl[vpn2] >>10) << 12) + PA2VA_OFFSET);
        }
        // 处理第三层页表
        if (!(pgtbl1[vpn1] & 0x1)) {
            // 给Invalid页新分配空间
            pgtbl0 = (unsigned long*)(kalloc());
            pgtbl1[vpn1] = (((((unsigned long)pgtbl0 - PA2VA_OFFSET) >> 12) << 10) | 0x1);
        }
        else {
            pgtbl0 = (unsigned long*)(((pgtbl1[vpn1] >>10) << 12)+ PA2VA_OFFSET);
        }
        // 处理需要映射的物理地址
        if (!(pgtbl0[vpn0] & 0x1)) {
            pgtbl0[vpn0] = ((pa>>12)<<10) | (perm & 0xff);
        }

        va+=PGSIZE;
    	pa+=PGSIZE;
    	offset += PGSIZE;
    }
    
    return;
}

// 检查某一页是否已被映射（返回1：已映射；返回0：未映射）
int check_mapped(uint64 *pgtbl, uint64 va){
	unsigned long vpn2 = (va >> 30) & 0x1ff;
    unsigned long vpn1 = (va >> 21) & 0x1ff;
    unsigned long vpn0 = (va >> 12) & 0x1ff;
    unsigned long *pgtbl1;
    unsigned long *pgtbl0;
    // 处理第二层页表
    if(!(pgtbl[vpn2] & 0x1)){
    	return 0;
    }else{
    	pgtbl1 = (unsigned long*)(((pgtbl[vpn2] >>10) << 12) + PA2VA_OFFSET);
    }
    // 处理第三层页表
    if(!(pgtbl1[vpn1] & 0x1)){
    	return 0;
    }else{
    	pgtbl0 = (unsigned long*)(((pgtbl1[vpn1] >>10) << 12)+ PA2VA_OFFSET);
    }
    // 处理需要映射的物理地址
    if (!(pgtbl0[vpn0] & 0x1)){
    	return 0;
    }
    
    return 1;
}


