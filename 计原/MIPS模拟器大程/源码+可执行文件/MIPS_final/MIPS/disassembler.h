#ifndef DIASSEMBLER_H
#define DIASSEMBLER_H


#include<iostream>
#include<bitset>
#include<string>
#include<cmath>
using namespace std;
const int rtype_size = 10;
const int itype_size = 12;


class Disassembler
{
public:
    void input(string instruction);
    string output();
    void trans();

    string get_type();
    string return_regis(string code);
    string trans_rtype();
    string trans_itype();
    string trans_jtype();
    string uint32_to_binary_string(unsigned int x);
    string binary_string_to_int_string(string x);
    string get_immediate_with_sign(string immediate);
private:
    //unsigned int u_instruction;
    string s_instruction;
    string s_type;
    string final;
    string regis[32] = {
        "$zero","$at","$v0","$v1",
        "$a0","$a1","$a2","$a3",
        "$t0","$t1","$t2","$t3",
        "$t4","$t5","$t6","$t7",
        "$s0","$s1","$s2","$s3",
        "$s4","$s5","$s6","$s7",
        "$t8","$t9","$k0","$k1",
        "$gp","$sp","$fp","$ra"
    };
    struct type
    {
        string op;
        string name;
    };
    struct type rtype[rtype_size] = {
        "100000","add", "100010","sub",
        "100100","and", "100101","or", "100110","xor", "100111","nor",
        "101010","slt", "000000","sll", "000010","srl" ,"000011","sra"
    };
    struct type itype[itype_size] = {
        "001000","addi", "001001","addiu", "001100","andi", "001101","ori",
        "001110","xori", "001111","lui", "100011","lw","101011","sw",
        "000100","beq", "000101","bne", "001010","slti", "001011","sltiu"
    };
};
void Disassembler::input(string instruction)
{
    //unsigned int instruction;
    //cout << "Please input the 32-bits instruction(in binary)" << endl;
    //cin >> std::hex >> instruction;
    //string instruction;
    //cin >> instruction;
    this->s_instruction = instruction;
    //this->u_instruction = instruction;
    //this->s_instruction = uint32_to_binary_string(instruction);
    this->s_type = get_type();

}
string Disassembler::output()
{
    // cout << "The uint is " << this->u_instruction << endl;
    //cout << "The string is " << this->s_instruction << endl;
    //cout << "The type is " << this->s_type << endl;
    //cout << "The instruction is: " << endl << this->final;
    string rst = this->final;
    return rst;
}
void Disassembler::trans()
{
    if (s_type == "r") {
        this->final = trans_rtype();
    }
    else if (s_type == "i") {
        this->final = trans_itype();
    }
    else if (s_type == "j") {
        this->final = trans_jtype();
    }
}
string Disassembler::binary_string_to_int_string(string x)
{
    int num = 0;
    for (int i = x.size() - 1; i >= 0; i--) {
        if (x[i] == '1') num += (int)pow(2, x.size() - 1 - i);
    }
    return to_string(num);
}
string Disassembler::uint32_to_binary_string(unsigned int x)
{
    std::bitset<32> binary(x);
    return binary.to_string();
}
string Disassembler::get_type()
{
    string first_6_bits = this->s_instruction.substr(0, 6);//获取指令前6位
    if (first_6_bits == "000000") return "r";
    else if (first_6_bits == "000010" || first_6_bits == "000011") return"j";
    else {
        int i;
        for (i = 0; i < itype_size; i++) {
            if (first_6_bits == this->itype[i].op) return "i";
        }
        if (i >= itype_size) {
            cout << "This is not a valid instruction!" << endl;
            return "false";
        }
    }
}
string Disassembler::get_immediate_with_sign(string immediate)
{
    int len = immediate.length();
    int num = 0;
    string rst;
    if (immediate[0] == '1') {

        immediate = immediate.substr(1, len - 1);//去除符号位
        len--;
        for (int i = 0; i < len; i++) {
            if (immediate[i] == '0') immediate[i] = '1';
            else immediate[i] = '0';
        }
        for (int i = len - 1; i >= 0; i--) {
            if (immediate[i] == '1')
                num += pow(2, len - 1 - i);
        }
        num = -(num + 1);
    }
    else
    {
        for (int i = 0; i < len; i++) {
            if (immediate[i] == '1') {
                num += pow(2, len - 1 - i);
            }
        }
    }
    rst = to_string(num);
    return rst;
}
string Disassembler::return_regis(string code)
{
    int num = 0;
    cout << "code = " << code << ", ";
    for (int i = code.size() - 1; i >= 0; i--) {
        if (code[i] == '1') num += (int)pow(2, code.size() - 1 - i);
    }
    cout << "num = " << num << endl;
    return regis[num];
}
string Disassembler::trans_rtype()
{
    //以下是长度6，5，5，5，5，6
    string opcode, rscode, rtcode, rdcode, shamtcode, funccode;
    //以下是结果汇编语言
    string func, rs, rt, rd, shamt;
    string result;

    opcode = "000000";
    rscode = this->s_instruction.substr(6, 5);
    rtcode = this->s_instruction.substr(11, 5);
    rdcode = this->s_instruction.substr(16, 5);
    shamtcode = this->s_instruction.substr(21, 5);
    funccode = this->s_instruction.substr(26, 6);

    for (int i = 0; i < rtype_size; i++) {
        if (funccode == this->rtype[i].op) func = this->rtype[i].name;
        if (i >= rtype_size) {
            return"Have no this type!";
        }
    }
    cout << "opcode=" << opcode << endl;
    rs = return_regis(rscode); cout << "rscode = " << rscode << ",rs = " << rs << endl;
    rt = return_regis(rtcode); cout << "rtcode = " << rtcode << ",rt = " << rt << endl;
    rd = return_regis(rdcode); cout << "rdcode = " << rdcode << ",rd = " << rd << endl;
    shamt = binary_string_to_int_string(shamtcode); cout << "shamtcode = " << shamtcode << ",shamt = " << shamt << endl;
    cout << "funccode = " << funccode << ",func = " << func << endl;

    if (func == "sll" || func == "srl" || func == "sra") {
        result = func + " " + rd + ", " + rt + ", " + shamt;
    }
    else if (funccode == "001000") {
        func = "jr";
        result = func + " " + rs;
    }
    else {
        result = func + " " + rd + ", " + rs + ", " + rt;
    }
    return result;
}
string Disassembler::trans_itype()
{
    //The length is 6 ,5 ,5 ,16
    string opcode, rscode, rtcode, immediatecode;
    string op, rs, rt, immediate;
    string result;
    string offset;

    //实现addi andi ori beq bne lw sw lui
    opcode = this->s_instruction.substr(0, 6);
    rscode = this->s_instruction.substr(6, 5);
    rtcode = this->s_instruction.substr(11, 5);
    immediatecode = this->s_instruction.substr(16, 16);



    for (int i = 0; i < itype_size; i++) {
        if (opcode == itype[i].op) op = itype[i].name;
    }
    rs = return_regis(rscode);
    rt = return_regis(rtcode);
    offset = get_immediate_with_sign(immediatecode);
    //immediate = binary_string_to_int_string(immediatecode);


    cout << "itype" << endl;
    cout << "opcode = " << opcode << endl;
    cout << "rscode = " << rscode << endl;
    cout << "rtcode = " << rtcode << endl;
    cout << "offset" << offset << endl;

    cout << "op = " << op << endl;
    cout << "rs = " << rs << endl;
    cout << "rt = " << rt << endl;

    if (op == "lui") {
        result = op + " " + rt + ", " + offset;
    }
    else if (op == "lw" || op == "sw") {
        result = op + " " + rt + ", " + offset + "(" + rs + ")";
    }
    else if (op == "beq" || op == "bne") {
        result = op + " " + rs + ", " + rt + ", " + offset;
    }
    else {
        result = op + " " + rt + ", " + rs + ", " + offset;
    }
    return result;
}
string Disassembler::trans_jtype()
{
    string immediatecode, opcode, immedaite, op;
    string result;
    string rscode, rs;

    opcode = this->s_instruction.substr(0, 6);
    rscode = this->s_instruction.substr(6, 5);
    immediatecode = this->s_instruction.substr(6, 26);

    rs = return_regis(rscode);
    immedaite = binary_string_to_int_string(immediatecode);
    if (opcode == "000010") {
        op = "j";
        result = op + " " + immedaite;
    }
    else if (opcode == "000011") {
        op = "jal";
        result = op + " " + immedaite;
    }
    return result;

}
string Disassemble(string instruction)
{
    Disassembler in;
    in.input(instruction);
    in.trans();
    string rst = in.output();
    return rst;
}


#endif // DIASSEMBLER_H
