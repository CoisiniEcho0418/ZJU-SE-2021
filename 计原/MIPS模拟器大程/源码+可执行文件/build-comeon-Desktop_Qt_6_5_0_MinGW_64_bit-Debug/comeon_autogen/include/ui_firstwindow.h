/********************************************************************************
** Form generated from reading UI file 'firstwindow.ui'
**
** Created by: Qt User Interface Compiler version 6.5.0
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_FIRSTWINDOW_H
#define UI_FIRSTWINDOW_H

#include <QtCore/QVariant>
#include <QtWidgets/QApplication>
#include <QtWidgets/QLabel>
#include <QtWidgets/QLineEdit>
#include <QtWidgets/QPlainTextEdit>
#include <QtWidgets/QPushButton>
#include <QtWidgets/QWidget>

QT_BEGIN_NAMESPACE

class Ui_Firstwindow
{
public:
    QPushButton *Execute;
    QPushButton *CHECK;
    QLineEdit *lineEdit_2;
    QPushButton *pushButton;
    QLineEdit *lineEdit;
    QLabel *label;
    QPushButton *Step_Execute;
    QLabel *label_3;
    QLabel *label_5;
    QPlainTextEdit *plainTextEdit1;
    QPushButton *pushButton_4;
    QLabel *label_6;
    QPlainTextEdit *plainTextEdit;
    QLabel *label_4;
    QPushButton *pushButton_2;
    QLabel *label_7;
    QPlainTextEdit *plainTextEdit_Bcode;
    QPlainTextEdit *plainTextEdit_2;
    QLabel *label_2;
    QPushButton *pushButton_3;

    void setupUi(QWidget *Firstwindow)
    {
        if (Firstwindow->objectName().isEmpty())
            Firstwindow->setObjectName("Firstwindow");
        Firstwindow->resize(1125, 558);
        Execute = new QPushButton(Firstwindow);
        Execute->setObjectName("Execute");
        Execute->setGeometry(QRect(870, 480, 111, 51));
        QFont font;
        font.setPointSize(10);
        font.setBold(true);
        Execute->setFont(font);
        CHECK = new QPushButton(Firstwindow);
        CHECK->setObjectName("CHECK");
        CHECK->setGeometry(QRect(1000, 50, 81, 41));
        CHECK->setFont(font);
        lineEdit_2 = new QLineEdit(Firstwindow);
        lineEdit_2->setObjectName("lineEdit_2");
        lineEdit_2->setGeometry(QRect(730, 130, 251, 41));
        pushButton = new QPushButton(Firstwindow);
        pushButton->setObjectName("pushButton");
        pushButton->setGeometry(QRect(1000, 130, 81, 41));
        pushButton->setFont(font);
        lineEdit = new QLineEdit(Firstwindow);
        lineEdit->setObjectName("lineEdit");
        lineEdit->setGeometry(QRect(730, 50, 251, 41));
        label = new QLabel(Firstwindow);
        label->setObjectName("label");
        label->setGeometry(QRect(730, 20, 110, 20));
        label->setFont(font);
        Step_Execute = new QPushButton(Firstwindow);
        Step_Execute->setObjectName("Step_Execute");
        Step_Execute->setGeometry(QRect(730, 480, 121, 51));
        Step_Execute->setFont(font);
        label_3 = new QLabel(Firstwindow);
        label_3->setObjectName("label_3");
        label_3->setGeometry(QRect(730, 100, 143, 20));
        label_3->setFont(font);
        label_5 = new QLabel(Firstwindow);
        label_5->setObjectName("label_5");
        label_5->setGeometry(QRect(730, 180, 69, 20));
        label_5->setFont(font);
        plainTextEdit1 = new QPlainTextEdit(Firstwindow);
        plainTextEdit1->setObjectName("plainTextEdit1");
        plainTextEdit1->setGeometry(QRect(730, 210, 351, 261));
        plainTextEdit1->setReadOnly(true);
        pushButton_4 = new QPushButton(Firstwindow);
        pushButton_4->setObjectName("pushButton_4");
        pushButton_4->setGeometry(QRect(1000, 480, 81, 51));
        pushButton_4->setFont(font);
        pushButton_4->setStyleSheet(QString::fromUtf8("background-color: rgba(170, 170, 255, 50);"));
        label_6 = new QLabel(Firstwindow);
        label_6->setObjectName("label_6");
        label_6->setGeometry(QRect(10, 10, 341, 531));
        label_6->setStyleSheet(QString::fromUtf8("background-color: rgba(255, 170, 0, 50);"));
        plainTextEdit = new QPlainTextEdit(Firstwindow);
        plainTextEdit->setObjectName("plainTextEdit");
        plainTextEdit->setGeometry(QRect(20, 50, 321, 421));
        label_4 = new QLabel(Firstwindow);
        label_4->setObjectName("label_4");
        label_4->setGeometry(QRect(20, 20, 171, 20));
        label_4->setFont(font);
        pushButton_2 = new QPushButton(Firstwindow);
        pushButton_2->setObjectName("pushButton_2");
        pushButton_2->setGeometry(QRect(100, 480, 141, 51));
        pushButton_2->setFont(font);
        label_7 = new QLabel(Firstwindow);
        label_7->setObjectName("label_7");
        label_7->setGeometry(QRect(360, 10, 361, 531));
        label_7->setStyleSheet(QString::fromUtf8("background-color: rgba(170, 255, 127, 50);"));
        plainTextEdit_Bcode = new QPlainTextEdit(Firstwindow);
        plainTextEdit_Bcode->setObjectName("plainTextEdit_Bcode");
        plainTextEdit_Bcode->setGeometry(QRect(400, 50, 311, 421));
        plainTextEdit_2 = new QPlainTextEdit(Firstwindow);
        plainTextEdit_2->setObjectName("plainTextEdit_2");
        plainTextEdit_2->setGeometry(QRect(370, 50, 31, 421));
        plainTextEdit_2->setStyleSheet(QString::fromUtf8("QPalette palette = ui->plainTextEdit->palette();\n"
"palette.setColor(QPalette::Base, QColor(\"#F0F0F0\"));\n"
"ui->plainTextEdit->setPalette(palette);"));
        plainTextEdit_2->setReadOnly(true);
        label_2 = new QLabel(Firstwindow);
        label_2->setObjectName("label_2");
        label_2->setGeometry(QRect(370, 20, 110, 20));
        label_2->setFont(font);
        pushButton_3 = new QPushButton(Firstwindow);
        pushButton_3->setObjectName("pushButton_3");
        pushButton_3->setGeometry(QRect(480, 480, 141, 51));
        pushButton_3->setFont(font);

        retranslateUi(Firstwindow);

        QMetaObject::connectSlotsByName(Firstwindow);
    } // setupUi

    void retranslateUi(QWidget *Firstwindow)
    {
        Firstwindow->setWindowTitle(QCoreApplication::translate("Firstwindow", "Form", nullptr));
        Execute->setText(QCoreApplication::translate("Firstwindow", "Execute", nullptr));
        CHECK->setText(QCoreApplication::translate("Firstwindow", "CHECK", nullptr));
        pushButton->setText(QCoreApplication::translate("Firstwindow", "SET", nullptr));
        label->setText(QCoreApplication::translate("Firstwindow", "View Memory:", nullptr));
        Step_Execute->setText(QCoreApplication::translate("Firstwindow", "Step Execute", nullptr));
        label_3->setText(QCoreApplication::translate("Firstwindow", "Set Memory Value:", nullptr));
        label_5->setText(QCoreApplication::translate("Firstwindow", "OUTPUT:", nullptr));
        pushButton_4->setText(QCoreApplication::translate("Firstwindow", "Return", nullptr));
        label_6->setText(QString());
        label_4->setText(QCoreApplication::translate("Firstwindow", "Assembly instructions:", nullptr));
        pushButton_2->setText(QCoreApplication::translate("Firstwindow", "Assemble", nullptr));
        label_7->setText(QString());
        label_2->setText(QCoreApplication::translate("Firstwindow", "Machine code:", nullptr));
        pushButton_3->setText(QCoreApplication::translate("Firstwindow", "Disassemble", nullptr));
    } // retranslateUi

};

namespace Ui {
    class Firstwindow: public Ui_Firstwindow {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_FIRSTWINDOW_H
