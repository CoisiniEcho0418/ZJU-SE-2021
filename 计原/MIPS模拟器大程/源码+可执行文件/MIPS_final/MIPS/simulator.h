#ifndef SIMULATOR_H
#define SIMULATOR_H

#endif // SIMULATOR_H

#include<iostream>
#include<string>
#include<vector>
using namespace std;


//�����ڴ�
const int MEMORY_SIZE = 0x40000000; //�����ڴ��СΪ1GB(1024 * 1024 * 1024)
unsigned char memory[MEMORY_SIZE]; //�����ڴ����飨������������ᵼ�±��벻ͨ�������������޶����ڴ�ռ�Ĵ�С��
//��ʼ���ڴ�
void init_memory() {
    for (int i = 0; i < MEMORY_SIZE; i++) {
        memory[i] = 0x00;
    }
}


//����Ĵ���
const int REG_NUM = 32; //����Ĵ�������
signed int reg[REG_NUM]; //32�����üĴ���
unsigned int PC; //PC�Ĵ���
//��ʼ���Ĵ�����PC
void init_registers() {
    for (int i = 0; i < REG_NUM; i++) {
        reg[i] = 0;
    }
    PC = 0;
}


//��һ���֣�32λ��д���ڴ��ָ����ַ��С�˴洢��
void write_word(unsigned int address, unsigned int value) {
    memory[address] = value & 0xff; //д���1���ֽ�
    memory[address + 1] = (value >> 8) & 0xff; //д���2���ֽ�
    memory[address + 2] = (value >> 16) & 0xff; //д���3���ֽ�
    memory[address + 3] = (value >> 24) & 0xff; //д���4���ֽ�
}

//���ڴ��ָ����ַ��ȡһ���֣�32λ��
unsigned int read_word(unsigned int address) {
    unsigned int value = 0;
    value |= memory[address];
    value |= memory[address + 1] << 8;
    value |= memory[address + 2] << 16;
    value |= memory[address + 3] << 24;
    return value;
}

//���ַ���ָ�32λ��ת����unsigned int����
unsigned int read_instruction(char str[]) {
    unsigned int sum = 0;
    for (int i = 0; i < 32; i++) {
        sum = sum * 2 + str[i] - '0';
    }
    return sum;
}


//***ָ�����***

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

//R��ָ������
void R_decode(unsigned int IR) {
    unsigned int func = IR & 0x3f; //ȡ������
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
    if(offset >= 0x8000){//���λ��0��˵���Ǹ���
        offset = offset | 0xffff0000;//����λ��չ
    }
    offset = offset << 2;
    if (reg[rs] == reg[rt]) { //if (rs == rt) PC <- PC+4 + (sign-extend)offset<<2
        PC = (unsigned int)(PC + offset); //PC+4�Ѿ������뻷��֮ǰִ�й���
    }
}
//bne
void BNE(unsigned int IR) {
    unsigned int rt = (IR >> 16) & 0x1f;
    unsigned int rs = (IR >> 21) & 0x1f;
    signed int offset = IR & 0xffff;
    if(offset >= 0x8000){//���λ��0��˵���Ǹ���
        offset = offset | 0xffff0000;//����λ��չ
    }
    offset = offset << 2;
    if (reg[rs] != reg[rt]) { //if (rs != rt) PC <- PC+4 + (sign-extend)immediate<<2
        PC = (unsigned int)(PC + offset); //PC+4�Ѿ������뻷��֮ǰִ�й���
    }
}
//addi
void ADDI(unsigned int IR) {
    unsigned int rt = (IR >> 16) & 0x1f;
    unsigned int rs = (IR >> 21) & 0x1f;
    signed int imm = IR & 0xffff;
    if(imm >= 0x8000){//���λ��0��˵���Ǹ���
        imm = imm | 0xffff0000;//����λ��չ
    }
    reg[rt] = reg[rs] + imm;
}
//andi
void ANDI(unsigned int IR) {
    unsigned int rt = (IR >> 16) & 0x1f;
    unsigned int rs = (IR >> 21) & 0x1f;
    unsigned int imm = IR & 0xffff; //andi��0��չ�����Ƿ���λ��չ rt <- rs & (zero-extend)immediate
    reg[rt] = reg[rs] & imm;
}
//ori
void ORI(unsigned int IR) {
    unsigned int rt = (IR >> 16) & 0x1f;
    unsigned int rs = (IR >> 21) & 0x1f;
    unsigned int imm = IR & 0xffff; //ori��0��չ�����Ƿ���λ��չ rt <- rs | (zero-extend)immediate
    reg[rt] = reg[rs] | imm;
}
//lw
void LW(unsigned int IR) {
    unsigned int rt = (IR >> 16) & 0x1f;
    unsigned int rs = (IR >> 21) & 0x1f;
    signed int offset = IR & 0xffff;
    if(offset >= 0x8000){//���λ��0��˵���Ǹ���
        offset = offset | 0xffff0000;//����λ��չ
    }
    unsigned int address = (unsigned int)((unsigned int)reg[rs] + offset);
    reg[rt] = (int)read_word(address); //rt <- memory[rs + (sign-extend)immediate]
}
//sw
void SW(unsigned int IR) {
    unsigned int rt = (IR >> 16) & 0x1f;
    unsigned int rs = (IR >> 21) & 0x1f;
    signed int offset = IR & 0xffff;
    if(offset >= 0x8000){//���λ��0��˵���Ǹ���
        offset = offset | 0xffff0000;//����λ��չ
    }
    unsigned int address = (unsigned int)((unsigned int)reg[rs] + offset);
    unsigned int value = (unsigned int)reg[rt];
    write_word(address, value); //memory[rs + (sign-extend)immediate] <- rt
}


//---J-type---
//j
void J(unsigned int IR) {
    unsigned int label = IR & 0x3ffffff; //ȡ��26λ
    PC = (PC & 0xF0000000) | (label << 2);
}
//jal
void JAL(unsigned int IR) {
    reg[31] = PC; //��ȡraʱҪע��ת��Ϊunsigned int����
    unsigned int label = IR & 0x3ffffff; //ȡ��26λ
    PC = (PC & 0xF0000000) | (label << 2);
}

//����
void decode(unsigned int IR) {
    unsigned int op = (IR >> 26) & 0x3f; //ȡ������
    switch (op) {
    case 0: //000000 (R��ָ��)
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
//������ת��Ϊ8λ16������
string show_hex(unsigned int val) {
    unsigned int hex[8] = { 0xf0000000,0x0f000000,0x00f00000,0x000f0000,0x0000f000,0x00000f00,0x000000f0,0x0000000f };
    unsigned int temp, offset;
    //���hexǰ׺
    string result = "0x";
    for (int i = 0; i < 8; i++) {
        temp = val & hex[i];
        offset = 4 * (7 - i); //���Ƶ�λ��
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
//��ʾ32λ�Ĵ�����ֵ��16���ƣ�
void show_registers() {
    unsigned int val = 0;//���ܼĴ���ת��Ϊunsigned int֮���ֵ
    //zero�Ĵ���   0
    val = (unsigned int)reg[0];
    cout << "zero:  ";
    show_hex(val);
    //at�Ĵ���     1
    val = (unsigned int)reg[1];
    cout << "at:  ";
    show_hex(val);
    //v0-v1�Ĵ���  2~3
    for (int i = 0; i < 2; i++) {
        val = (unsigned int)reg[2 + i];
        cout << "v" << i << ":  ";
        show_hex(val);
    }
    //a0-a3�Ĵ���  4~7
    for (int i = 0; i < 4; i++) {
        val = (unsigned int)reg[4 + i];
        cout << "a" << i << ":  ";
        show_hex(val);
    }
    //t0-t7�Ĵ���  8~15
    for (int i = 0; i < 8; i++) {
        val = (unsigned int)reg[8 + i];
        cout << "t" << i << ":  ";
        show_hex(val);
    }
    //s0-s7�Ĵ���  16~23
    for (int i = 0; i < 8; i++) {
        val = (unsigned int)reg[16 + i];
        cout << "s" << i << ":  ";
        show_hex(val);
    }
    //t8-t9�Ĵ���  24~25
    for (int i = 8; i <= 9; i++) {
        val = (unsigned int)reg[16 + i];
        cout << "t" << i << ":  ";
        show_hex(val);
    }
    //k0-k1�Ĵ���  26~27
    for (int i = 0; i < 2; i++) {
        val = (unsigned int)reg[26 + i];
        cout << "k" << i << ":  ";
        show_hex(val);
    }
    //gp�Ĵ���     28
    val = (unsigned int)reg[28];
    cout << "gp:  ";
    show_hex(val);
    //sp�Ĵ���     29
    val = (unsigned int)reg[29];
    cout << "sp:  ";
    show_hex(val);
    //s8/fp�Ĵ���  30
    val = (unsigned int)reg[30];
    cout << "fp:  ";
    show_hex(val);
    //ra�Ĵ���     31
    val = (unsigned int)reg[31];
    cout << "ra:  ";
    show_hex(val);
}
//��ʾһ���ڴ�ռ��ֵ��16���ƣ�
string show_block(unsigned char mem) {
    unsigned int temp = 0;
    //���hexǰ׺
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
//��ʾĳһ���ڴ��ַ��ֵ
string show_memory(unsigned int addr) {
    string result = "0x";
    //�������4���ڴ�ռ��ֵ
    //������Ŀ�
    result += show_block(memory[addr + 3]);
    //���������
    result += show_block(memory[addr + 2]);
    //����ڶ���
    result += show_block(memory[addr + 1]);
    //�����һ��
    result += show_block(memory[addr]);
    return result;
}

//�����������������ͼ�λ����������string���飬����Registerһ�У�
string* RegOutput() {
    unsigned int val = 0;//���ܼĴ���ת��Ϊunsigned int֮���ֵ
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




