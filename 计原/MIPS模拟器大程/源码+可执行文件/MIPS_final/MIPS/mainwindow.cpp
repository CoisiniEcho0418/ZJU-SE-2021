#include "mainwindow.h"
#include "firstwindow.h"
#include "secondwindow.h"
#include "./ui_mainwindow.h"

MainWindow::MainWindow(QWidget *parent):
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    this->setWindowTitle("MIPS simulator");

}

MainWindow::~MainWindow()
{
    delete ui;
}


void MainWindow::on_pushButton_2_clicked()
{
    Secondwindow *w = new Secondwindow();
    this->close();
    w->show();
}


void MainWindow::on_pushButton_clicked()
{
    Firstwindow *w = new Firstwindow();
    this->close();
    w->show();
}




