package sudoku;

import java.util.Scanner;

public class SudokuGenerator {
    // 检查某个数能否放入当前的数独棋盘
    public static boolean checkValid(int[][] data,int x,int y, int value){
        // 检查当前的行和列是否已经包含相同的数
        for(int i=0;i<9;i++){
            if(data[x][i]==value){
                return false;
            }
            if(data[i][y]==value){
                return false;
            }
        }

        // 检查小的3*3九宫格是否已经包含相同的数
        int gridRow=3*(x/3);
        int gridCol=3*(y/3);
        for(int i=0;i<3;i++){
            for(int j=0;j<3;j++){
                if((gridRow+i)==x && (gridCol+j)==y){
                    continue;
                }
                if(data[gridRow+i][gridCol+j]==value){
                    return false;
                }
            }
        }
        return true;
    }

    // 打印数独棋盘
    public static void printSudoku(int[][] data){
        for(int i=0;i<9;i++){
            for(int j=0;j<9;j++){
                if(data[i][j]==0){
                    System.out.print(". ");
                }else{
                    System.out.print(data[i][j]+" ");
                }
            }
            System.out.print('\n');
        }
    }

    // 生成数独的棋盘并返回对应的二维数组
    private static void generateSudoku(int hints){
        int[][] data =new int[9][9];
        // 初始化
        for(int i=0;i<9;i++){
            for(int j=0;j<9;j++){
                data[i][j]=0;
            }
        }
        while(hints>0){
            // 生成随机二维数组的index和对应的值
            int x = (int) (Math.random() * 9);
            int y = (int) (Math.random() * 9);
            int value = (int) (Math.random() * 9) + 1;
            // 判断生成的数能否填入现有的棋盘
            if(data[x][y] == 0 && checkValid(data,x,y,value)){
                data[x][y]=value;
                hints--;
            }
        }
        printSudoku(data);
    }


    public static void main(String[] args) {
        Scanner s = new Scanner(System.in);
        System.out.println("请输入提示数:");
        int hints = s.nextInt();
        generateSudoku(hints);
    }
}
