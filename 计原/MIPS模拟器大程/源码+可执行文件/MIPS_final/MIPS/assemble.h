#ifndef ASSEMBLE_H
#define ASSEMBLE_H

#include<iostream>
#include<fstream>
#include<sstream>
#include<vector>
#include<string>
#include<map>
#include<stdio.h>
#include<stdlib.h>
using namespace std;
int Rins(string line, struct Ins* ,string *c);
int Iins(string line, struct Ins*,string *c);
int Jins(string line, struct Ins*,string *c);
map<string, struct Ins*> initial();
string formatString(string str);
string getbinary(int size, int n);
int assembly(string L,string*c);
map<string, struct Ins*>inst;
map<string, int> resgister;
map<string, int> jumpPos;
int countLine = 0;
enum instructionType {
    I,j,R
};
enum instruction {
    RADD, RADDI, RSUB, RSUBI, RAND, RANDI, ROR, RORI, RNOR, RBEQ, RBNE, RJ,RJAL, RJR, RSLT, RLW, RSW, RSRL,RSLL,RXOR
};
struct Ins {
    instruction inst;
    instructionType Type;
    string Func="000000";
};
int assembly(string L,string*c)
{
    string ins;
    string Mark;
    int ifc = 1;
    L=L.substr(0,L.find('#'));
    /*
    if (L.find(':') != -1)
    {
        Mark = L.substr(0, L.find(':'));
        L.erase(0, L.find(':') + 1);
        if(jumpPos.find(formatString(Mark))==jumpPos.end())
        jumpPos.insert(pair<string, int>(formatString(Mark), countLine * 4));
        else
        return 0;
    }*/
    if (L.find(':') != -1)
    {
        string Mark;
        Mark = L.substr(0, L.find(':'));
        L.erase(0, L.find(':') + 1);
    }
    if (L.length() != 0)
        while (L[0] == ' '||L[0] == '\t')
            L.erase(0, 1);
    if (L.length() != 0)
        while (L[L.length() - 1] == ' '||L[L.length()-1] == '\t')
            L.erase(L.length() - 1, 1);
    if (L.find(' ') != -1)
    {
        ins = L.substr(0, L.find(' '));
        map<string, struct Ins*>::iterator iter = inst.find(ins);
        if (iter == inst.end())
            return 0;
        if (inst[ins]->Type == R)
        {
            ifc = Rins(L.substr(L.find(' '), L.length() - L.find(' ')), inst[ins],c);
            if (!ifc)
                return 0;
        }
        else if (inst[ins]->Type == I)
        {
            ifc = Iins(L.substr(L.find(' '), L.length() - L.find(' ')), inst[ins],c);
            if (!ifc)
                return 0;
        }
        else if (inst[ins]->Type == j)
        {
            ifc = Jins(L.substr(L.find(' '), L.length() - L.find(' ')), inst[ins],c);
            if (!ifc)
                return 0;
        }
    }
    countLine++;
    return 1;
}


string formatString(string str) {
    string newStr = str;
    while (1)
    {
        if (newStr.find(" ", 0) > str.size()) {
            break;
        }
        int spaceIndex = newStr.find(" ", 0);
        newStr = newStr.erase(spaceIndex, 1);
    };
    while (1)
    {
        if (newStr.find("\t" , 0) > str.size()) {
            break;
        }
        int spaceIndex = newStr.find("\t", 0);
        newStr = newStr.erase(spaceIndex, 1);
    };
    return newStr;
}
string getbinaryP(int size,int n)
{
    string bin = "";
    int po = 2;
    for (int i = 0; i < size; i++)
    {
        if(n%2==0)
            bin.insert(0,"0");
        else
            bin.insert(0, "1");
        n /= 2;
    }
    return bin;
}
string getbinary(int size,int n)
{
    string bin = "";
    int po = 2;
    if(n>=0)
    {
        for (int i = 0; i < size-1; i++)
        {
            if(n%2==0)
                bin.insert(0,"0");
            else
                bin.insert(0, "1");
            n /= 2;
        }
        bin.insert(0, "0");
    }
    else
    {
        n=-n;
        for (int i = 0; i < size-1; i++)
        {
            if(n%2==0)
                bin.insert(0,"1");
            else
                bin.insert(0, "0");
            n /= 2;
        }
        bin.insert(0, "1");
        for(int i = size; i > 1; i--)
        {
            if(bin[i-1]=='0')
            {
                bin[i-1]='1';
                break;
            }
            else
                bin[i-1]='0';
        }
    }
    return bin;
}
int Rins(string line, struct Ins* ins,string *c)
{
    string res2;
    string res1;
    string res3;
    int shamt;
    line=formatString(line);
    if (line.find('$') == -1)
        return 0;
    res1 = line.substr(line.find_first_of('$') + 1, line.find_first_of(',') - line.find_first_of('$') - 1);
    map<string, int>::iterator iter = resgister.find(res1);
    if (iter == resgister.end())
        return 0;
    if(ins->inst!=RJR)
    {
        line.erase(line.find_first_of('$'), line.find_first_of(',') - line.find_first_of('$')+1);
        if (line.find('$') == -1)
            return 0;
        res2 = line.substr(line.find_first_of('$') + 1, line.find_first_of(',') - line.find_first_of('$') - 1);
        iter = resgister.find(res2);
        if (iter == resgister.end())
            return 0;
        line.erase(line.find_first_of('$'), line.find_first_of(',') - line.find_first_of('$')+1);
        if(ins->inst == RSRL|| ins->inst == RSLL)
            res3=formatString(line) ;
        else
        {
            if (line.find('$') == -1)
                return 0;
            res3 = line.substr(line.find_first_of('$') + 1, line.length()-1);
            iter = resgister.find(res3);
            if (iter == resgister.end())
                return 0;
        }
    }
    string Mcode = "";
    Mcode.append("000000");
    if (ins->inst == RSRL|| ins->inst == RSLL)
    {
        Mcode.append("00000");
        shamt=atoi(res3.c_str());
        Mcode.append(getbinaryP(5, resgister[res2]));
        Mcode.append(getbinaryP(5, resgister[res1]));
        Mcode.append(getbinary(5, shamt));
        Mcode.append(ins->Func);
    }
    else if(ins->inst == RJR)
    {
        Mcode.append(getbinaryP(5, resgister[res1]));
        Mcode.append("00000");
        Mcode.append("00000");
        Mcode.append("00000");
        Mcode.append(ins->Func);
    }
    else
    {
        Mcode.append(getbinaryP(5, resgister[res2]));
        Mcode.append(getbinaryP(5, resgister[res3]));
        Mcode.append(getbinaryP(5, resgister[res1]));
        Mcode.append("00000");
        Mcode.append(ins->Func);
    }
    *c=Mcode;
    return 1;
}
int Iins(string line, struct Ins* ins,string *c)
{
    line = formatString(line);
    if (line.find('$') == -1)
        return 0;
    string res1= line.substr(line.find_first_of('$') + 1, line.find_first_of(',') - line.find_first_of('$') - 1);
    map<string, int>::iterator iter = resgister.find(res1);
    if (iter == resgister.end())
        return 0;
    line.erase(line.find_first_of('$'), line.find_first_of(',') - line.find_first_of('$') + 1);
    string res2;
    string imm;
    int im;
    string Mcode = "";
    if (ins->inst == RLW || ins->inst == RSW)
    {
        res2 = line.substr(line.find_first_of('(') + 2, line.find_first_of(')') - line.find_first_of('(') - 2);
        if (line.find('(') == -1|| line.find(')') == -1)
            return 0;
        iter = resgister.find(res2);
        if (iter == resgister.end())
            return 0;
        imm = line.substr(0, line.find('('));
        im = stoi(imm);
        Mcode.append(ins->Func);
        Mcode.append(getbinaryP(5,resgister[res2]));
        Mcode.append(getbinaryP(5, resgister[res1]));
        Mcode.append(getbinary(16, im));
    }
    else if(ins->inst == RBNE || ins->inst == RBEQ)
    {
        res2 = line.substr(line.find_first_of('$') + 1, line.find_first_of(',') - line.find_first_of('$') - 1);
        iter = resgister.find(res2);
        if (iter == resgister.end())
            return 0;
        line.erase(line.find_first_of('$'), line.find_first_of(',') - line.find_first_of('$') + 1);
        imm = line.substr(0, line.length());
        if(jumpPos.find(imm)!=jumpPos.end())
            im=jumpPos[imm]-countLine-1;
        else
            im = stoi(imm);
        Mcode.append(ins->Func);
        Mcode.append(getbinaryP(5, resgister[res1]));
        Mcode.append(getbinaryP(5, resgister[res2]));
        Mcode.append(getbinary(16, im));
    }
    else
    {
        res2 = line.substr(line.find_first_of('$') + 1, line.find_first_of(',') - line.find_first_of('$') - 1);
        iter = resgister.find(res2);
        if (iter == resgister.end())
            return 0;
        line.erase(line.find_first_of('$'), line.find_first_of(',') - line.find_first_of('$') + 1);
        imm = line.substr(0, line.length());
        if(jumpPos.find(imm)!=jumpPos.end())
            im=jumpPos[imm];
        else
            im = stoi(imm);
        Mcode.append(ins->Func);
        Mcode.append(getbinaryP(5, resgister[res2]));
        Mcode.append(getbinaryP(5, resgister[res1]));
        Mcode.append(getbinary(16, im));
    }
    *c=Mcode;
    return 1;
}
int Jins(string line, struct Ins* ins,string *c)
{
    line = formatString(line);
    map<string, int>::iterator iter = jumpPos.find(line);
    string Mcode = "";
    if (iter != jumpPos.end())
    {
        Mcode.append(ins->Func);
        Mcode.append(getbinary(26,jumpPos[line]));
    }
    else
        return 0;
    *c=Mcode;
    return 1;
}
map<string, struct Ins*> initial()
{
    map<string, struct Ins*>instruction;
    struct Ins* in = new Ins;
    in->inst = RADD;
    in->Type = R;
    in->Func.assign("100000");
    instruction["add"] = in;
    in = new Ins;
    in->inst = RADDI;
    in->Type = I;
    in->Func = "001000";
    instruction["addi"] = in;
    in = new Ins;
    in->inst = RSUB;
    in->Type = R;
    in->Func = "100010";
    instruction["sub"] = in;
    in = new Ins;
    in->inst = RSUBI;//伪addi
    in->Type = I;
    in->Func = "001000";
    instruction["subi"] = in;
    in = new Ins;
    in->inst = RAND;
    in->Type = R;
    in->Func = "100100";
    instruction["and"] = in;
    in = new Ins;
    in->inst = RANDI;
    in->Type = I;
    in->Func = "001100";
    instruction["andi"] = in;
    in = new Ins;
    in->inst = ROR;
    in->Type = R;
    in->Func = "100101";
    instruction["or"] = in;
    in = new Ins;
    in->inst = RORI;
    in->Type = I;
    in->Func = "001101";
    instruction["ori"] = in;
    in = new Ins;
    in->inst = RNOR;
    in->Type = R;
    in->Func = "100111";
    instruction["nor"] = in;
    in = new Ins;
    in->inst = RBEQ;
    in->Type = I;
    in->Func = "000100";
    instruction["beq"] = in;
    in = new Ins;
    in->inst = RBNE;
    in->Type = I;
    in->Func = "000101";
    instruction["bne"] = in;
    in = new Ins;
    in->inst = RJ;
    in->Type = j;
    in->Func = "000010";
    instruction["j"] = in;
    in = new Ins;
    in->inst = RJAL;
    in->Type = j;
    in->Func = "000011";
    instruction["jal"] = in;
    in = new Ins;
    in->inst = RJR;
    in->Type = R;
    in->Func = "001000";
    instruction["jr"] = in;
    in = new Ins;
    in->inst = RSLT;
    in->Type = R;
    in->Func = "101010";
    instruction["slt"] = in;
    in = new Ins;
    in->inst = RLW;
    in->Type = I;
    in->Func = "100011";
    instruction["lw"] = in;
    in = new Ins;
    in->inst = RSW;
    in->Type = I;
    in->Func = "101011";
    instruction["sw"] = in;
    in = new Ins;
    in->inst = RSRL;
    in->Type = R;
    in->Func = "000010";
    instruction["srl"] = in;
    in = new Ins;
    in->inst = RSLL;
    in->Type = R;
    in->Func = "000000";
    instruction["sll"] = in;
    in = new Ins;
    in->inst = RXOR;
    in->Type = R;
    in->Func = "100110";
    instruction["xor"] = in;
    resgister["zero"] = 0;
    resgister["v0"] = 2;
    resgister["v1"] = 3;
    resgister["a0"] = 4;
    resgister["a1"] = 5;
    resgister["a2"] = 6;
    resgister["a3"] = 7;
    resgister["t0"] = 8;
    resgister["t1"] = 9;
    resgister["t2"] = 10;
    resgister["t3"] = 11;
    resgister["t4"] = 12;
    resgister["t5"] = 13;
    resgister["t6"] = 14;
    resgister["t7"] = 15;
    resgister["s0"] = 16;
    resgister["s1"] = 17;
    resgister["s2"] = 18;
    resgister["s3"] = 19;
    resgister["s4"] = 20;
    resgister["s5"] = 21;
    resgister["s6"] = 22;
    resgister["s7"] = 23;
    resgister["t8"] = 24;
    resgister["t9"] = 25;
    resgister["k0"] = 26;
    resgister["k1"] = 27;
    resgister["gp"] = 28;
    resgister["sp"] = 29;
    resgister["fp"] = 30;
    resgister["ra"] = 31;
    return instruction;
}

#endif // ASSEMBLE_H
