import java.util.*;

public class Main {

    // 十进制转十六进制
    public static void main(String[] args) {
        Scanner input = new Scanner(System.in);
        System.out.println("请输入要转换的十进制数：");
        int number = input.nextInt();

        StringBuffer result = new StringBuffer();
        while(true) {
            switch(number%16) {
                case 0: result.append("0"); break;
                case 1: result.append("1"); break;
                case 2: result.append("2"); break;
                case 3: result.append("3"); break;
                case 4: result.append("4"); break;
                case 5: result.append("5"); break;
                case 6: result.append("6"); break;
                case 7: result.append("7"); break;
                case 8: result.append("8"); break;
                case 9: result.append("9"); break;
                case 10: result.append("A"); break;
                case 11: result.append("B"); break;
                case 12: result.append("C"); break;
                case 13: result.append("D"); break;
                case 14: result.append("E"); break;
                case 15: result.append("F"); break;
            }

            if(number/16==0) {
                break;
            }
            number /= 16;
        }
        System.out.format("十进制转为十六进制为：%s", result.reverse().toString());

    }
}