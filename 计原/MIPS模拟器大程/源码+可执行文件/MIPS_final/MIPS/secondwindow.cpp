#include "secondwindow.h"
#include "mainwindow.h"
#include "ui_secondwindow.h"
#include "secondmodule.h"

Secondwindow::Secondwindow(QWidget *parent) :
    QWidget(parent),
    ui(new Ui::Secondwindow)
{
    ui->setupUi(this);
    this->setWindowTitle("MIPS simulator Module 2");
}

Secondwindow::~Secondwindow()
{
    delete ui;
}

void Secondwindow::on_pushButton_clicked()
{
    QString s = ui->lineEdit->text();
    QString OC,RC,CC;
    IntRepresentation(s,&OC,&RC,&CC);
    ui->label_3->setText(OC);
    ui->label_5->setText(RC);
    ui->label_7->setText(CC);
}

void Secondwindow::on_pushButton_2_clicked()
{

    int res=0;
    QString s = ui->lineEdit_2->text();
    QRegularExpression static qr("\\s*");
    s.remove(qr);
    if(s.length()!=32)
    {
        ui->label_15->setText("invalid input");
        return;
    }
    bool valid = true;
    for (const QChar &c : s) {
        if (c != '0' && c != '1') {
            valid = false;
            break;
        }
    }
    if(!valid)
    {
        ui->label_15->setText("invalid input");
        return;
    }
    ComplementToInt(s,&res);
    ui->label_15->setText(QString::number(res,10,0));
}


void Secondwindow::on_pushButton_3_clicked()
{
    double x = ui->lineEdit_3->text().toDouble();
    if(JudgeFloatable(x)==0)
    {
        ui->label_19->setText("警告：该数不能用<float>存储,故作近似");
    }
    else
    {
        ui->label_19->clear();
    }
    char bin[33],hex[9];
    FloatRepresentation(x,bin,hex);
    ui->label_16->setText(QString::number((float)x, 'f', 15));

    ui->label_17->setText(QString::fromUtf8(bin));
    ui->label_24->setText("0x"+QString::fromUtf8(hex));
}

void Secondwindow::on_pushButton_6_clicked()
{
    QString s = ui->lineEdit_6->text();
    QRegularExpression static qr("\\s*");
    s.remove(qr);
    if(s.length()!=32)
    {
        ui->label_47->setText("invalid input");
        return;
    }
    bool valid = true;
    for (const QChar &c : s) {
        if (c != '0' && c != '1') {
            valid = false;
            break;
        }
    }
    if(!valid)
    {
        ui->label_47->setText("invalid input");
        return;
    }
    double res = 0;
    ComplementToFloat(s,&res);
    ui->label_47->setText(QString::number(res,'g',20));
}

void Secondwindow::on_pushButton_7_clicked()
{
    QString s = ui->lineEdit_7->text();
    QRegularExpression static qr("\\s*");
    s.remove(qr);
    if(s.length()!=64)
    {
        ui->label_52->setText("invalid input");
        return;
    }
    bool valid = true;
    for (const QChar &c : s) {
        if (c != '0' && c != '1') {
            valid = false;
            break;
        }
    }
    if(!valid)
    {
        ui->label_52->setText("invalid input");
        return;
    }
    double res = 0;
    ComplementToDouble(s,&res);
    ui->label_52->setText(QString::number(res,'g',20));
}

void Secondwindow::on_pushButton_5_clicked()
{
    long double x = QString(ui->lineEdit_5->text()).toDouble();
    if(JudgeDoubleable(x)==0)
    {
        ui->label_35->setText("警告：该数不能用<double>存储,故作近似");
    }
    else
    {
        ui->label_35->clear();
    }
    char bin[65],hex[17];
    DoubleRepresentation(x,bin,hex);
    ui->label_41->setText(QString::number((double)x, 'f', 15));
    ui->label_42->setText(QString::fromUtf8(bin));
    ui->label_43->setText("0x"+QString::fromUtf8(hex));
}


void Secondwindow::on_pushButton_8_clicked()
{
    ui->textEdit->clear();
    ui->textEdit_2->clear();
    ui->textEdit_3->clear();
    QString s = ui->lineEdit_8->text();
    QRegularExpression static qr("\\s*");
    s.remove(qr);
    QString bin,dec,hex;
    switch(ui->comboBox->currentIndex())
    {
    case 0 :
    {
        bin = s;
        for (QString::ConstIterator it = s.constBegin(); it != s.constEnd(); ++it) {
            const QChar &c = *it;
            if (c != '0' && c != '1') {
                ui->lineEdit_8->setText("Invalid input");
                return;
            }
        }
        BinaryToDecHex(bin,&dec,&hex);
        break;
    }
    case 1:
        dec = s;
        DecToBinaryHex(dec,&bin,&hex);
        break;
    case 2:
        hex = s;
        for (QString::ConstIterator it = s.constBegin(); it != s.constEnd(); ++it) {
            const QChar &c = *it;
            if ((c<'0'||c>'9')&&(c<'a'||c>'f')&&(c<'A'||c>'F')) {
                ui->lineEdit_8->setText("Invalid input");
                return;
            }
        }
        HexToBinaryDec(hex,&bin,&dec);
        break;
    }
    ui->textEdit->setText(bin);
    ui->textEdit_2->setText(dec);
    ui->textEdit_3->setText("0x"+hex);
}




void Secondwindow::on_comboBox_currentIndexChanged(int index)
{
    ui->lineEdit_8->clear();
    ui->textEdit->clear();
    ui->textEdit_2->clear();
    ui->textEdit_3->clear();
}


void Secondwindow::on_pushButton_9_clicked()
{
    MainWindow *w = new MainWindow();
    this->close();
    w->show();
}

