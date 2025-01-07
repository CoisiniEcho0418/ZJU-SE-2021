# 探索Java编程语言中的十进制浮点数

------

## 一、背景说明

本人最近一年都在使用Java，看到选题中有探究其他编程语言中（e.g., `Python decimal module`, `Java BigDecimal class`）的十进制浮点数，遂想要了解学习并探究一下 Java 的十进制浮点数——`BigDecimal`类。

在了解的过程中，我个人萌生了想要探索 `BigDecimal` 类在**精度处理**和**算术运算下的精度损失和误差**的想法，因而本文将重点从这两个方向展开阐述。



## 二、探索过程

由于本人在之前极少用到 `BigDecimal` 类，因而我先从源码分析入手，通过收集资料和对照源码的方式，了解`BigDecimal`类的内部原理，整理如下。

#### 源码分析

> `BigDecimal`是`Java`中用于浮点数数值计算的类，其主要适合用于处理需要精确表示和运算的场景。**`BigDecimal`不仅能精确表示非常大的或非常小的数字，同时还提供任意精度的运算。其有效的解决了浮点数（`float`和`double`）在进行精确计算时可能出现的舍入误差问题。**
>
> 作者：毅航
> 链接：https://juejin.cn/post/7372863316912521257
> 来源：稀土掘金

**其核心存储涉及的内部成员变量如下：**

```java
public class BigDecimal extends Number implements Comparable<BigDecimal> {
    /**
     * The unscaled value of this BigDecimal, as returned by {@link
     * #unscaledValue}.
     *
     * @serial
     * @see #unscaledValue
     */
    private final BigInteger intVal;

    /**
     * The scale of this BigDecimal, as returned by {@link #scale}.
     *
     * @serial
     * @see #scale
     */
    private final int scale;  // Note: this may have any value, so
                              // calculations must be done in longs

    /**
     * The number of decimal digits in this BigDecimal, or 0 if the
     * number of digits are not known (lookaside information).  If
     * nonzero, the value is guaranteed correct.  Use the precision()
     * method to obtain and set the value if it might be 0.  This
     * field is mutable until set nonzero.
     *
     * @since  1.5
     */
    private transient int precision;

    /**
     * Used to store the canonical string representation, if computed.
     */
    private transient String stringCache;

    /**
     * Sentinel value for {@link #intCompact} indicating the
     * significand information is only available from {@code intVal}.
     */
    static final long INFLATED = Long.MIN_VALUE;

    private static final BigInteger INFLATED_BIGINT = BigInteger.valueOf(INFLATED);

    /**
     * If the absolute value of the significand of this BigDecimal is
     * less than or equal to {@code Long.MAX_VALUE}, the value can be
     * compactly stored in this field and used in computations.
     */
    private final transient long intCompact;

    // All 18-digit base ten strings fit into a long; not all 19-digit
    // strings will
    private static final int MAX_COMPACT_DIGITS = 18;
```

1. **`intVal` (类型：`BigInteger`)——整数域（超过 18 位时使用）**
   - **作用**：`intVal` 存储了 `BigDecimal` 的无缩放值（即不带小数点的整数部分），是一个 `BigInteger` 类型，其核心是用int数组来存储任意长度的整数。这意味着 `BigDecimal` 可以表示极大的整数值而不会溢出。
   - **详细说明**：如果数值超出 `long` 类型的范围或需要高精度时，`intVal` 就会被使用。在 `BigDecimal` 的大多数情况下，它是不可变的，以保证 `BigDecimal` 的不可变性特性。
2. **`scale` (类型：`int`)——表示小数位数**
   - **作用**：`scale` 表示小数点右侧的位数（即十进制精度）。例如，`123.45` 的 `scale` 为 2。
   - **详细说明**：当 `scale` 为正数时，表示十进制的小数位数；若为负数，则表示该 `BigDecimal` 的数值需要乘以 **10^−scale^**。`scale` 变量是用于计算数值位置的，因此必须进行精度较高的长整数计算（`long` 型）。
3. **`precision` (类型：`int`，可变的）——值的有效位数，不包含正负符号**
   - **作用**：`precision` 表示 `BigDecimal` 数值的精度，即十进制数字的总位数。这是一个可变字段，默认值为 `0`，表示当前还未计算精度。
   - **详细说明**：当 `precision` 的值为非零时，表示它是准确的。在需要时可以通过 `precision()` 方法设置或获取值。该字段的存在能够减少重复计算，优化性能。
4. **`stringCache` (类型：`String`，临时）——String缓存**
   - **作用**：`stringCache` 用于缓存 `BigDecimal` 的规范化字符串表示形式（如调用 `toString()` 方法的结果）。
   - **详细说明**：由于 `BigDecimal` 的字符串表示在许多场景中经常使用，此缓存可以避免重复生成字符串，有助于性能优化。
5. **`INFLATED` (类型：`long`，常量）**
   - **作用**：`INFLATED` 是一个哨兵值，用于指示 `intCompact` 的信息仅在 `intVal` 中可用。
   - **详细说明**：如果 `BigDecimal` 的 `intCompact` 字段不能表示其精度（超出 `long` 范围），则该值将设为 `INFLATED`。这表明需要依赖 `intVal` 来获取 `BigDecimal` 的值。
6. **`intCompact` (类型：`long`，临时）——整数域在 long 能够表示的范围内使用，超出能表示范围会被赋为 Long.MIN_VALUE**
   - **作用**：`intCompact` 用于紧凑存储 `BigDecimal` 的有效位数（尾数），当绝对值在 `Long.MAX_VALUE` 范围内时使用它来优化性能。
   - **详细说明**：如果 `BigDecimal` 的数值可以用 `long` 表示，那么 `intCompact` 就会存储该数值，这样在进行算术计算时效率更高。否则，`intCompact` 被设为 `INFLATED`，必须依赖 `intVal` 进行操作。
7. **`MAX_COMPACT_DIGITS` (类型：`int`，常量）**
   - **作用**：`MAX_COMPACT_DIGITS` 指定了可存储在 `intCompact` 中的最大十进制数字数目（18 位）。
   - **详细说明**：如果 `BigDecimal` 数值包含超过 18 位的十进制数字，则无法使用 `long` 来存储。这一常量值用于决定是否需要将 `BigDecimal` 的数值存储在 `intVal` 中，而不是使用 `intCompact` 进行紧凑存储。


理论上来说`BigDecimal`可以表示任意长度的数值，但是受限于 `scale` 和 `precision` 这两个变量值的范围（int最多能表示32bit的整数），所以`BigDecimal`能表示的数，其小数点后的位数和精度不能超过int所能表示的限度。（这个数通常已经非常大了，所以在本实验里不做探究验证）。

为了更好的理解上述变量的意义和作用，下面提供一些例子（其中**9223372036854775808**超过了`long`的最大范围**0x7fffffffffffffff**即**9223372036854775807**）：

![image-20241110165709611](D:\Desktop\汇编与接口\project 1\assets\image-20241110165709611.png)



**相关类：**

> 这部分引用了网上的资料：[BigDecimal 源码分析 JDK8 | GEN](https://gendali.cn/lidagen.github.io/collection/BigDecimal.html#重要相关类)

**RoundingMode**

- 该类是一个枚举类，枚举了 8 种舍入类型：

  - `CEILING` 向正无穷舍入
  - `FLOOR` 向负无穷舍入
  - `DOWN` 向 0 舍入
  - `UP` 与 DOWN 相反
  - `HALF_UP` 五入
  - `HALF_DOWN` 五舍
  - `HALF_EVEN` 五向偶数方向舍入
  - `UNNECESSARY` 表示一定会得到精确结果，得不到时抛异常

  ![img](https://i-blog.csdnimg.cn/blog_migrate/bb0bd93840851d01e03c6f0f6c88ae48.png)

![dock](https://gendali.cn/lidagen.github.io/javaweb/rounding-mode-table.png)

**MathContext**

- 封装了精度及舍入规则，用于算数运算,预定义的一些规则：

```java
//精度为 0，相当于没有配置
public static final MathContext UNLIMITED =
                new MathContext(0, RoundingMode.HALF_UP);

// 精度为 7，舍入策略为 HALF_EVEN
public static final MathContext DECIMAL32 =
                new MathContext(7, RoundingMode.HALF_EVEN);

// 精度为 16，舍入策略为 HALF_EVEN
public static final MathContext DECIMAL64 =
                new MathContext(16, RoundingMode.HALF_EVEN);

// 精度为 34，舍入策略为 HALF_EVEN
public static final MathContext DECIMAL128 =
                new MathContext(34, RoundingMode.HALF_EVEN);
```



**类的算术运算源码如下：**

> 由于源码注释为英文，不便阅读，这里借用网上资料提供的源码分析片段：[BigDecimal源码解析 | Eric Liang](https://ericql.github.io/2019/11/12/01-Java基础篇/02-JDK源码篇/BigDecimal源码解析/)

1. **加法运算**

   ```java
   /**
    * 返回一个 BigDecimal,其值为(this + augend),其标度为max(this.scale(), augend.scale())
    * @param augend	将添加到此 BigDecimal 中的值。
    * @return	this + augend
    */
   public BigDecimal add(BigDecimal augend) {
       if (this.intCompact != INFLATED) {
           if ((augend.intCompact != INFLATED)) {
               return add(this.intCompact, this.scale, augend.intCompact, augend.scale);
           } else {
               return add(this.intCompact, this.scale, augend.intVal, augend.scale);
           }
       } else {
           if ((augend.intCompact != INFLATED)) {
               return add(augend.intCompact, augend.scale, this.intVal, this.scale);
           } else {
               return add(this.intVal, this.scale, augend.intVal, augend.scale);
           }
       }
   }
   
   /**
    * 返回其值为(this + augend)的BigDecimal(根据上下文设置进行舍入)
    * 如果任一数字为零,并且精度设置为非零,则其他数字(必要时进行舍入)可以作为结果
    * @param augend	将添加到此 BigDecimal 中的值
    * @param mc	要使用的上下文
    * @return	this + augend，必要时进行舍入
    */
   public BigDecimal add(BigDecimal augend, MathContext mc) {
       if (mc.precision == 0)
           return add(augend);
       BigDecimal lhs = this;
   
       // 如果任意一个数字都是0,则使用另一个数字(如果需要的话)进行四舍五入和缩放
       {
           boolean lhsIsZero = lhs.signum() == 0; // 判断lhs的值是否为0
           boolean augendIsZero = augend.signum() == 0; // 判断augend的值是否为0
   
           if (lhsIsZero || augendIsZero) {
               // 获取lhs.scale()和augend.scale()中较大的一个
               int preferredScale = Math.max(lhs.scale(), augend.scale());
               BigDecimal result;
   
               if (lhsIsZero && augendIsZero) // 都为0
                   return zeroValueOf(preferredScale);
               // 判断当前对象的值是否为0,根据mc设置返回一个augend或者lhs四舍五入的BigDecimal对象    
               result = lhsIsZero ? doRound(augend, mc) : doRound(lhs, mc);
   
               if (result.scale() == preferredScale) // 判断结果标度是否为最大
                   return result;
               else if (result.scale() > preferredScale) { // 结果标度大于最大
                   // 从当前BigDecimal对象中删除不重要的后置零,直到不能删除更多的零为止
                   return stripZerosToMatchScale(result.intVal, result.intCompact, result.scale, preferredScale);
               } else { // result.scale < preferredScale
                   int precisionDiff = mc.precision - result.precision();
                   int scaleDiff     = preferredScale - result.scale();
   
                   if (precisionDiff >= scaleDiff) // 精度差大于等于标度差
                       return result.setScale(preferredScale); // 可以达到目标规模
                   else
                       return result.setScale(result.scale() + precisionDiff);
               }
           }
       }
   
       long padding = (long) lhs.scale - augend.scale;
       if (padding != 0) { // 标度不同;需要对齐
           // 返回一个长度为2的数组,其条目的和等于lhs和augend参数的整数和
           BigDecimal arg[] = preAlign(lhs, augend, padding, mc);
           // 匹配arg[0]和arg[1]的scales，以校准它们的最小有效数字
           matchScale(arg);
           lhs = arg[0];
           augend = arg[1];
       }
       // 根据mc设置返回一个d的四舍五入的BigDecimal对象
       return doRound(lhs.inflated().add(augend.inflated()), lhs.scale, mc);
   }
   
   /**
    * 返回一个长度为2的数组,其条目的和等于lhs和augend参数的整数和
    * 如果数字的位置参数有足够的差距,值较小的可以浓缩成一个"粘滞位",如果最终结果的精度不包括小数量级操作数的高阶数,则最终结果将以相同的方式进行四舍五入
    * 
    * 注意，虽然严格来说这是一种优化，但它的实际应用范围更广。
    * 
    * 这对应于固定精度浮点加法器中的预移位操作;这个方法由于MathContext所决定的结果的可变精度而变得复杂
    * 更细致的操作可以实现较小幅度操作数上的"右偏移",从而即使部分重叠的有效数也可以减少较小操作数的位数
    * @param lhs	当前 BigDecimal 中的值
    * @param augend	将添加到此BigDecimal中的值
    * @param padding  lhs.scale- padding.scale
    * @param mc	要使用的上下文
    * @return
    */
   private BigDecimal[] preAlign(BigDecimal lhs, BigDecimal augend, long padding, MathContext mc) {
       assert padding != 0;
       BigDecimal big;
       BigDecimal small;
   
       if (padding < 0) { // lhs大,被加数小
           big = lhs;
           small = augend;
       } else { // lhs小;被加数大
           big = augend;
           small = lhs;
       }
   
       /*
        * 这是结果的ulp的估计尺度;它假设结果没有一个真正的add(例如999 + 1 => - 1000)或任何一个借位的减法取消(例如：100 - 1.2 = > 98.8)
        */
       long estResultUlpScale = (long) big.scale - big.precision() + mc.precision;
   
       /*
        * big的低位是big.scale().这是真的,不管大的规模是正的还是负的
        * 小的高阶位是small.scale - (small.precision() - 1)
        */
       long smallHighDigitPos = (long) small.scale - small.precision() + 1;
       if (smallHighDigitPos > big.scale + 2 && // 大小不相交
           smallHighDigitPos > estResultUlpScale + 2) { // small 不可见
           small = BigDecimal.valueOf(small.signum(), this.checkScale(Math.max(big.scale, estResultUlpScale) + 3));
       }
   
       // 因为加法是对称的,所以在返回的操作数中保持输入顺序并不重要
       BigDecimal[] result = {big, small};
       return result;
   }
   ```

   

2. **减法运算**

   ```java
   /**
    * 返回一个 BigDecimal,其值为(this - subtrahend),其标度为max(this.scale(), subtrahend.scale()) 
    * @param subtrahend	从此 BigDecimal 减去的值
    * @return	this - subtrahend
    */
   public BigDecimal subtract(BigDecimal subtrahend) {
       if (this.intCompact != INFLATED) {
           if ((subtrahend.intCompact != INFLATED)) {
               return add(this.intCompact, this.scale, -subtrahend.intCompact, subtrahend.scale);
           } else {
               return add(this.intCompact, this.scale, subtrahend.intVal.negate(), subtrahend.scale);
           }
       } else {
           if ((subtrahend.intCompact != INFLATED)) {
               // 在此BigDecimal的值对之前给出的一组减数目的值,以避免对专门化的add方法进行重载
               return add(-subtrahend.intCompact, subtrahend.scale, this.intVal, this.scale);
           } else {
               return add(this.intVal, this.scale, subtrahend.intVal.negate(), subtrahend.scale);
           }
       }
   }
   
   /**
    * 返回其值为(this - subtrahend)的BigDecimal(根据上下文设置进行舍入) 
    * 如果subtrahend为零,则将其(必要时进行舍入)作为结果.如果为零,则该结果是subtrahend.negate(mc)
    * @param subtrahend	从此 BigDecimal 减去的值
    * @param mc	要使用的上下文
    * @return	this - subtrahend，必要时进行舍入
    */
   public BigDecimal subtract(BigDecimal subtrahend, MathContext mc) {
       if (mc.precision == 0)
           return subtract(subtrahend);
       // negate(): 获取当前对象,其值为(-subtrahend),其标度为subtrahend.scale()
       // 在add()中共享特殊的四舍五入
       return add(subtrahend.negate(), mc);
   }
   ```

   

3. **乘法运算**

   ```java
   /**
    * 返回一个 BigDecimal,其值为(this × multiplicand),其标度为(this.scale() + multiplicand.scale())
    * @param multiplicand 乘以此 BigDecimal 的值
    * @return	this * multiplicand
    */
   public BigDecimal multiply(BigDecimal multiplicand) {
       // 验证(long)scale + multiplicand.scale为int,并返回(long)scale + multiplicand.scale值
       int productScale = checkScale((long) scale + multiplicand.scale);
       // 可以做一个更聪明的检查,将INFLATED的检查合并到溢出计算中
       if (this.intCompact != INFLATED) {
           if ((multiplicand.intCompact != INFLATED)) {
               return multiply(this.intCompact, multiplicand.intCompact, productScale);
           } else {
               return multiply(this.intCompact, multiplicand.intVal, productScale);
           }
       // 溢出    
       } else {
           if ((multiplicand.intCompact != INFLATED)) {
               return multiply(multiplicand.intCompact, this.intVal, productScale);
           } else {
               return multiply(this.intVal, multiplicand.intVal, productScale);
           }
       }
   }
   
   /**
    * 返回其值为 (this × multiplicand) 的 BigDecimal(根据上下文设置进行舍入)
    * @param multiplicand	乘以此 BigDecimal 的值
    * @param mc	要使用的上下文
    * @return	必要时舍入的 this * multiplicand
    */
   public BigDecimal multiply(BigDecimal multiplicand, MathContext mc) {
       if (mc.precision == 0)
       	// this * multiplicand
           return multiply(multiplicand);
       // 根据mc设置返回一个(this * multiplicand)四舍五入的BigDecimal对象    
       int productScale = checkScale((long) scale + multiplicand.scale);
       if (this.intCompact != INFLATED) {
           if ((multiplicand.intCompact != INFLATED)) {
               return multiplyAndRound(this.intCompact, multiplicand.intCompact, productScale, mc);
           } else {
               return multiplyAndRound(this.intCompact, multiplicand.intVal, productScale, mc);
           }
       } else {
           if ((multiplicand.intCompact != INFLATED)) {
               return multiplyAndRound(multiplicand.intCompact, this.intVal, productScale, mc);
           } else {
               return multiplyAndRound(this.intVal, multiplicand.intVal, productScale, mc);
           }
       }
   }
   ```

   

4. **除法运算**

   ```java
   /**
    * 返回一个BigDecimal,其值为(this/divisor),其标度为指定标度.如果必须执行舍入,以生成具有指定标度的结果,则应用指定的舍入模式
    * 相对于此遗留方法,应优先使用新的divide(BigDecimal, int, RoundingMode)方法 
    * @param divisor	此 BigDecimal 要除以的值
    * @param scale	要返回的 BigDecimal 商的标度
    * @param roundingMode	要应用的舍入模式
    * @return	this / divisor 
    */
   public BigDecimal divide(BigDecimal divisor, int scale, int roundingMode) {
       /*
        * 注意:这个方法*必须*返回一个新对象，因为divideAndRound使用divide生成一个值，然后修改该值的标度
        */
       if (roundingMode < ROUND_UP || roundingMode > ROUND_UNNECESSARY)
       	// 如果 roundingMode 不表示一个有效的舍入模式
           throw new IllegalArgumentException("Invalid rounding mode");
       if (this.intCompact != INFLATED) {
           if ((divisor.intCompact != INFLATED)) {
               return divide(this.intCompact, this.scale, divisor.intCompact, divisor.scale, scale, roundingMode);
           } else {
               return divide(this.intCompact, this.scale, divisor.intVal, divisor.scale, scale, roundingMode);
           }
       } else {
           if ((divisor.intCompact != INFLATED)) {
               return divide(this.intVal, this.scale, divisor.intCompact, divisor.scale, scale, roundingMode);
           } else {
               return divide(this.intVal, this.scale, divisor.intVal, divisor.scale, scale, roundingMode);
           }
       }
   }
   
   public BigDecimal divide(BigDecimal divisor, int scale, RoundingMode roundingMode) {
       return divide(divisor, scale, roundingMode.oldMode);
   }
   
   /**
    * 返回一个 BigDecimal,其值为(this / divisor),其首选标度为(this.scale() - divisor.scale())
    * 如果无法表示准确的商值(因为它有无穷的十进制扩展),则抛出 ArithmeticException
    * @param divisor	此 BigDecimal 要相除的值
    * @return	this / divisor 
    */
   public BigDecimal divide(BigDecimal divisor) {
       /*
        * 先处理零情况
        */
       if (divisor.signum() == 0) {   // x/0
           if (this.signum() == 0)    // 0/0
               throw new ArithmeticException("Division undefined");  // NaN
           throw new ArithmeticException("Division by zero");
       }
   
       // 计算优先 scale
       // (long)this.scale - divisor.scale强转为int类型,判断是否等于int类型后的值,若果是返回int类型后的值,否则小于0,返回integer最小值,否则最大值
       int preferredScale = saturateLong((long) this.scale - divisor.scale);
   
       if (this.signum() == 0) // 0/y
           return zeroValueOf(preferredScale);
       else {
           /*
            * 如果这个除数的商有一个有限的小数展开,展开的位数不能超过(a.precision()+ceil(10*b.precision)/3)位.
            * 因此,使用这种精度创建MathContext对象,并使用不必要的舍入模式进行除法
            */
           MathContext mc = new MathContext((int)Math.min(this.precision() +               (long)Math.ceil(10.0*divisor.precision()/3.0), Integer.MAX_VALUE),RoundingMode.UNNECESSARY);
           
           BigDecimal quotient;
           try {
               // 返回一个 BigDecimal,其值为(this / divisor),其标度为 this.scale() 
               quotient = this.divide(divisor, mc);
           } catch (ArithmeticException e) {
               throw new ArithmeticException("Non-terminating decimal expansion; " + "no exact representable decimal result.");
           }
           // 获取quotient 的标度
           int quotientScale = quotient.scale();
   
               /*
                * divide(BigDecimal, mc)尝试通过删除后面的零来将商调整为所需的商;由于精确divide method没有明确的数字限制,我们也可以加上0。
                */
           if (preferredScale > quotientScale)
           // 返回BigDecimal,其标度为preferredScale,其非标度值通过此 BigDecimal的非标度值乘以或除以十的适当次幂来确定,以维护其总值
               return quotient.setScale(preferredScale, ROUND_UNNECESSARY);
   
           return quotient;
       }
   }
   
   /**
    * 返回其值为(this / divisor)的 BigDecimal(根据上下文设置进行舍入)
    * @param divisor	此 BigDecimal 要除以的值
    * @param mc	要使用的上下文
    * @return	this / divisor，必要时进行舍入
    */
   public BigDecimal divide(BigDecimal divisor, MathContext mc) {
       int mcp = mc.precision;
       if (mcp == 0)
       // 返回一个 BigDecimal,其值为(this/divisor),其首选标度为 (this.scale()-divisor.scale())
           return divide(divisor);
   
       BigDecimal dividend = this;
       long preferredScale = (long)dividend.scale - divisor.scale;
       /*
        * 现在计算答案.我们使用现有的divide-and-round method,但是当这轮进行缩放时,我们必须对这里的值进行标准化以达到预期的结果
        * 对于x/y,我们首先处理y=0和x=0,然后对x和y进行标准化,得到具有以下约束条件的x'和y':
        * 	(a) 0.1 <= x' < 1
        *  (b)  x' <= y' < 10*x'
        * 将x'/y'除以所需的scale设置为mc.precision,则会得到范围0.1到1的四舍五入结果,
        * 精确到正确的数字数(如果结果为1.000，则除外……)当x=y,或者四舍五入超过1.case会适当地减少到1
        */
       if (divisor.signum() == 0) {      // x/0
           if (dividend.signum() == 0)    // 0/0
               throw new ArithmeticException("Division undefined");  // NaN
           throw new ArithmeticException("Division by zero");
       }
       if (dividend.signum() == 0) // 0/y
           return zeroValueOf(saturateLong(preferredScale));
       int xscale = dividend.precision();
       int yscale = divisor.precision();
       if(dividend.intCompact!=INFLATED) {
           if(divisor.intCompact!=INFLATED) {
               return divide(dividend.intCompact, xscale, divisor.intCompact, yscale, preferredScale, mc);
           } else {
               return divide(dividend.intCompact, xscale, divisor.intVal, yscale, preferredScale, mc);
           }
       } else {
           if(divisor.intCompact!=INFLATED) {
               return divide(dividend.intVal, xscale, divisor.intCompact, yscale, preferredScale, mc);
           } else {
               return divide(dividend.intVal, xscale, divisor.intVal, yscale, preferredScale, mc);
           }
       }
   }
   
   /**
    * 返回 BigDecimal,其值为向下舍入所得商值(this / divisor) 的整数部分.该结果的首选标度为(this.scale() - divisor.scale()) 
    * @param divisor	此 BigDecimal 要除以的值
    * @return	this / divisor 的整数部分
    */
   public BigDecimal divideToIntegralValue(BigDecimal divisor) {
       // 计算优先 scale
   	// (long)this.scale - divisor.scale强转为int类型,判断是否等于int类型后的值,若果是,返回int类型后的值,否则小于0;返回integer最小值,否则最大值
       int preferredScale = saturateLong((long) this.scale - divisor.scale);
       if (this.compareMagnitude(divisor) < 0) {
           // 更快when this << divisor
           return zeroValueOf(preferredScale);
       }
   
       if (this.signum() == 0 && divisor.signum() != 0)
           // 获取一个BigDecimal,其标度为指定值
           return this.setScale(preferredScale, ROUND_UNNECESSARY);
   
       //执行一个除法,用足够的数字四舍五入到一个正确的整数值;然后去掉任何小数
       int maxDigits = (int)Math.min(this.precision() + (long)Math.ceil(10.0*divisor.precision()/3.0) + Math.abs((long)this.scale() - divisor.scale()) + 2,
                                     Integer.MAX_VALUE);
       // 返回其值为(this/divisor)的BigDecimal(根据上下文设置进行舍入)               
       BigDecimal quotient = this.divide(divisor, new MathContext(maxDigits,  RoundingMode.DOWN)); 
       if (quotient.scale > 0) {
           // 获取一个BigDecimal,其标度为指定值
           quotient = quotient.setScale(0, RoundingMode.DOWN);
           // 从当前BigDecimal对象中删除不重要的后置零,直到不能删除更多的零为止
           quotient = stripZerosToMatchScale(quotient.intVal, quotient.intCompact, quotient.scale, preferredScale);
       }
   
       if (quotient.scale < preferredScale) {
           // 如果需要,用零填充
           quotient = quotient.setScale(preferredScale, ROUND_UNNECESSARY);
       }
   
       return quotient;
   }
   
   /**
    * 返回 BigDecimal,其值为(this / divisor)的整数部分.因为准确商值的整数部分与舍入模式无关,所以舍入模式不影响此方法返回的值
    * 该结果的首选标度是 (this.scale() - divisor.scale())。
    * 如果准确商值的整数部分需要的位数多于mc.precision,则抛出 ArithmeticException
    * @param divisor	此 BigDecimal 要相除的值
    * @param mc	要使用的上下文
    * @return	this / divisor 的整数部分
    */
   public BigDecimal divideToIntegralValue(BigDecimal divisor, MathContext mc) {
       if (mc.precision == 0 || // 确切的结果
           (this.compareMagnitude(divisor) < 0)) // 零结果
           return divideToIntegralValue(divisor);
   
       // 计算优先scale
       int preferredScale = saturateLong((long)this.scale - divisor.scale);
   
       /*
        * 对mc.precision数字执行普通除法.如果余数的绝对值小于除数,则商的整数部分适合mc.precision数字
        * 接下来,从商中删除任何小数,并将scale调整为首选值
        */
       BigDecimal result = this.divide(divisor, new MathContext(mc.precision, RoundingMode.DOWN));
   
       if (result.scale() < 0) {
           /*
            * 结果是一个整数.看商是否表示精确商的整数部分;如果是,计算出来的余数将小于除数
            */
           BigDecimal product = result.multiply(divisor);
           // 如果商是整数值,|dividend-product| < |divisor|.
           if (this.subtract(product).compareMagnitude(divisor) >= 0) {
           // 如果 mc.precision > 0,并且该结果需要的精度大于 mc.precision
               throw new ArithmeticException("Division impossible");
           }
       } else if (result.scale() > 0) {
           /*
            * 商的整数部分将适合于precision数字;重新计算商的scale 0,以避免双舍入,然后尝试调整,如果需要
            */
           result = result.setScale(0, RoundingMode.DOWN);
       }
       // else result.scale() == 0;
   
       int precisionDiff;
       if ((preferredScale > result.scale()) &&
           (precisionDiff = mc.precision - result.precision()) > 0) {
           return result.setScale(result.scale() +
                                  Math.min(precisionDiff, preferredScale - result.scale) );
       } else {
           // 从当前BigDecimal对象中删除不重要的后置零,直到不能删除更多的零为止
           return stripZerosToMatchScale(result.intVal,result.intCompact,result.scale,preferredScale);
       }
   }
   ```

   

## 三、效果分析

#### 精度实验

此实验主要研究在**推荐用法**下的浮点数精度问题（在经验教训中有*<u>非推荐用法</u>*的示例，可能会在初始阶段就造成精度损失）

**实验用例和结果如下：**

![image-20241110184457193](D:\Desktop\汇编与接口\project 1\assets\image-20241110184457193.png)

![image-20241110191019105](D:\Desktop\汇编与接口\project 1\assets\image-20241110191019105.png)

由此可见，相较于使用基本数据类型double，用`BigDecimal`类可以很大程度上保留精度和原始值。而对于使用`BigDecimal`类而言，最好用`BigDecimal(String val)`构造方法，它可以保留最原始的精度。其次推荐使用`BigDecimal.valueOf(double val)` 静态方法来创建对象，但这种方式会在某些特殊场景下丢失小数点位数从而造成一定的精度缺失（其本质原因还是在于调用`Double.toString()`方法时会舍弃尾随0）。

最后，不推荐使用`BigDecimal(Double val)`构造方法，因为会造成初始阶段的精度丢失（原因部分详见 **五、经验教训**）



#### 类型转换实验

此实验主要探究`BigDecimal`类在类型转换之后会不会有精度丢失等问题。

**实验结果和用例如下：**

![image-20241110194850103](D:\Desktop\汇编与接口\project 1\assets\image-20241110194850103.png)

![image-20241110195031861](D:\Desktop\汇编与接口\project 1\assets\image-20241110195031861.png)

可以看到，`BigDecimal`类在类型转换时，和基本类型的类型转换类似，仍会产生精度丢失的情形，例如**123.456789**转为float时，最好的输出结果为**123.45679**，小数点后面只保留了5位（超出了float的精度限制）



#### 算术运算实验

1. **加减法运算**

   实验用例和结果：

   ![image-20241110190331170](D:\Desktop\汇编与接口\project 1\assets\image-20241110190331170.png)

   ![image-20241110190052691](D:\Desktop\汇编与接口\project 1\assets\image-20241110190052691.png)

   由于分析源码可知，加减法运算的核心逻辑较为简单，所以这里只是简单地探索一下其对于精度控制、舍入模式和全0情形的运算结果。可以清楚地看到，使用`BigDecimal`可以保留精度，且保留的精度是两个运算数精度的较大值，对于全0的情形，保留的精度不受`MathContext`设置的影响。

   

2. **乘法运算**

   实验示例和结果：

   ![image-20241110191815807](D:\Desktop\汇编与接口\project 1\assets\image-20241110191815807.png)

   ![image-20241110191825770](D:\Desktop\汇编与接口\project 1\assets\image-20241110191825770.png)

   可以看到，乘法运算结果的精度是两个运算数的精度之和，且不会去除尾随0，对于全0的情形，保留的精度不受`MathContext`设置的影响。

   

3. **除法运算**

   实验示例和结果：

   ![image-20241110193713828](D:\Desktop\汇编与接口\project 1\assets\image-20241110193713828.png)

   ![image-20241110193743425](D:\Desktop\汇编与接口\project 1\assets\image-20241110193743425.png)

   除法运算的复杂度比加减法和乘法都要高一点，经过实验可以确定，除法运算的结果会去除尾随0，但可以通过设置的方式设置结果的小数位数。

   

4. **累计运算**

   在此实验中，连续执行加法或乘法运算，观察 `BigDecimal` 是否能保持高精度，模拟常见的精度累积误差情况。

   注意：由于`BigDecimal` 是不可变类，所以在我的累乘运算中，每一步都会创建出新的`BigDecimal` 对象，所以这实际上是个指数型增长的累乘运算，其指数会增长的特别快，从而能够方便我们探究边界值的情况。

   **实验结果和示例如下：**

   需要注意的是对于**10000**的累乘实验出结果可能需要一定的时间（本机操作花了40分钟）

   ![image-20241110204427789](D:\Desktop\汇编与接口\project 1\assets\image-20241110204427789.png)

   ![image-20241110201237528](D:\Desktop\汇编与接口\project 1\assets\image-20241110201237528.png)

   ![image-20241110212406023](D:\Desktop\汇编与接口\project 1\assets\image-20241110212406023.png)

   结合实验结果分析可知，乘法运算会检查小数的位数，回顾**源码分析**部分，可知`BigDecimal`类有两个重要的成员变量`scale` 和`precision` ，分别用来表示小数位数和精度，但他们都是int型，所以当精度和小数位数超过int能够表示的最大值时，会抛出异常，这和我们先前的猜测一致。下面是`BigDecimal multiply()`的源码分析，其中在乘法运算前会先调用`checkScale()`来判断小数位数是否超出限制，如果超出限制则会抛出`ArithmeticException` **"Underflow"或"Overflow"**的异常

   ```java
   /**
        * Returns a {@code BigDecimal} whose value is <tt>(this &times;
        * multiplicand)</tt>, and whose scale is {@code (this.scale() +
        * multiplicand.scale())}.
        *
        * @param  multiplicand value to be multiplied by this {@code BigDecimal}.
        * @return {@code this * multiplicand}
        */
   public BigDecimal multiply(BigDecimal multiplicand) {
       int productScale = checkScale((long) scale + multiplicand.scale);
       if (this.intCompact != INFLATED) {
           if ((multiplicand.intCompact != INFLATED)) {
               return multiply(this.intCompact, multiplicand.intCompact, productScale);
           } else {
               return multiply(this.intCompact, multiplicand.intVal, productScale);
           }
       } else {
           if ((multiplicand.intCompact != INFLATED)) {
               return multiply(multiplicand.intCompact, this.intVal, productScale);
           } else {
               return multiply(this.intVal, multiplicand.intVal, productScale);
           }
       }
   }
   
   
   /**
        * Check a scale for Underflow or Overflow.  If this BigDecimal is
        * nonzero, throw an exception if the scale is outof range. If this
        * is zero, saturate the scale to the extreme value of the right
        * sign if the scale is out of range.
        *
        * @param val The new scale.
        * @throws ArithmeticException (overflow or underflow) if the new
        *         scale is out of range.
        * @return validated scale as an int.
        */
   private int checkScale(long val) {
       int asInt = (int)val;
       //检查刻度是否有 Underdrop （下溢） 或 Overflow （溢出）。如果此 BigDecimal 为非零，则在小数位数超出范围时引发	异常。如果该值为零，则如果刻度超出范围，则将刻度饱和到右符号的极值。
       if (asInt != val) {
           asInt = val>Integer.MAX_VALUE ? Integer.MAX_VALUE : Integer.MIN_VALUE;
           BigInteger b;
           if (intCompact != 0 &&
               ((b = intVal) == null || b.signum() != 0))
               throw new ArithmeticException(asInt>0 ? "Underflow":"Overflow");
       }
       return asInt;
   }
   
   ```

   > 这里实验的时候发现小数（0.0000001）的累乘比大数（10000）的累乘速度快很多，但由于时间精力有限，这里暂时还未探索出原因，个人推测可能是由于小数的乘法会默认使用科学计数法，而大数则没有使用科学计数法，从而导致大数在累乘时，会按照实际的数进行运算，（例如像10000这样的数，也不会采用指数相加的方法来简化运算），从而导致运算时间过长。



## 四、实验体会

通过该实验。我深入学习了`BigDecimal` 类的源码，了解了该类作为十进制浮点数存储的原理，以及它相关方法的内部处理逻辑，在查阅网上资料和自主探索的过程中也发现了很多注意事项和踩坑的点，这对于我以后运用`BigDecimal` 类提供了很大的帮助，也规避了我以后运用该类可能出现的问题。总而言之，我认为这次实验很有意义，我受益良多，不过由于时间精力有限，我在此次实验探究的过程中没有做到尽善尽美，对于累乘时间花费差异的问题没有深究，这是值得改进的地方。希望在不久的将来，我能够弄清楚其中的原因，补上此次实验的缺漏。



## 五、经验教训

1. 在使用 `BigDecimal` 时，为了防止精度丢失，推荐使用它的`BigDecimal(String val)`构造方法或者 `BigDecimal.valueOf(double val)` 静态方法来创建对象，而不推荐使用`BigDecimal(Double val)`

   **原因分析：**

   ```java
   public BigDecimal(double val) {
       this(val,MathContext.UNLIMITED);
   }
   
   public BigDecimal(double val, MathContext mc) {
       if (Double.isInfinite(val) || Double.isNaN(val))
           throw new NumberFormatException("Infinite or NaN");
       // Translate the double into sign, exponent and significand, according
       // to the formulae in JLS, Section 20.10.22.
       long valBits = Double.doubleToLongBits(val);
       int sign = ((valBits >> 63) == 0 ? 1 : -1);
       int exponent = (int) ((valBits >> 52) & 0x7ffL);
       long significand = (exponent == 0
                           ? (valBits & ((1L << 52) - 1)) << 1
                           : (valBits & ((1L << 52) - 1)) | (1L << 52));
       exponent -= 1075;
       // At this point, val == sign * significand * 2**exponent.
   
       /*
            * Special case zero to supress nonterminating normalization and bogus
            * scale calculation.
            */
       if (significand == 0) {
           this.intVal = BigInteger.ZERO;
           this.scale = 0;
           this.intCompact = 0;
           this.precision = 1;
           return;
       }
       // Normalize
       while ((significand & 1) == 0) { // i.e., significand is even
           significand >>= 1;
           exponent++;
       }
       int scale = 0;
       // Calculate intVal and scale
       BigInteger intVal;
       long compactVal = sign * significand;
       if (exponent == 0) {
           intVal = (compactVal == INFLATED) ? INFLATED_BIGINT : null;
       } else {
           if (exponent < 0) {
               intVal = BigInteger.valueOf(5).pow(-exponent).multiply(compactVal);
               scale = -exponent;
           } else { //  (exponent > 0)
               intVal = BigInteger.valueOf(2).pow(exponent).multiply(compactVal);
           }
           compactVal = compactValFor(intVal);
       }
       int prec = 0;
       int mcp = mc.precision;
       if (mcp > 0) { // do rounding
           int mode = mc.roundingMode.oldMode;
           int drop;
           if (compactVal == INFLATED) {
               prec = bigDigitLength(intVal);
               drop = prec - mcp;
               while (drop > 0) {
                   scale = checkScaleNonZero((long) scale - drop);
                   intVal = divideAndRoundByTenPow(intVal, drop, mode);
                   compactVal = compactValFor(intVal);
                   if (compactVal != INFLATED) {
                       break;
                   }
                   prec = bigDigitLength(intVal);
                   drop = prec - mcp;
               }
           }
           if (compactVal != INFLATED) {
               prec = longDigitLength(compactVal);
               drop = prec - mcp;
               while (drop > 0) {
                   scale = checkScaleNonZero((long) scale - drop);
                   compactVal = divideAndRound(compactVal, LONG_TEN_POWERS_TABLE[drop], mc.roundingMode.oldMode);
                   prec = longDigitLength(compactVal);
                   drop = prec - mcp;
               }
               intVal = null;
           }
       }
       this.intVal = intVal;
       this.intCompact = compactVal;
       this.scale = scale;
       this.precision = prec;
   }
   ```

   分析其源码可知，对于传入的`double`值，会先按照IEEE 754的双精度浮点格式对数据进行拆分：

   ```java
   long valBits = Double.doubleToLongBits(val);
   int sign = ((valBits >> 63) == 0 ? 1 : -1);
   int exponent = (int) ((valBits >> 52) & 0x7ffL);
   long significand = (exponent == 0
                       ? (valBits & ((1L << 52) - 1)) << 1
                       : (valBits & ((1L << 52) - 1)) | (1L << 52));
   exponent -= 1075;
   ```

   从而导致存入的数值在一开始初始化时就产生了精度损失，**实验验证如下：**

   ![image-20241110154357520](D:\Desktop\汇编与接口\project 1\assets\image-20241110154357520-1731224650872-1.png)

   ![image-20241110154413055](D:\Desktop\汇编与接口\project 1\assets\image-20241110154413055.png)

   而用`BigDecimal.valueOf(double val)`，其内部会调用`Double.toString()`，从而保证了精度。

   

2. `BigDecimal` 的等值比较应使用 `compareTo()` 方法，而不是 `equals()` 方法

   **原因分析：**

   这是因为 `equals()` 方法不仅仅会比较值的大小（value）还会比较精度（scale），而 `compareTo()` 方法比较的时候会忽略精度。

   ```java
   public boolean equals(Object x) {
       if (!(x instanceof BigDecimal))
           return false;
       BigDecimal xDec = (BigDecimal) x;
       if (x == this)
           return true;
       if (scale != xDec.scale)
           return false;
       long s = this.intCompact;
       long xs = xDec.intCompact;
       if (s != INFLATED) {
           if (xs == INFLATED)
               xs = compactValFor(xDec.intVal);
           return xs == s;
       } else if (xs != INFLATED)
           return xs == compactValFor(this.intVal);
   
       return this.inflated().equals(xDec.inflated());
   }
   
   public int compareTo(BigDecimal val) {
       // Quick path for equal scale and non-inflated case.
       if (scale == val.scale) {
           long xs = intCompact;
           long ys = val.intCompact;
           if (xs != INFLATED && ys != INFLATED)
               return xs != ys ? ((xs > ys) ? 1 : -1) : 0;
       }
       int xsign = this.signum();
       int ysign = val.signum();
       if (xsign != ysign)
           return (xsign > ysign) ? 1 : -1;
       if (xsign == 0)
           return 0;
       int cmp = compareMagnitude(val);
       return (xsign > 0) ? cmp : -cmp;
   }
   ```

   **实验验证如下：**

   ![image-20241110162310314](D:\Desktop\汇编与接口\project 1\assets\image-20241110162310314.png)

   ![image-20241110162321238](D:\Desktop\汇编与接口\project 1\assets\image-20241110162321238.png)

   

3. 使用 `BigDecimal`进行除法运算时，需要指明数据结果的精度

   **原因分析：**`BigDecimal` 在进行除法运算时，**如果不指定截取的精度和舍入模式，当出现数据无法整除时，会出现 `ArithmeticException` 异常**。

   ```java
   public BigDecimal divide(BigDecimal divisor) {
       /*
            * Handle zero cases first.
            */
       if (divisor.signum() == 0) {   // x/0
           if (this.signum() == 0)    // 0/0
               throw new ArithmeticException("Division undefined");  // NaN
           throw new ArithmeticException("Division by zero");
       }
   
       // Calculate preferred scale
       int preferredScale = saturateLong((long) this.scale - divisor.scale);
   
       if (this.signum() == 0) // 0/y
           return zeroValueOf(preferredScale);
       else {
           /*
                * If the quotient this/divisor has a terminating decimal
                * expansion, the expansion can have no more than
                * (a.precision() + ceil(10*b.precision)/3) digits.
                * Therefore, create a MathContext object with this
                * precision and do a divide with the UNNECESSARY rounding
                * mode.
                */
           MathContext mc = new MathContext( (int)Math.min(this.precision() +
                                                           (long)Math.ceil(10.0*divisor.precision()/3.0),
                                                           Integer.MAX_VALUE),
                                            RoundingMode.UNNECESSARY);
           BigDecimal quotient;
           try {
               quotient = this.divide(divisor, mc);
           } catch (ArithmeticException e) {
               throw new ArithmeticException("Non-terminating decimal expansion; " +
                                             "no exact representable decimal result.");
           }
   
           int quotientScale = quotient.scale();
   
           // divide(BigDecimal, mc) tries to adjust the quotient to
           // the desired one by removing trailing zeros; since the
           // exact divide method does not have an explicit digit
           // limit, we can add zeros too.
           if (preferredScale > quotientScale)
               return quotient.setScale(preferredScale, ROUND_UNNECESSARY);
   
           return quotient;
       }
   }
   ```

   **实验验证如下：**

   ![image-20241110162613259](D:\Desktop\汇编与接口\project 1\assets\image-20241110162613259.png)

   ![image-20241110162641155](D:\Desktop\汇编与接口\project 1\assets\image-20241110162641155.png)

   正好对应了源码中抛出的异常信息：

   ```java
   try {
       quotient = this.divide(divisor, mc);
   } catch (ArithmeticException e) {
       throw new ArithmeticException("Non-terminating decimal expansion; " +
                                     "no exact representable decimal result.");
   }
   // divide(BigDecimal divisor, MathContext mc)内部仍有多层嵌套，这里不再展开，核心思想就是进行除法时当不整除，出现无限循环小数时就会抛出该异常
   ```



## 六、参考文献

[BigDecimal 源码分析 JDK8 | GEN](https://gendali.cn/collection/BigDecimal.html)

[BigDecimal源码解析 | Eric Liang](https://ericql.github.io/2019/11/12/01-Java基础篇/02-JDK源码篇/BigDecimal源码解析/)

[BigDecimal 详解 | JavaGuide](https://javaguide.cn/java/basis/bigdecimal.html)

[掌握BigDecimal：详解其原理及最佳实践本文主要对BigDecimal内部对于浮点数的存储规则进行分析，以加深读者 - 掘金](https://juejin.cn/post/7372863316912521257)

[开发易忽视的问题：BigDecimal底层原理分析BigDecimal 是 Java 中用于高精度计算的类，特别适合处理 - 掘金](https://juejin.cn/post/7419209528263917620)

[详解BigDecimal-阿里云开发者社区](https://developer.aliyun.com/article/1259576)

[Java之BigDecimal详解_bigdecimal java未整除-CSDN博客](https://blog.csdn.net/weixin_74318097/article/details/135297815)

