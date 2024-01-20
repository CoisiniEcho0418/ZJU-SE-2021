#ifndef SECONDWINDOW_H
#define SECONDWINDOW_H

#include <QWidget>
#include <string.h>
#include <iostream>
#include <math.h>
#include <QRegularExpression>
#include <QString>
#include "QDebug"

namespace Ui {
class Secondwindow;
}

class Secondwindow : public QWidget
{
    Q_OBJECT

public:
    explicit Secondwindow(QWidget *parent = nullptr);
    ~Secondwindow();

private slots:
    void on_pushButton_clicked();

    void on_pushButton_2_clicked();

    void on_pushButton_3_clicked();

    void on_pushButton_5_clicked();

    void on_pushButton_6_clicked();

    void on_pushButton_7_clicked();

    void on_pushButton_8_clicked();

    void on_comboBox_currentIndexChanged(int index);

    void on_pushButton_9_clicked();

private:
    Ui::Secondwindow *ui;
};

#endif // SECONDWINDOW_H
