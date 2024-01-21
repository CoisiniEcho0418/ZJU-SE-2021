.extern start_kernel
.extern mm_init
.extern task_init
.extern setup_vm_final
.extern setup_vm
.extern _traps
.extern PA2VA_OFFSET


     .section .text.init 
    .globl _start
_start:
    # la sp, boot_stack_top
    # sp:0x80200000 
    #li t0, 0x80200   # 将0x80208加载到t0寄存器
    #slli t0, t0, 12  # 左移12位，将高位部分移到正确位置
    #mv sp, t0        # 将t0的值复制到sp寄存器
    
    # 把 t0 的值设为 0xffffffdf80000000 (PA2VA_OFFSET)
    # 先让 t0 -> 0x80000000
    addi t0, x0, 1
    slli t0, t0, 31
    # 再让 t1 -> 0xffffffdf00000000
    lui t1, 0xfffff
    li t2, 0xfdf
    add t1, t1, t2
    slli t1, t1, 32
    # 两者相加 t0 = 0xffffffdf00000000 + 0x80000000
    add t0, t0, t1
    
    la t1, boot_stack_top
    # let boot_stack_top-PA2VA_OFFSET
    sub t1,t1,t0
    mv sp,t1
    
    call setup_vm
    call relocate
    call mm_init
    call setup_vm_final
    call task_init
    
    
    # set stvec = _traps
    la t0, _traps
    csrw stvec, t0
    # set sie[STIE] = 1
    csrr t0, sie
    ori t0,t0, 0x0000000000000020
    csrs sie, t0
    # set first time interrupt
    li a7, 0x0000000000000000
    li a6, 0x0000000000000000
    rdtime a0
    li t0, 10000000
    add a0, a0, t0
    ecall
    # set sstatus[SIE] = 1
    # csrr t0, sie
    # ori t0,t0, 0x0000000000000002
    # csrs sstatus, t0

    j start_kernel
    
relocate:
    # set ra = ra + PA2VA_OFFSET
    # set sp = sp + PA2VA_OFFSET (If you have set the sp before)
   
    ###################### 
    #   YOUR CODE HERE   #
    ######################
    
    # 把 t0 的值设为 0xffffffdf80000000 (PA2VA_OFFSET)
    # 先让 t0 -> 0x80000000
    addi t0, x0, 1
    slli t0, t0, 31
    # 再让 t1 -> 0xffffffdf00000000
    lui t1, 0xfffff
    li t2, 0xfdf
    add t1, t1, t2
    slli t1, t1, 32
    # 两者相加 t0 = 0xffffffdf00000000 + 0x80000000
    add t0, t0, t1
    add ra, ra, t0   # Add PA2VA_OFFSET to ra
    add sp, sp, t0   # Add PA2VA_OFFSET to sp

    # set satp with early_pgtbl
    
    ###################### 
    #   YOUR CODE HERE   #
    ######################
    la t1, early_pgtbl
    sub t1,t1,t0
    li t2,8
    slli t2, t2, 60
    srli t1,t1,12
    or t1,t1,t2
    auipc t2,0
    addi t2,t2,20
    add t2,t2,t0
    csrw stvec, t2
    csrw satp,t1
 
    # flush tlb
    sfence.vma zero, zero
		
    # flush icache
    fence.i
		
    ret
    
    
    .section .bss.stack
    .globl boot_stack
boot_stack:
    .space 4096*4

    .globl boot_stack_top
boot_stack_top:


