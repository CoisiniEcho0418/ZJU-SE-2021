#include "types.h"
#define SYS_WRITE   64
#define SYS_GETPID  172

#define SYS_MUNMAP   215
#define SYS_CLONE    220 // fork
#define SYS_MMAP     222
#define SYS_MPROTECT 226

struct pt_regs {
  uint64 x[32];
  uint64 sepc;
    uint64 sstatus;
    uint64 stval;
    uint64 sscratch;
    uint64 scause;
};

void syscall(struct pt_regs* regs);
uint64 sys_clone(struct pt_regs *regs);
