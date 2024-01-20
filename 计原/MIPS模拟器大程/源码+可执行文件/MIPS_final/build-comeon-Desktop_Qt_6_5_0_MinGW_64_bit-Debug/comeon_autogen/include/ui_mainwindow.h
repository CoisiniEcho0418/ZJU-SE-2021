/********************************************************************************
** Form generated from reading UI file 'mainwindow.ui'
**
** Created by: Qt User Interface Compiler version 6.5.0
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_MAINWINDOW_H
#define UI_MAINWINDOW_H

#include <QtCore/QVariant>
#include <QtWidgets/QApplication>
#include <QtWidgets/QLabel>
#include <QtWidgets/QMainWindow>
#include <QtWidgets/QPushButton>
#include <QtWidgets/QStatusBar>
#include <QtWidgets/QVBoxLayout>
#include <QtWidgets/QWidget>

QT_BEGIN_NAMESPACE

class Ui_MainWindow
{
public:
    QWidget *centralwidget;
    QLabel *label_8;
    QWidget *layoutWidget_2;
    QVBoxLayout *verticalLayout;
    QLabel *label;
    QLabel *label_2;
    QLabel *label_9;
    QLabel *label_3;
    QLabel *label_5;
    QLabel *label_10;
    QLabel *label_7;
    QLabel *label_6;
    QPushButton *pushButton_2;
    QPushButton *pushButton;
    QWidget *layoutWidget;
    QVBoxLayout *verticalLayout_2;
    QLabel *label_11;
    QLabel *label_12;
    QStatusBar *statusbar;

    void setupUi(QMainWindow *MainWindow)
    {
        if (MainWindow->objectName().isEmpty())
            MainWindow->setObjectName("MainWindow");
        MainWindow->resize(502, 457);
        QFont font;
        font.setPointSize(20);
        MainWindow->setFont(font);
        centralwidget = new QWidget(MainWindow);
        centralwidget->setObjectName("centralwidget");
        label_8 = new QLabel(centralwidget);
        label_8->setObjectName("label_8");
        label_8->setGeometry(QRect(10, -40, 481, 451));
        label_8->setAutoFillBackground(false);
        label_8->setStyleSheet(QString::fromUtf8("background-color: rgba(170, 170, 255, 50);"));
        layoutWidget_2 = new QWidget(centralwidget);
        layoutWidget_2->setObjectName("layoutWidget_2");
        layoutWidget_2->setGeometry(QRect(30, 20, 431, 81));
        verticalLayout = new QVBoxLayout(layoutWidget_2);
        verticalLayout->setObjectName("verticalLayout");
        verticalLayout->setContentsMargins(0, 0, 0, 0);
        label = new QLabel(layoutWidget_2);
        label->setObjectName("label");
        QFont font1;
        font1.setPointSize(20);
        font1.setBold(true);
        label->setFont(font1);

        verticalLayout->addWidget(label);

        label_2 = new QLabel(layoutWidget_2);
        label_2->setObjectName("label_2");
        QFont font2;
        font2.setPointSize(11);
        font2.setBold(false);
        label_2->setFont(font2);

        verticalLayout->addWidget(label_2);

        label_9 = new QLabel(centralwidget);
        label_9->setObjectName("label_9");
        label_9->setGeometry(QRect(30, 120, 441, 91));
        label_9->setAutoFillBackground(false);
        label_9->setStyleSheet(QString::fromUtf8("background-color: rgba(255, 255, 255, 100);"));
        label_3 = new QLabel(centralwidget);
        label_3->setObjectName("label_3");
        label_3->setGeometry(QRect(40, 130, 131, 27));
        QSizePolicy sizePolicy(QSizePolicy::Expanding, QSizePolicy::Preferred);
        sizePolicy.setHorizontalStretch(0);
        sizePolicy.setVerticalStretch(0);
        sizePolicy.setHeightForWidth(label_3->sizePolicy().hasHeightForWidth());
        label_3->setSizePolicy(sizePolicy);
        QFont font3;
        font3.setPointSize(14);
        font3.setBold(true);
        label_3->setFont(font3);
        label_3->setStyleSheet(QString::fromUtf8("QLabel {\n"
"    line-height: 50px;\n"
"}"));
        label_3->setLineWidth(1);
        label_3->setMidLineWidth(0);
        label_3->setAlignment(Qt::AlignCenter);
        label_3->setWordWrap(true);
        label_5 = new QLabel(centralwidget);
        label_5->setObjectName("label_5");
        label_5->setGeometry(QRect(50, 160, 441, 40));
        QFont font4;
        font4.setPointSize(10);
        label_5->setFont(font4);
        label_5->setStyleSheet(QString::fromUtf8("QLabel {\n"
"    line-height: 50px;\n"
"}"));
        label_5->setLineWidth(1);
        label_5->setMidLineWidth(0);
        label_5->setAlignment(Qt::AlignLeading|Qt::AlignLeft|Qt::AlignVCenter);
        label_5->setWordWrap(true);
        label_10 = new QLabel(centralwidget);
        label_10->setObjectName("label_10");
        label_10->setGeometry(QRect(30, 220, 441, 91));
        label_10->setAutoFillBackground(false);
        label_10->setStyleSheet(QString::fromUtf8("background-color: rgba(255, 255, 255, 100);"));
        label_7 = new QLabel(centralwidget);
        label_7->setObjectName("label_7");
        label_7->setGeometry(QRect(40, 230, 131, 27));
        sizePolicy.setHeightForWidth(label_7->sizePolicy().hasHeightForWidth());
        label_7->setSizePolicy(sizePolicy);
        label_7->setFont(font3);
        label_7->setStyleSheet(QString::fromUtf8("QLabel {\n"
"    line-height: 50px;\n"
"}"));
        label_7->setLineWidth(1);
        label_7->setMidLineWidth(0);
        label_7->setAlignment(Qt::AlignCenter);
        label_7->setWordWrap(true);
        label_6 = new QLabel(centralwidget);
        label_6->setObjectName("label_6");
        label_6->setGeometry(QRect(50, 260, 441, 40));
        label_6->setFont(font4);
        label_6->setStyleSheet(QString::fromUtf8("QLabel {\n"
"    line-height: 50px;\n"
"}"));
        label_6->setLineWidth(1);
        label_6->setMidLineWidth(0);
        label_6->setAlignment(Qt::AlignLeading|Qt::AlignLeft|Qt::AlignVCenter);
        label_6->setWordWrap(true);
        pushButton_2 = new QPushButton(centralwidget);
        pushButton_2->setObjectName("pushButton_2");
        pushButton_2->setGeometry(QRect(190, 230, 80, 26));
        QSizePolicy sizePolicy1(QSizePolicy::Preferred, QSizePolicy::Fixed);
        sizePolicy1.setHorizontalStretch(0);
        sizePolicy1.setVerticalStretch(0);
        sizePolicy1.setHeightForWidth(pushButton_2->sizePolicy().hasHeightForWidth());
        pushButton_2->setSizePolicy(sizePolicy1);
        QFont font5;
        font5.setPointSize(9);
        font5.setBold(true);
        pushButton_2->setFont(font5);
        pushButton = new QPushButton(centralwidget);
        pushButton->setObjectName("pushButton");
        pushButton->setGeometry(QRect(190, 130, 80, 26));
        sizePolicy1.setHeightForWidth(pushButton->sizePolicy().hasHeightForWidth());
        pushButton->setSizePolicy(sizePolicy1);
        pushButton->setFont(font5);
        layoutWidget = new QWidget(centralwidget);
        layoutWidget->setObjectName("layoutWidget");
        layoutWidget->setGeometry(QRect(30, 330, 441, 41));
        verticalLayout_2 = new QVBoxLayout(layoutWidget);
        verticalLayout_2->setObjectName("verticalLayout_2");
        verticalLayout_2->setContentsMargins(0, 0, 0, 0);
        label_11 = new QLabel(layoutWidget);
        label_11->setObjectName("label_11");
        QFont font6;
        font6.setFamilies({QString::fromUtf8("\346\245\267\344\275\223")});
        font6.setPointSize(10);
        label_11->setFont(font6);
        label_11->setStyleSheet(QString::fromUtf8("QLabel {\n"
"    line-height: 50px;\n"
"}"));
        label_11->setLineWidth(1);
        label_11->setMidLineWidth(0);
        label_11->setAlignment(Qt::AlignCenter);
        label_11->setWordWrap(true);

        verticalLayout_2->addWidget(label_11);

        label_12 = new QLabel(layoutWidget);
        label_12->setObjectName("label_12");
        label_12->setFont(font6);
        label_12->setStyleSheet(QString::fromUtf8("QLabel {\n"
"    line-height: 50px;\n"
"}"));
        label_12->setLineWidth(1);
        label_12->setMidLineWidth(0);
        label_12->setAlignment(Qt::AlignCenter);
        label_12->setWordWrap(true);

        verticalLayout_2->addWidget(label_12);

        MainWindow->setCentralWidget(centralwidget);
        statusbar = new QStatusBar(MainWindow);
        statusbar->setObjectName("statusbar");
        MainWindow->setStatusBar(statusbar);

        retranslateUi(MainWindow);

        QMetaObject::connectSlotsByName(MainWindow);
    } // setupUi

    void retranslateUi(QMainWindow *MainWindow)
    {
        MainWindow->setWindowTitle(QCoreApplication::translate("MainWindow", "MainWindow", nullptr));
        label_8->setText(QString());
        label->setText(QCoreApplication::translate("MainWindow", "Welcome to MIPS simulator", nullptr));
        label_2->setText(QCoreApplication::translate("MainWindow", "You can choose the moduel you want to test.", nullptr));
        label_9->setText(QString());
        label_3->setText(QCoreApplication::translate("MainWindow", "\343\200\220Module1\343\200\221", nullptr));
        label_5->setText(QCoreApplication::translate("MainWindow", "\346\261\207\347\274\226\357\274\214\345\217\215\346\261\207\347\274\226\357\274\214\347\250\213\345\272\217\346\211\247\350\241\214\346\227\266\347\232\204\347\263\273\347\273\237\347\212\266\346\200\201\346\250\241\346\213\237\357\274\210\345\257\204\345\255\230\345\231\250\343\200\201\345\206\205\345\255\230\347\255\211\357\274\211\343\200\202", nullptr));
        label_10->setText(QString());
        label_7->setText(QCoreApplication::translate("MainWindow", "\343\200\220Module2\343\200\221", nullptr));
        label_6->setText(QCoreApplication::translate("MainWindow", "\346\225\264\346\225\260\357\274\210\350\241\245\347\240\201\357\274\211\343\200\201\346\265\256\347\202\271\346\225\260\347\232\204\350\241\250\347\244\272\343\200\201\350\275\254\346\215\242\345\222\214\350\277\220\347\256\227\343\200\202", nullptr));
        pushButton_2->setText(QCoreApplication::translate("MainWindow", "Go", nullptr));
        pushButton->setText(QCoreApplication::translate("MainWindow", "Go", nullptr));
        label_11->setText(QCoreApplication::translate("MainWindow", "--------------------  Develop\357\274\232xxx  --------------------", nullptr));
        label_12->setText(QCoreApplication::translate("MainWindow", "2023.05.20", nullptr));
    } // retranslateUi

};

namespace Ui {
    class MainWindow: public Ui_MainWindow {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_MAINWINDOW_H
