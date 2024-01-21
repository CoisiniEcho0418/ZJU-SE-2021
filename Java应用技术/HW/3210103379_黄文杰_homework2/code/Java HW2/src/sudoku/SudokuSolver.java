package sudoku;

import java.util.Scanner;

import static sudoku.SudokuGenerator.checkValid;
import static sudoku.SudokuGenerator.printSudoku;

public class SudokuSolver {

    // 手动读入数独题目
    private static int[][] inputSudokuManually(Scanner scanner) {
        char[][] sudokuPuzzle = new char[9][9];
        int[][] data = new int[9][9];
        // 读取上一次输入Int留下的换行符
        scanner.nextLine();//将换行符读掉
        System.out.println("请输入输入数独题目(数独题目中的空格请用.来代替),每个数字和'.'之间请不要用空格间隔,每隔9个换一次行:");
        for (int i = 0; i < 9; i++) {
            String row = scanner.next();
            sudokuPuzzle[i] = row.toCharArray();
        }
        return getData(sudokuPuzzle, data);
    };

    // 通过copy数独生成器生成的结果来生成题目
    private static int[][] inputSudokuAutomatically(Scanner scanner) {
        char[][] sudokuPuzzle = new char[9][9];
        int[][] data = new int[9][9];
        // 读取上一次输入Int留下的换行符
        scanner.nextLine();//将换行符读掉
        System.out.println("请粘贴从数独生成器中生成的数独题目:");
        for (int i = 0; i < 9; i++) {
            String row = scanner.nextLine();
            String[] elements = row.split(" ");
            for (int j = 0; j < 9; j++) {
                sudokuPuzzle[i][j] = elements[j].charAt(0);
            }
        }
        return getData(sudokuPuzzle, data);
    };

    // 将字符型的数独棋盘生成int型的数独棋盘
    private static int[][] getData(char[][] sudokuPuzzle, int[][] data) {
        for(int i=0;i<9;i++){
            for(int j=0;j<9;j++){
                if(sudokuPuzzle[i][j]>='1' && sudokuPuzzle[i][j]<='9'){
                    data[i][j]=sudokuPuzzle[i][j]-'0';
                }else if(sudokuPuzzle[i][j]=='.'){
                    data[i][j]=0;
                }else{
                    // 非法字符，异常退出
                    System.out.println("有非法字符，请确保输入的题目只包含数字和'.'字符！");
                    System.exit(1);
                }
            }
        }
        return data;
    };

    // 找到数独棋盘中的第一个空格（以数组的形式来返回x,y下标信息）
    private static int[] findEmptyCell(int[][] data) {
        for (int i = 0; i < 9; i++) {
            for (int j = 0; j < 9; j++) {
                if (data[i][j] == 0) {
                    return new int[]{i, j};
                }
            }
        }
        return null;
    }

    // 递归解题
    private static boolean solveSudoku(int[][] data) {
        int[] emptyCell = findEmptyCell(data);

        if (emptyCell == null) {
            return true; // 无空格，说明已经是一个完成的数独
        }

        int row = emptyCell[0];
        int col = emptyCell[1];

        for (int value = 1; value <= 9; value++) {
            if (checkValid(data, row, col, value)) {
                data[row][col] = value;

                if (solveSudoku(data)) {
                    return true; // 判断是都已经完成
                }

                data[row][col] = 0; // 回溯
            }
        }

        return false;
    }


    public static void main(String[] args) {
        Scanner s = new Scanner(System.in);

        System.out.println("请输入您的选择:");
        System.out.println("1. 手动输入一个题目");
        System.out.println("2. copy数独生成器生成的题目");

        int option =s.nextInt();
        int[][] data = new int[9][9];

        if(option==1){
            data=inputSudokuManually(s);
        } else if (option==2) {
            data=inputSudokuAutomatically(s);
        }else{
            System.out.println("非法字符！");
            System.exit(1);
        }

        if (solveSudoku(data)) {
            System.out.println("\n数独解答如下:");
            printSudoku(data);
        } else {
            System.out.println("该数独无解！");
        }

    }
}
