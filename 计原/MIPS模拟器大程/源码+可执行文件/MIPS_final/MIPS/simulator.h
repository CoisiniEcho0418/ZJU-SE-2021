#ifndef SIMULATOR_H
#define SIMULATOR_H

#endif // SIMULATOR_H

#include<iostream>
#include<string>
#include<vector>
using namespace std;


//定义内存
const int MEMORY_SIZE = 0x40000000; //定义内存大小为1GB(1024 * 1024 * 1024)
unsigned char memory[MEMORY_SIZE]; //定义内存数组（数组容量过大会导致编译不通过，所以这里限定了内存空间的大小）
//初始化内存
void init_memory() {
    for (int i = 0; i < MEMORY_SIZE; i++) {
        memory[i] = 0x00;
    }
}


//定义寄存器
const int REG_NUM = 32; //定义寄存器数量
signed int reg[REG_NUM]; //32个常用寄存器
unsigned int PC; //PC寄存器
//初始化寄存器和PC
void init_registers() {
    for (int i = 0; i < REG_NUM; i++) {
        reg[i] = 0;
    }
    PC = 0;
}


//将一个字（32位）写入内存的指定地址（小端存储）
void write_word(unsigned int address, unsigned int value) {
    memory[address] = value & 0xff; //写入第1个字节
    memory[address + 1] = (value >> 8) & 0xff; //写入第2个字节
    memory[address + 2] = (value >> 16) & 0xff; //写入第3个字节
    memory[address + 3] = (value >> 24) & 0xff; //写入第4个字节
}

//从内存的指定地址读取一个字（32位）
unsigned int read_word(unsigned int address) {
    unsigned int value = 0;
    value |= memory[address];
    value |= memory[address + 1] << 8;
    value |= memory[address + 2] << 16;
    value |= memory[address + 3] << 24;
    return value;
}

//将字符型指令（32位）转换成unsigned int类型
unsigned int read_instruction(char str[]) {
    unsigned int sum = 0;
    for (int i = 0; i < 32; i++) {
        sum = sum * 2 + str[i] - '0';
    }
    return sum;
}


//***指令集函数***

//---R-type---
//sll
void SLL(unsigned int IR) {
    unsigned int sa = (IR >> 6) & 0x1f;
    unsigned int rd = (IR >> 11) & 0x1f;
    unsigned int rt = (IR >> 16) & 0x1f;
    reg[rd] = reg[rt] << sa;
}
//srl
void SRL(unsigned int IR) {
    unsigned int sa = (IR >> 6) & 0x1f;
    unsigned int rd = (IR >> 11) & 0x1f;
    unsigned int rt = (IR >> 16) & 0x1f;
    reg[rd] = reg[rt] >> sa;
}
//jr
void JR(unsigned int IR) {
    unsigned int rs = (IR >> 21) & 0x1f;
    PC = (unsigned int)reg[rs];
}
//add
void ADD(unsigned int IR) {
    unsigned int rd = (IR >> 11) & 0x1f;
    unsigned int rt = (IR >> 16) & 0x1f;
    unsigned int rs = (IR >> 21) & 0x1f;
    reg[rd] = reg[rs] + reg[rt];
}
//sub
void SUB(unsigned int IR) {
    unsigned int rd = (IR >> 11) & 0x1f;
    unsigned int rt = (IR >> 16) & 0x1f;
    unsigned int rs = (IR >> 21) & 0x1f;
    reg[rd] = reg[rs] - reg[rt];
}
//and
void AND(unsigned int IR) {
    unsigned int rd = (IR >> 11) & 0x1f;
    unsigned int rt = (IR >> 16) & 0x1f;
    unsigned int rs = (IR >> 21) & 0x1f;
    reg[rd] = reg[rs] & reg[rt];
}
//or
void OR(unsigned int IR) {
    unsigned int rd = (IR >> 11) & 0x1f;
    unsigned int rt = (IR >> 16) & 0x1f;
    unsigned int rs = (IR >> 21) & 0x1f;
    reg[rd] = reg[rs] | reg[rt];
}
//xor
void XOR(unsigned int IR) {
    unsigned int rd = (IR >> 11) & 0x1f;
    unsigned int rt = (IR >> 16) & 0x1f;
    unsigned int rs = (IR >> 21) & 0x1f;
    reg[rd] = reg[rs] ^ reg[rt];
}
//nor
void NOR(unsigned int IR) {
    unsigned int rd = (IR >> 11) & 0x1f;
    unsigned int rt = (IR >> 16) & 0x1f;
    unsigned int rs = (IR >> 21) & 0x1f;
    reg[rd] = ~(reg[rs] | reg[rt]);
}
//slt
void SLT(unsigned int IR) {
    unsigned int rd = (IR >> 11) & 0x1f;
    unsigned int rt = (IR >> 16) & 0x1f;
    unsigned int rs = (IR >> 21) & 0x1f;
    if (reg[rs] < reg[rt]) {
        reg[rd] = 1;
    }
    else {
        reg[rd] = 0;
    }
}

//R型指令译码
void R_decode(unsigned int IR) {
    unsigned int func = IR & 0x3f; //取函数码
    switch (func) {
    case 0:  //000000 (sll)
        SLL(IR);
        break;
    case 2:  //000010 (srl)
        SRL(IR);
        break;
    case 8:  //001000 (jr)
        JR(IR);
        break;
    case 32: //100000 (add)
        ADD(IR);
        break;
    case 34: //100010 (sub)
        SUB(IR);
        break;
    case 36: //100100 (and)
        AND(IR);
        break;
    case 37: //100101 (or)
        OR(IR);
        break;
    case 38: //100110 (xor)
        XOR(IR);
        break;
    case 39: //100111 (nor)
        NOR(IR);
        break;
    case 42: //101010 (slt)
        SLT(IR);
        break;

    }
}


//---I-type---
//beq
void BEQ(unsigned int IR) {
    unsigned int rt = (IR >> 16) & 0x1f;
    unsigned int rs = (IR >> 21) & 0x1f;
    signed int offset = IR & 0xffff;
    if(offset >= 0x8000){//最高位是0，说明是负数
        offset = offset | 0xffff0000;//符号位扩展
    }
    offset = offset << 2;
    if (reg[rs] == reg[rt]) { //if (rs == rt) PC <- PC+4 + (sign-extend)offset<<2
        PC = (unsigned int)(PC + offset); //PC+4已经在译码环节之前执行过了
    }
}
//bne
void BNE(unsigned int IR) {
    unsigned int rt = (IR >> 16) & 0x1f;
    unsigned int rs = (IR >> 21) & 0x1f;
    signed int offset = IR & 0xffff;
    if(offset >= 0x8000){//最高位是0，说明是负数
        offset = offset | 0xffff0000;//符号位扩展
    }
    offset = offset << 2;
    if (reg[rs] != reg[rt]) { //if (rs != rt) PC <- PC+4 + (sign-extend)immediate<<2
        PC = (unsigned int)(PC + offset); //PC+4已经在译码环节之前执行过了
    }
}
//addi
void ADDI(unsigned int IR) {
    unsigned int rt = (IR >> 16) & 0x1f;
    unsigned int rs = (IR >> 21) & 0x1f;
    signed int imm = IR & 0xffff;
    if(imm >= 0x8000){//最高位是0，说明是负数
        imm = imm | 0xffff0000;//符号位扩展
    }
    reg[rt] = reg[rs] + imm;
}
//andi
void ANDI(unsigned int IR) {
    unsigned int rt = (IR >> 16) & 0x1f;
    unsigned int rs = (IR >> 21) & 0x1f;
    unsigned int imm = IR & 0xffff; //andi是0扩展而不是符号位扩展 rt <- rs & (zero-extend)immediate
    reg[rt] = reg[rs] & imm;
}
//ori
void ORI(unsigned int IR) {
    unsigned int rt = (IR >> 16) & 0x1f;
    unsigned int rs = (IR >> 21) & 0x1f;
    unsigned int imm = IR & 0xffff; //ori是0扩展而不是符号位扩展 rt <- rs | (zero-extend)immediate
    reg[rt] = reg[rs] | imm;
}
//lw
void LW(unsigned int IR) {
    unsigned int rt = (IR >> 16) & 0x1f;
    unsigned int rs = (IR >> 21) & 0x1f;
    signed int offset = IR & 0xffff;
    if(offset >= 0x8000){//最高位是0，说明是负数
        offset = offset | 0xffff0000;//符号位扩展
    }
    unsigned int address = (unsigned int)((unsigned int)reg[rs] + offset);
    reg[rt] = (int)read_word(address); //rt <- memory[rs + (sign-extend)immediate]
}
//sw
void SW(unsigned int IR) {
    unsigned int rt = (IR >> 16) & 0x1f;
    unsigned int rs = (IR >> 21) & 0x1f;
    signed int offset = IR & 0xffff;
    if(offset >= 0x8000){//最高位是0，说明是负数
        offset = offset | 0xffff0000;//符号位扩展
    }
    unsigned int address = (unsigned int)((unsigned int)reg[rs] + offset);
    unsigned int value = (unsigned int)reg[rt];
    write_word(address, value); //memory[rs + (sign-extend)immediate] <- rt
}


//---J-type---
//j
void J(unsigned int IR) {
    unsigned int label = IR & 0x3ffffff; //取后26位
    PC = (PC & 0xF0000000) | (label << 2);
}
//jal
void JAL(unsigned int IR) {
    reg[31] = PC; //回取ra时要注意转换为unsigned int类型
    unsigned int label = IR & 0x3ffffff; //取后26位
    PC = (PC & 0xF0000000) | (label << 2);
}

//译码
void decode(unsigned int IR) {
    unsigned int op = (IR >> 26) & 0x3f; //取操作码
    switch (op) {
    case 0: //000000 (R型指令)
        R_decode(IR);
        break;
    case 2: //000010 (j)
        J(IR);
        break;
    case 3: //000011 (jal)
        JAL(IR);
        break;
    case 4: //000100 (beq)
        BEQ(IR);
        break;
    case 5: //000101 (bne)
        BNE(IR);
        break;
    case 8: //001000 (addi)
        ADDI(IR);
        break;
    case 12: //001100 (andi)
        ANDI(IR);
        break;
    case 13: //001101 (ori)
        ORI(IR);
        break;
    case 35: //100011 (lw)
        LW(IR);
        break;
    case 43: //101011 (sw)
        SW(IR);
        break;
    }
}


//---OUTPUT---
//将整形转换为8位16进制数
string show_hex(unsigned int val) {
    unsigned int hex[8] = { 0xf0000000,0x0f000000,0x00f00000,0x000f0000,0x0000f000,0x00000f00,0x000000f0,0x0000000f };
    unsigned int temp, offset;
    //输出hex前缀
    string result = "0x";
    for (int i = 0; i < 8; i++) {
        temp = val & hex[i];
        offset = 4 * (7 - i); //右移的位数
        temp = temp >> offset;
        if (temp < 10) {
            char c = temp + '0';
            result.push_back(c);
        }
        else {
            char c = temp - 10 + 'A';
            result.push_back(c);
        }
    }
    return result;
}
//显示32位寄存器的值（16进制）
void show_registers() {
    unsigned int val = 0;//接受寄存器转换为unsigned int之后的值
    //zero寄存器   0
    val = (unsigned int)reg[0];
    cout << "zero:  ";
    show_hex(val);
    //at寄存器     1
    val = (unsigned int)reg[1];
    cout << "at:  ";
    show_hex(val);
    //v0-v1寄存器  2~3
    for (int i = 0; i < 2; i++) {
        val = (unsigned int)reg[2 + i];
        cout << "v" << i << ":  ";
        show_hex(val);
    }
    //a0-a3寄存器  4~7
    for (int i = 0; i < 4; i++) {
        val = (unsigned int)reg[4 + i];
        cout << "a" << i << ":  ";
        show_hex(val);
    }
    //t0-t7寄存器  8~15
    for (int i = 0; i < 8; i++) {
        val = (unsigned int)reg[8 + i];
        cout << "t" << i << ":  ";
        show_hex(val);
    }
    //s0-s7寄存器  16~23
    for (int i = 0; i < 8; i++) {
        val = (unsigned int)reg[16 + i];
        cout << "s" << i << ":  ";
        show_hex(val);
    }
    //t8-t9寄存器  24~25
    for (int i = 8; i <= 9; i++) {
        val = (unsigned int)reg[16 + i];
        cout << "t" << i << ":  ";
        show_hex(val);
    }
    //k0-k1寄存器  26~27
    for (int i = 0; i < 2; i++) {
        val = (unsigned int)reg[26 + i];
        cout << "k" << i << ":  ";
        show_hex(val);
    }
    //gp寄存器     28
    val = (unsigned int)reg[28];
    cout << "gp:  ";
    show_hex(val);
    //sp寄存器     29
    val = (unsigned int)reg[29];
    cout << "sp:  ";
    show_hex(val);
    //s8/fp寄存器  30
    val = (unsigned int)reg[30];
    cout << "fp:  ";
    show_hex(val);
    //ra寄存器     31
    val = (unsigned int)reg[31];
    cout << "ra:  ";
    show_hex(val);
}
//显示一块内存空间的值（16进制）
string show_block(unsigned char mem) {
    unsigned int temp = 0;
    //输出hex前缀
    string str;
    temp = mem & 0xf0;
    temp = temp >> 4;
    if (temp < 10) {
        char c = temp + '0';
        str.push_back(c);
    }
    else {
        char c = temp - 10 + 'A';
        str.push_back(c);
    }
    temp = mem & 0x0f;
    if (temp < 10) {
        char c = temp + '0';
        str.push_back(c);
    }
    else {
        char c = temp - 10 + 'A';
        str.push_back(c);
    }
    return str;
}
//显示某一块内存地址的值
string show_memory(unsigned int addr) {
    string result = "0x";
    //连续输出4块内存空间的值
    //输出第四块
    result += show_block(memory[addr + 3]);
    //输出第三块
    result += show_block(memory[addr + 2]);
    //输出第二块
    result += show_block(memory[addr + 1]);
    //输出第一块
    result += show_block(memory[addr]);
    return result;
}

//输出函数（返回用于图形化界面输出的string数组，两个Register一行）
string* RegOutput() {
    unsigned int val = 0;//接受寄存器转换为unsigned int之后的值
    string *RegStr = new string[16];
    //$zero & $at	1
    RegStr[0] = "| $zero        |";
    val = (unsigned int)reg[0];
    RegStr[0] += show_hex(val);
    RegStr[0] += "| $at            |";
    val = (unsigned int)reg[1];
    RegStr[0] += show_hex(val);
    RegStr[0] += "|";
    //$v0 & $v1		2
    RegStr[1] = "| $v0           |";
    val = (unsigned int)reg[2];
    RegStr[1] += show_hex(val);
    RegStr[1] += "| $v1            |";
    val = (unsigned int)reg[3];
    RegStr[1] += show_hex(val);
    RegStr[1] += "|";
    //$a0 & $a1		3
    RegStr[2] = "| $a0           |";
    val = (unsigned int)reg[4];
    RegStr[2] += show_hex(val);
    RegStr[2] += "| $a1            |";
    val = (unsigned int)reg[5];
    RegStr[2] += show_hex(val);
    RegStr[2] += "|";
    //$a2 & $a3		4
    RegStr[3] = "| $a2           |";
    val = (unsigned int)reg[6];
    RegStr[3] += show_hex(val);
    RegStr[3] += "| $a3            |";
    val = (unsigned int)reg[7];
    RegStr[3] += show_hex(val);
    RegStr[3] += "|";
    //$t0 & $t1		5
    RegStr[4] = "| $t0            |";
    val = (unsigned int)reg[8];
    RegStr[4] += show_hex(val);
    RegStr[4] += "| $t1            |";
    val = (unsigned int)reg[9];
    RegStr[4] += show_hex(val);
    RegStr[4] += "|";
    //$t2 & $t3		6
    RegStr[5] = "| $t2            |";
    val = (unsigned int)reg[10];
    RegStr[5] += show_hex(val);
    RegStr[5] += "| $t3            |";
    val = (unsigned int)reg[11];
    RegStr[5] += show_hex(val);
    RegStr[5] += "|";
    //$t4 & $t5		7
    RegStr[6] = "| $t4            |";
    val = (unsigned int)reg[12];
    RegStr[6] += show_hex(val);
    RegStr[6] += "| $t5            |";
    val = (unsigned int)reg[13];
    RegStr[6] += show_hex(val);
    RegStr[6] += "|";
    //$t6 & $t7		8
    RegStr[7] = "| $t6            |";
    val = (unsigned int)reg[14];
    RegStr[7] += show_hex(val);
    RegStr[7] += "| $t7            |";
    val = (unsigned int)reg[15];
    RegStr[7] += show_hex(val);
    RegStr[7] += "|";
    //$s0 & $s1		9
    RegStr[8] = "| $s0           |";
    val = (unsigned int)reg[16];
    RegStr[8] += show_hex(val);
    RegStr[8] += "| $s1            |";
    val = (unsigned int)reg[17];
    RegStr[8] += show_hex(val);
    RegStr[8] += "|";
    //$s2 & $s3		10
    RegStr[9] = "| $s2           |";
    val = (unsigned int)reg[18];
    RegStr[9] += show_hex(val);
    RegStr[9] += "| $s3            |";
    val = (unsigned int)reg[19];
    RegStr[9] += show_hex(val);
    RegStr[9] += "|";
    //$s4 & $s5		11
    RegStr[10] = "| $s4           |";
    val = (unsigned int)reg[20];
    RegStr[10] += show_hex(val);
    RegStr[10] += "| $s5            |";
    val = (unsigned int)reg[21];
    RegStr[10] += show_hex(val);
    RegStr[10] += "|";
    //$s6 & $s7		12
    RegStr[11] = "| $s6           |";
    val = (unsigned int)reg[22];
    RegStr[11] += show_hex(val);
    RegStr[11] += "| $s7            |";
    val = (unsigned int)reg[23];
    RegStr[11] += show_hex(val);
    RegStr[11] += "|";
    //$t8 & $t9		13
    RegStr[12] = "| $t8            |";
    val = (unsigned int)reg[24];
    RegStr[12] += show_hex(val);
    RegStr[12] += "| $t9             |";
    val = (unsigned int)reg[25];
    RegStr[12] += show_hex(val);
    RegStr[12] += "|";
    //$k0 & $k1		14
    RegStr[13] = "| $k0           |";
    val = (unsigned int)reg[26];
    RegStr[13] += show_hex(val);
    RegStr[13] += "| $k1            |";
    val = (unsigned int)reg[27];
    RegStr[13] += show_hex(val);
    RegStr[13] += "|";
    //$gp & $sp		15
    RegStr[14] = "| $gp          |";
    val = (unsigned int)reg[28];
    RegStr[14] += show_hex(val);
    RegStr[14] += "| $sp            |";
    val = (unsigned int)reg[29];
    RegStr[14] += show_hex(val);
    RegStr[14] += "|";
    //$fp & $ra		16
    RegStr[15] = "| $fp           |";
    val = (unsigned int)reg[30];
    RegStr[15] += show_hex(val);
    RegStr[15] += "| $ra             |";
    val = (unsigned int)reg[31];
    RegStr[15] += show_hex(val);
    RegStr[15] += "|";
    return RegStr;
}




