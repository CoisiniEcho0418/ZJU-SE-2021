#include "firstwindow.h"
#include "mainwindow.h"
#include "./ui_firstwindow.h"
#include <QTextBlock>
#include <QFont>
#include "simulator.h"
#include "disassembler.h"
#include "assemble.h"

bool flag=0;//判断是否是第一次运行单步执行功能


Firstwindow::Firstwindow(QWidget *parent)
    : QWidget(parent)
    , ui(new Ui::Firstwindow)
{
    ui->setupUi(this);
    this->setWindowTitle("MIPS simulator Module2");
}

Firstwindow::~Firstwindow()
{
    delete ui;
}


//非调试执行机器码（直接返回最后结果）
void Firstwindow::on_Execute_clicked()
{
    //初始化
    init_memory();//初始化内存
    init_registers(); //初始化寄存器和PC(PC=0)
    //清空文本框的内容
    ui->plainTextEdit1->clear();
    // 读取文本框中的内容（并将32位机器码写入内存）
    QTextDocument *doc = ui->plainTextEdit_Bcode->document();
    int nCnt = doc->blockCount();
    int instruction_index=0;//记录最后一条指令的存储位置
    char *instruction;//存储指令（32位机器码）
    for(int i=0;i<nCnt;++i)
    {
        unsigned int value = 0;
        QTextBlock textBlock = doc->findBlockByNumber(i);
        QString strtext = textBlock.text();
        QByteArray ba = strtext.toLatin1(); // 将QString转化为char*类型(会在字符串后面加上’\0’)
        instruction=ba.data();
        value = read_instruction(instruction);
        write_word(instruction_index, value);
        instruction_index += 4;
        //ui->plainTextEdit1->appendPlainText(strtext);
    }
    //指令循环
    while(PC!=instruction_index){
        //取指令
        if(PC%4!=0){
            QString line=QString::fromStdString("Error: Instruction address not aligned!");
            ui->plainTextEdit1->appendPlainText(line);
            break;
        }
        unsigned int IR = read_word(PC);//把指令读到IR中
        PC += 4;
        //译码
        decode(IR);
    }

    //OUTPUT（输出寄存器的值）
    QFont font("Microsoft YaHei UI", 9);  // 使用 Arial 字体，字号为 12
    ui->plainTextEdit1->setFont(font);
    vector<string> regstr[16];
    string str="---> [Registers]:";
    QString outstr = QString::fromStdString(str);
    ui->plainTextEdit1->appendPlainText(outstr);
    str="| RegName |  RegValue   | RegName |  RegValue   |";
    outstr = QString::fromStdString(str);
    ui->plainTextEdit1->appendPlainText(outstr);
    string *RegStr = RegOutput();
    for (int var = 0; var < 16; ++var) {
        outstr = QString::fromStdString(RegStr[var]);
        ui->plainTextEdit1->appendPlainText(outstr);
    }
    delete []RegStr;
}

//单步执行机器码
void Firstwindow::on_Step_Execute_clicked()
{
    //判断是否是第一次执行
    if(!flag){
        //初始化
        init_memory();//初始化内存
        init_registers(); //初始化寄存器和PC(PC=0)
        flag=1;
    }

    // 读取文本框中的内容（并将32位机器码写入内存）
    QTextDocument *doc = ui->plainTextEdit_Bcode->document();
    int nCnt = doc->blockCount();
    char *instruction;//存储指令（32位机器码）
    //读取指令并存到内存中
    unsigned int value = 0;
    unsigned int StepIndex = PC / 4;//读取机器码的行数
    //判断是否已经读完文本框中的全部内容
    if(StepIndex > nCnt-1){
        //清空文本框的内容，重新开始执行程序
        ui->plainTextEdit1->clear();
        PC=0;
        StepIndex=0;
        flag=0;
        ui->plainTextEdit_2->clear();
        return;
    }
    //在文本框左侧输出箭头
    ui->plainTextEdit_2->clear();
    for(int i =1;i<=StepIndex;i++){
        QString temp = "\n";
        ui->plainTextEdit_2->insertPlainText(temp);
    }
    QString temp = "-->";
    ui->plainTextEdit_2->insertPlainText(temp);
    //单步读取文本框中的内容
    QTextBlock textBlock = doc->findBlockByNumber(StepIndex);
    QString strtext = textBlock.text();
    QByteArray ba = strtext.toLatin1(); // 将QString转化为char*类型(会在字符串后面加上’\0’)
    instruction=ba.data();
    value = read_instruction(instruction);
    write_word(PC, value);//将指令存到内存中
    PC += 4;
    //ui->plainTextEdit1->appendPlainText(strtext);

    //执行指令
    unsigned int IR = read_word(PC-4);//把指令读到IR中
    //译码（执行）
    decode(IR);

    //OUTPUT（输出寄存器的值）
    QString alignedText="---> [Registers]:\n";
    alignedText += "| RegName \t|  RegValue \t| RegName \t|  RegValue  \t|";
    ui->plainTextEdit1->setPlainText(alignedText);
    string *RegStr = RegOutput();
    for (int var = 0; var < 16; ++var) {
        QString outstr = QString::fromStdString(RegStr[var]);
        ui->plainTextEdit1->appendPlainText(outstr);
    }
    delete []RegStr;

}


//将8位16进制数转化为unsigned int
unsigned int HexToUint(string addr){
    unsigned int result=0;
    for(int i=0;i<8;i++){
        char temp=addr[i];
        if(temp>='0' && temp<='9'){
            result=result*16+temp-'0';
        }else if(temp>='a' && temp<='f'){
            result=result*16+temp-'a'+10;
        }else if(temp>='A' && temp<='F'){
            result=result*16+temp-'A'+10;
        }
    }
    return result;
}

//将string类型转化为unsigned int
unsigned int StrToUint(string value){
    unsigned int result=0;
    if(value[0]!='-'){//不是负数
        for(int i=0;i<value.size();i++){
            char temp=value[i];
            result=result*10+temp-'0';
        }
    }else{//是负数
        unsigned int presult =0;//先算出绝对值
        for(int i=1;i<value.size();i++){
            char temp=value[i];
            presult=presult*10+temp-'0';
        }
        signed int nresult = 0-presult;//再计算负数的补码
        result=(unsigned int)nresult;//强制类型转换输出
    }

    return result;
}


//查询内存的值
void Firstwindow::on_CHECK_clicked()
{
    QString qstr = ui->lineEdit->text(); //获取输入的内容
    string str = qstr.toStdString();
    string addr = str.substr(2,8);
    unsigned int memaddr = HexToUint(addr);
    string str1="---> [Memory]:";
    QString outstr = QString::fromStdString(str1);
    ui->plainTextEdit1->appendPlainText(outstr);
    string str2 = qstr.toStdString();
    str2+=": ";
    str2 += show_memory(memaddr);
    outstr = QString::fromStdString(str2);
    ui->plainTextEdit1->appendPlainText(outstr);
}


//设置内存的值(输出格式：0x+8位16进制内存地址:+设定的值(unsigned int)，例如： 0x00000004:51)
void Firstwindow::on_pushButton_clicked()
{
    QString qstr = ui->lineEdit_2->text(); //获取输入的内容
    string str = qstr.toStdString();
    string addr = str.substr(2,8);
    string value = str.substr(11);
    unsigned int memaddr = HexToUint(addr);
    unsigned int memvalue = StrToUint(value);
    write_word(memaddr,memvalue);
    //返回结果
    string str1="---> Set memory value successfully!\n";
    str1+="MEM["+addr+"]-->"+value;
    QString outstr = QString::fromStdString(str1);
    ui->plainTextEdit1->appendPlainText(outstr);
}


//机器码转汇编
void Firstwindow::on_pushButton_3_clicked()
{
    //清空文本框
    ui->plainTextEdit->clear();
    QTextDocument *doc = ui->plainTextEdit_Bcode->document();
    int nCnt = doc->blockCount();
    QString line,q_rst;
    QTextBlock textBlock;
    string instruction,s_rst;
    for(int i = 0; i < nCnt; ++i)
    {
        textBlock = doc->findBlockByNumber(i);
        line=textBlock.text();
        instruction = line.toStdString();
        s_rst = Disassemble(instruction);
        q_rst = QString::fromStdString(s_rst);
        q_rst.append("\n");
        ui->plainTextEdit->insertPlainText(q_rst);
    }
}


void Firstwindow::on_pushButton_2_clicked()
{
    jumpPos.clear();
    ui->plainTextEdit_Bcode->clear();
    QTextDocument* doc = ui->plainTextEdit->document();	//将plainTextEdit中的内容读取到doc中
    int count = doc->blockCount();	//计算plainTextEdit中的文本块数(行数)count
    QString line;
    QTextBlock textLine;
    inst = initial();
    countLine = 0;
    for (int var = 0; var < count; ++var) {
        QTextBlock textLine = doc->findBlockByNumber(var);
        line=textLine.text();
        string L=line.toStdString();
        if (L.find(':') != -1)
        {
            string Mark;
            Mark = L.substr(0, L.find(':'));
            L.erase(0, L.find(':') + 1);
            if(jumpPos.find(formatString(Mark))==jumpPos.end())
                jumpPos.insert(pair<string, int>(formatString(Mark), countLine));
            else
            {
                line=QString::fromStdString("Mark repeated!");
                ui->plainTextEdit_Bcode->insertPlainText(line);
                return ;
            }
        }
        L=formatString(L);
        if(L=="")
            continue;
        countLine ++;
    }
    countLine = 0;
    for (int var = 0; var < count; ++var) {
        QTextBlock textLine = doc->findBlockByNumber(var);
        line=textLine.text();
        string instruction=line.toStdString();
        string *c=new string();
        if(!assembly(instruction,c))
        {
            line=QString::fromStdString("error occurred here!");
            ui->plainTextEdit_Bcode->insertPlainText(line);
            break;
        }
        line=QString::fromStdString(*c);
        line.append("\n");
        ui->plainTextEdit_Bcode->insertPlainText(line);
    }
}


void Firstwindow::on_pushButton_4_clicked()
{
    MainWindow *w = new MainWindow();
    this->close();
    w->show();
}

