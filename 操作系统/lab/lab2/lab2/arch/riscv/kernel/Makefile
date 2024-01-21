#所有汇编源代码文件
ASM_SRC		= $(sort $(wildcard *.S))
#所有C源代码文件
C_SRC       = $(sort $(wildcard *.c))
#所有目标文件
#patsubst 原模式， 目标模式， 文件列表
OBJ		    = $(patsubst %.S,%.o,$(ASM_SRC)) $(patsubst %.c,%.o,$(C_SRC))

all:$(OBJ)

#automatic variables $< The name of the first prerequisite
%.o:%.S
	${GCC}  ${CFLAG} -c $<

%.o:%.c
	${GCC}  ${CFLAG} -c $<

clean:
	$(shell rm *.o 2>/dev/null)
