#ifndef FIRSTWINDOW_H
#define FIRSTWINDOW_H

#include <QWidget>
#include <QTextBlock>
#include <QFont>


namespace Ui {
class Firstwindow;
}

class Firstwindow : public QWidget
{
    Q_OBJECT

public:
    explicit Firstwindow(QWidget *parent = nullptr);
    ~Firstwindow();

private slots:
    void on_Execute_clicked();

    void on_Step_Execute_clicked();

    void on_pushButton_clicked();

    void on_CHECK_clicked();

    void on_pushButton_3_clicked();

    void on_pushButton_2_clicked();

    void on_pushButton_4_clicked();

private:
    Ui::Firstwindow *ui;
};

#endif // FIRSTWINDOW_H
