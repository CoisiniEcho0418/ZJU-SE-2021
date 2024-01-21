#include "syscall.h"
#include "stdio.h"

int counter = 0;

static inline long getpid() {
    long ret;
    asm volatile ("li a7, %1\n"
                  "ecall\n"
                  "mv %0, a0\n"
                : "+r" (ret) 
                : "i" (SYS_GETPID));
    return ret;
}

static inline long fork()
{
  long ret;
  asm volatile ("li a7, %1\n"
                "ecall\n"
                "mv %0, a0\n"
                : "+r" (ret) : "i" (SYS_CLONE));
  return ret;
}

//int main() {
//    register unsigned long current_sp __asm__("sp");
//    while (1) {
//        printf("[U-MODE] pid: %ld, sp is %lx, this is print No.%d\n", getpid(), current_sp, ++counter);
//        for (unsigned int i = 0; i < 0x4FFFFFFF; i++);
//    }
//
//    return 0;
//}

int global_variable = 0;

//int main() {
//    int pid;
//
//    for (int i = 0; i < 3; i++)
//        printf("[U] pid: %ld is running!, global_variable: %d\n", getpid(), global_variable++);
//
//    pid = fork();
//    if (pid == 0) {
//        while (1) {
//            printf("[U-CHILD] pid: %ld is running!, global_variable: %d\n", getpid(), global_variable++);
//            for (unsigned int i = 0; i < 0x7FFFFFF; i++);
//        } 
//    } else {
//        while (1) {
//            printf("[U-PARENT] pid: %ld is running!, global_variable: %d\n", getpid(), global_variable++);
//            for (unsigned int i = 0; i < 0x7FFFFFF; i++);
//        } 
//    }
//    return 0;
//}

int main() {

  int pid;

    while(1) {
        printf("[PID = %d] is running, variable: %d\n", getpid(), global_variable++);
        for (unsigned int i = 0; i < 0x7FFFFFF; i++);
    }
}

/*
    Test your `fork` using the following `main`s
*/
// int main() {
//     int pid;

//     pid = fork();

//     if (pid == 0) {
//         while (1) {
//             printf("[U-CHILD] pid: %ld is running!, global_variable: %d\n", getpid(), global_variable++);
//             for (unsigned int i = 0; i < 0x7FFFFFF; i++);
//         } 
//     } else {
//         while (1) {
//             printf("[U-PARENT] pid: %ld is running!, global_variable: %d\n", getpid(), global_variable++);
//             for (unsigned int i = 0; i < 0x7FFFFFF; i++);
//         } 
//     }
//     return 0;
// }

// int main() {
//     int pid;

//     for (int i = 0; i < 3; i++)
//         printf("[U] pid: %ld is running!, global_variable: %d\n", getpid(), global_variable++);

//     pid = fork();

//     if (pid == 0) {
//         while (1) {
//             printf("[U-CHILD] pid: %ld is running!, global_variable: %d\n", getpid(), global_variable++);
//             for (unsigned int i = 0; i < 0x7FFFFFF; i++);
//         } 
//     } else {
//         while (1) {
//             printf("[U-PARENT] pid: %ld is running!, global_variable: %d\n", getpid(), global_variable++);
//             for (unsigned int i = 0; i < 0x7FFFFFF; i++);
//         } 
//     }
//     return 0;
// }

// int main() {

//     printf("[U] pid: %ld is running!, global_variable: %d\n", getpid(), global_variable++);
//     fork();

//     printf("[U] pid: %ld is running!, global_variable: %d\n", getpid(), global_variable++);
//     fork();

//     while(1) {
//         printf("[U] pid: %ld is running!, global_variable: %d\n", getpid(), global_variable++);
//         for (unsigned int i = 0; i < 0x7FFFFFF; i++);
//     }
// }
