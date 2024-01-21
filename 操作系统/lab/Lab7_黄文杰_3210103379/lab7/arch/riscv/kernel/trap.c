#include "printk.h"
#include "clock.h"
#include "syscall.h"
#include "stdint.h"
#include "proc.h"
#include "defs.h"
#include "fs.h"
#include "fat32.h"
extern void do_timer(void);
extern struct task_struct *current;

void trap_handler(uint64_t scause, uint64_t sepc, struct pt_regs *regs)
{
    // 判断是否是Interrupt
    if (scause >> 63)
    {

        // 判断是否是timer interrupt
        unsigned long long exception = scause & ~(0x1ULL << 63);
        if (exception == 5)
        {

            clock_set_next_event();
            do_timer();
        }
    }
    else if (scause == 8)
    {
        syscall(regs);
    }
    else if (scause == 12)
    {
        printk("Instruction page fault!\n");
        while(1)
            ;
    }
    else
    {
        printk("%lx\n", scause);
        while(1)
            ;
    }
    return;
}

void syscall(struct pt_regs *regs)
{
    int sys_call_num = regs->x[17];
    if(sys_call_num == SYS_GETPID)
    {
        if (regs->x[10] == 1)
        {
            int i;
            char *buf = (char *)regs->x[11];
            for (i = 0; i < regs->x[12]; i++)
            {
                printk("%c", buf[i]);
            }
            regs->x[10] = i;
        }
        else
        {
            regs->x[10] = -1;
        }
    }
    else if (sys_call_num == SYS_WRITE)
    {
        regs->x[0] = sys_write(regs->x[10], (const char *)(regs->x[11]), regs->x[12]);
        regs->sepc = regs->sepc + 4;
    }
        else if (sys_call_num == SYS_READ)
    {
        regs->x[0] = sys_read(regs->x[10], (const char *)(regs->x[11]), regs->x[12]);
        regs->sepc = regs->sepc + 4;
    }
    else if (sys_call_num == SYS_GETPID)
    {
        regs->x[10] = current->pid;
    }
    else if(sys_call_num == SYS_OPENAT){
        regs->x[10] = sys_openat(regs->x[10], (const char *)(regs->x[11]), regs->x[12]);
    }
    else if(sys_call_num == SYS_LSEEK){
        regs->x[10] = sys_lseek(regs->x[10], regs->x[11], regs->x[12]);
    }
    else if(sys_call_num == SYS_CLOSE){
        regs->x[10] = sys_close(regs->x[10]);
    }
    else
    {
        printk("Unhandled Syscall: 0x%lx\n", sys_call_num);
        while (1);
    }
    regs->sepc += 4;
}
int64_t sys_write(unsigned int fd, const char* buf, uint64_t count) {
    int64_t ret;
    struct file* target_file = &(current->files[fd]);
    if (target_file->opened) {
        target_file->write(target_file, buf, count);
    } else {
        printk("file not open\n");
        ret = ERROR_FILE_NOT_OPEN;
    }
    return ret;
}
int64_t sys_read(unsigned int fd, char* buf, uint64_t count) {
    int64_t ret;
    struct file* target_file = &(current->files[fd]);
    if (target_file->opened)
    {
        target_file->read(target_file, buf, count);
    }
    else
    {
        printk("file not open\n");
        ret = ERROR_FILE_NOT_OPEN;
    }
    return ret;
}
int64_t sys_openat(int dfd, const char* filename, int flags) {
    int fd = -1;

    // Find an available file descriptor first
    for (int i = 0; i < PGSIZE / sizeof(struct file); i++) {
        if (!current->files[i].opened) {
            fd = i;
            break;
        }
    }

    // Do actual open
    file_open(&(current->files[fd]), filename, flags);

    return fd;
}

void file_open(struct file* file, const char* path, int flags) {
    file->opened = 1;
    file->perms = flags;
    file->cfo = 0;
    file->fs_type = get_fs_type(path);
    memcpy(file->path, path, strlen(path) + 1);

    if (file->fs_type == FS_TYPE_FAT32) {
        file->lseek = fat32_lseek;
        file->write = fat32_write;
        file->read = fat32_read;
        file->fat32_file = fat32_open_file(path);
    } else if (file->fs_type == FS_TYPE_EXT2) {
        printk("Unsupport ext2\n");
        while (1);
    } else {
        printk("Unknown fs type: %s\n", path);
        while (1);
    }
}

int64_t sys_lseek(int fd, int64_t offset, int whence) {
    int64_t ret;
    struct file* target_file = &(current->files[fd]);
    if (target_file->opened) {
        target_file->lseek(target_file, offset, whence);
    } else {
        printk("file not open\n");
        ret = ERROR_FILE_NOT_OPEN;
    }
    return ret;
}
int64_t sys_close(int fd) {
    int64_t ret;
    struct file* target_file = &(current->files[fd]);
    if (target_file->opened) {
        target_file->opened = 0;
    } else {
        printk("file not open\n");
        ret = ERROR_FILE_NOT_OPEN;
    }
    return ret;
}