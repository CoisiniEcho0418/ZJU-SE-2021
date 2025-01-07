import java.math.BigDecimal;
import java.math.BigInteger;
import java.math.MathContext;
import java.math.RoundingMode;

/**
@author hwj
@create: 2024-11-09 19:44
@Description: Java十进制浮点数BigDecimal实验探究Demo
*/
public class BigDecimalDemo {
    public static void main(String[] args) {

        // 核心成员变量作用和意义理解举例：
        BigDecimal normalBigDecima = new BigDecimal("3.1415926");
        BigDecimal longBigDecima = new BigDecimal("9223372036854775808");
        BigDecimal longBigDecimaFloat = new BigDecimal("9223372036854775808.123456789");

        // 探究BigDecimal和基本类型浮点数的存储形式
        BigDecimal bd1 = new BigDecimal("123.4500");
        BigDecimal bd2 = BigDecimal.valueOf(0.00012345);
        double db3 = 123.4500;
        double db4 = 0.00012345;
        BigDecimal bd5 = BigDecimal.valueOf(123.4500);
        System.out.println("bd1 value:"+bd1);
        System.out.println("bd2 value:"+bd2);
        System.out.println("bd3 value:"+db3+"  会去除尾随0");
        System.out.println("bd4 value:"+db4+"  会使用科学计数法表示");
        System.out.println("bd5 value:"+bd5+"  使用BigDecimal.valueOf()也会去除尾随0");

        // BigDecimal类型转换
        BigDecimal bigDecimal = new BigDecimal("123.456789");
        int in = bigDecimal.intValue();
        float f = bigDecimal.floatValue();
        double db = bigDecimal.doubleValue();
        long l = bigDecimal.longValue();
        System.out.println("转为int："+in);
        System.out.println("转为float："+f);
        System.out.println("转为double："+db);
        System.out.println("转为long："+l);
        BigInteger bigInteger = bigDecimal.toBigInteger();
        System.out.println("转为BigInteger，会丢弃小数部分："+bigInteger);
        try {
            BigInteger bigInteger1 = bigDecimal.toBigIntegerExact();
            System.out.println("转为BigIntegerExact："+bigInteger1);
        }catch (ArithmeticException ex){
            System.out.println("转为BigIntegerExact需要保证小数部分为0，否则会抛出异常："+ex.getMessage());
        }


        /* ---------经验教训总结--------- */
        // 不推荐用法和推荐用法示例
        BigDecimal bigDecimal1=new BigDecimal(1.2);
        BigDecimal bigDecimal2=new BigDecimal(1.234);
        System.out.println(bigDecimal1);
        System.out.println(bigDecimal2);
        System.out.println(bigDecimal1.add(bigDecimal2));
        BigDecimal bigDecimal3=new BigDecimal("1.2");
        BigDecimal bigDecimal4=new BigDecimal("1.234");
        BigDecimal bigDecimal5 = new BigDecimal("-1.3");
        BigDecimal bigDecimal6 = new BigDecimal(1.3);
        System.out.println(bigDecimal3.add(bigDecimal4));

        // 验证equals方法和compareTo方法
        BigDecimal a_ = new BigDecimal("1");
        BigDecimal b_ = new BigDecimal("1.0");
        System.out.println(a_.equals(b_));//false
        System.out.println(a_.compareTo(b_));

        // 验证除法运算指定精度和未指定精度的情形
        BigDecimal num1 = new BigDecimal("1");
        BigDecimal num2 = new BigDecimal("3");
        BigDecimal result1 = num1.divide(num2,2, RoundingMode.HALF_UP);
        System.out.println(result1);
//        BigDecimal result2 = num1.divide(num2);
//        System.out.println(result2);


        /* ---------探究算术运算对精度损失和误差的影响---------*/
        /* 加法运算 */
        BigDecimal a = new BigDecimal("0.123456789123456789");
        BigDecimal b = new BigDecimal("0.987654321987654321");
        BigDecimal _a = new BigDecimal("-0.123456789123456789");
        // 无精度限制的加法
        System.out.println("无精度限制，加法结果: " + a.add(b));
        System.out.println("无精度限制，相反数加法结果: " + a.add(_a));
        // 限制精度为5，使用四舍五入
        MathContext mc = new MathContext(5, RoundingMode.HALF_UP);
        System.out.println("精度为5，加法结果: " + a.add(b, mc));

        /* 减法运算 */
        BigDecimal c = new BigDecimal("0.11111");
        BigDecimal d = new BigDecimal("0.11111000");
        System.out.println("无精度限制，加法结果: " + c.subtract(d));
        // 限制精度为5，使用五向偶数方向舍入
        MathContext mc2 = new MathContext(5, RoundingMode.HALF_EVEN);
        System.out.println("无精度限制，加法结果: " + c.subtract(d,mc2));

        /* 乘法运算 */
        BigDecimal mul1 = new BigDecimal("1.2345");
        BigDecimal mul2 = new BigDecimal("2.342");
        BigDecimal mulZero = new BigDecimal("0.0000000000");
        // 默认精度
        System.out.println("无精度限制，乘法结果: " + mul1.multiply(mul2));
        System.out.println("无精度限制，乘0乘法结果: " + mul1.multiply(mulZero));
        // 指定精度和舍入模式
        MathContext mcMul = new MathContext(7, RoundingMode.HALF_DOWN);
        System.out.println("精度为7，乘法结果: " + mul1.multiply(mul2, mcMul));
        System.out.println("精度为7，乘0乘法结果: " + mul2.multiply(mulZero, mcMul));

        /* 除法运算 */
        BigDecimal div1 = new BigDecimal("1");
        BigDecimal div2 = new BigDecimal("7");
        BigDecimal div3 = new BigDecimal("0.111111");
        BigDecimal div4 = new BigDecimal("0.777777");
        // 默认的除法（碰到无限循环小数会抛出异常）
        try {
            System.out.println("无精度限制，除法结果: " + div1.divide(div2));
        } catch (ArithmeticException ex) {
            System.out.println("无精度限制，除法异常: " + ex.getMessage());
        }
        try {
            System.out.println("无精度限制，除法结果: " + div3.divide(div4));
        } catch (ArithmeticException ex) {
            System.out.println("无精度限制，除法异常: " + ex.getMessage());
        }
        // 使用不同的舍入模式
        MathContext mc3 = new MathContext(10, RoundingMode.HALF_UP);
        System.out.println("精度为10，舍入模式为 HALF_UP，除法结果: " + div1.divide(div2, mc3));
        MathContext mc4 = new MathContext(10, RoundingMode.FLOOR);
        System.out.println("精度为10，舍入模式为 FLOOR，除法结果: " + div3.divide(div4, mc4));
        // 可以除尽的情形不会出现异常
        BigDecimal div5 = new BigDecimal("0.100");
        BigDecimal div6 = new BigDecimal("0.3200000");
        System.out.println("无精度限制，除法结果无异常，会去除尾随0: " + div5.divide(div6));
        System.out.println("精度为10，舍入模式为 FLOOR，除法结果: " + div5.divide(div6, mc4));
        System.out.println("精度为10，舍入模式为 FLOOR，小数位数为8，除法结果: " + div5.divide(div6, mc4).setScale(8));

        /* 累积运算 */
        BigDecimal g = new BigDecimal("0.0000001");
        BigDecimal sum = BigDecimal.ZERO;
        for (int i = 0; i < 1000000; i++) {
            sum = sum.add(g);
        }
        System.out.println("连续累加后的结果: " + sum);
        // 探究累乘下溢出的情形
        for(int i=0;i<10000;i++){
            try{
                g = g.multiply(g);
                System.out.println("连续累乘后" + i + "次后的结果: " + g);
            }catch (ArithmeticException ex){
                System.out.println("当小数位数超过int可以表示的限度之后会产生异常："+ex.getMessage());
                break;
            }
        }
        // 探究累乘上溢出的情形
        // BigDecimal g1 = new BigDecimal("12345");
        BigDecimal g1 = new BigDecimal("10000");
        for(int i=0;i<10000;i++){
            try{
                g1 = g1.multiply(g1);
                // 大数不会采用科学计数法，为了方便显示，这里改为显示精度位数
                System.out.println("连续累乘后" + i + "次后的结果(精度位数): " + g1.precision());
            }catch (ArithmeticException ex){
                System.out.println("当精度位数超过int可以表示的限度之后会产生异常："+ex.getMessage());
                break;
            }
        }

    }
}
