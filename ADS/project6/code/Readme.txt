编译要求：已经预装GCC/G++编译器，若没有可以去下载MinGw

编译命令: g++ -std=c++11 main.cpp next_fit.cpp first_fit.cpp data.cpp

编译后运行exe，
输入矩形个数 N 和 texture 的宽度 M（这也是矩形的最大宽度）。
程序中随机生成 N 个高度在 1~100、宽度在 1~M 的矩形，且均为整型值，同时生成后将其写入当前目录下的 data.txt 文件
第一行为 N，随后每行中为一个矩形的高度和宽度。
最后输出各算法得到的高度以及运行时间（单位为 ms）。