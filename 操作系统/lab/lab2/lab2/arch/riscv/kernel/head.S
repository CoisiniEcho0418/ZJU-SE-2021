.extern start_kernel
.extern mm_init
.extern task_init
.extern _traps:

     .section .text.init 
    .globl _start
_start:
    la sp, boot_stack_top
    call mm_init
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
    csrr t0, sie
    ori t0,t0, 0x0000000000000002
    csrs sstatus, t0

    j start_kernel
    .section .bss.stack
    .globl boot_stack
boot_stack:
    .space 4096*8

    .globl boot_stack_top
boot_stack_top: