.section .text.entry
    .align 2
    .globl _traps 
    .extern trap_handler
    .global _dummy
    .globl _switch_to
    .extern dummy
_traps:
    csrr t1,sscratch
    beq t1, zero, _traps_switch
    csrw sscratch,sp
    mv sp,t1
_traps_switch:
    addi sp, sp, -33*8
    sd zero, 0*8(sp)
    sd ra, 1*8(sp)
    sd sp, 2*8(sp)
    sd gp, 3*8(sp)
    sd tp, 4*8(sp)
    sd t0, 5*8(sp)
    sd t1, 6*8(sp)
    sd t2, 7*8(sp)
    sd fp, 8*8(sp)
    sd s1, 9*8(sp)
    sd a0, 10*8(sp)
    sd a1, 11*8(sp)
    sd a2, 12*8(sp)
    sd a3, 13*8(sp)
    sd a4, 14*8(sp)
    sd a5, 15*8(sp)
    sd a6, 16*8(sp)
    sd a7, 17*8(sp)
    sd t3, 18*8(sp)
    sd t4, 19*8(sp)
    sd t5, 20*8(sp)
    sd t6, 21*8(sp)
    sd s2, 22*8(sp)
    sd s3, 23*8(sp)
    sd s4, 24*8(sp)
    sd s5, 25*8(sp)
    sd s6, 26*8(sp)
    sd s7, 27*8(sp)
    sd s8, 28*8(sp)
    sd s9, 29*8(sp)
    sd s10, 30*8(sp)
    sd s11, 31*8(sp)
    csrr t0, sepc
    sd t0, 32*8(sp)

    csrr a0, scause
    csrr a1, sepc
    mv a2, sp
    call trap_handler

    ld t0, 32*8(sp)
    csrw sepc, t0
    ld zero, 0*8(sp)
    ld ra, 1*8(sp)
    ld sp, 2*8(sp)
    ld gp, 3*8(sp)
    ld tp, 4*8(sp)
    ld t0, 5*8(sp)
    ld t1, 6*8(sp)
    ld t2, 7*8(sp)
    ld fp, 8*8(sp)
    ld s1, 9*8(sp)
    ld a0, 10*8(sp)
    ld a1, 11*8(sp)
    ld a2, 12*8(sp)
    ld a3, 13*8(sp)
    ld a4, 14*8(sp)
    ld a5, 15*8(sp)
    ld a6, 16*8(sp)
    ld a7, 17*8(sp)
    ld t3, 18*8(sp)
    ld t4, 19*8(sp)
    ld t5, 20*8(sp)
    ld t6, 21*8(sp)
    ld s2, 22*8(sp)
    ld s3, 23*8(sp)
    ld s4, 24*8(sp)
    ld s5, 25*8(sp)
    ld s6, 26*8(sp)
    ld s7, 27*8(sp)
    ld s8, 28*8(sp)
    ld s9, 29*8(sp)
    ld s10, 30*8(sp)
    ld s11, 31*8(sp)
    addi sp, sp, 33*8

    csrr t1,sscratch
    beq t1, zero, _traps_end
    csrw sscratch,sp
    mv sp,t1
_traps_end:
    sret
    
_dummy:
    # la t0,dummy
    # csrw sepc,t0
    csrr t1,sscratch
    csrw sscratch,sp
    mv sp,t1
    sret

_switch_to:

    # save state to prev process
    addi t0, a0, 48
    sd ra, 0(t0)
    sd sp, 8(t0)
    
    addi t0, a0, 64
    sd s0,0(t0)
    sd s1,8(t0)
    sd s2,2*8(t0)
    sd s3,3*8(t0)
    sd s4,4*8(t0)
    sd s5,5*8(t0)
    sd s6,6*8(t0)
    sd s7,7*8(t0)
    sd s8,8*8(t0)
    sd s9,9*8(t0)
    sd s10,10*8(t0)
    sd s11,11*8(t0)

    addi t0, a0, 160
    csrr t1, sepc
    sd t1, 0(t0)
    csrr t1, sstatus
    sd t1, 8(t0)
    csrr t1, sscratch
    sd t1, 16(t0)
    csrr t1, satp
    sd t1, 24(t0)

    # restore state from next process
    addi t0, a1, 48
    ld ra, 0(t0)
    ld sp, 8(t0)

    addi t0, a1, 64
    ld s0,0(t0)
    ld s1,8(t0)
    ld s2,2*8(t0)
    ld s3,3*8(t0)
    ld s4,4*8(t0)
    ld s5,5*8(t0)
    ld s6,6*8(t0)
    ld s7,7*8(t0)
    ld s8,8*8(t0)
    ld s9,9*8(t0)
    ld s10,10*8(t0)
    ld s11,11*8(t0)

    addi t0, a1, 160
    ld t1, 0(t0)
    csrw sepc, t1
    ld t1, 8(t0)
    csrw sstatus, t1
    ld t1, 16(t0)
    csrw sscratch, t1
    ld t1, 24(t0)
    csrw satp, t1

    # flush tlb
    sfence.vma zero, zero	
    # flush icache
    fence.i

    ret

