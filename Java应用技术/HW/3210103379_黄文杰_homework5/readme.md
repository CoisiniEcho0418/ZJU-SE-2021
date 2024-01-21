## 修改配置

------

由于该课程作业用到了数据库，所以在运行项目前需要对数据库连接部分做相关配置：

- 确保正确导入jdbc的mysql驱动依赖：在项目的pom.xml中，更新依赖（该项目是用maven进行管理的）

![image-20240118001320759](C:\Users\11\AppData\Roaming\Typora\typora-user-images\image-20240118001320759.png)

- 修改JDBC数据库连接配置：请修改Server类中有关数据库连接的三个配置信息（修改为自己本地数据库配置，建表语句放在resources目录下）：

```java
//    远程服务器数据库URL
//    private static String JDBC_URL = "jdbc:mysql://47.115.208.169:3306/MiniQQ?useUnicode=true&useSSL=false&serverTimezone=GMT&characterEncoding=UTF-8";
    // 以下三个部分请修改为本地的数据库配置，SQL建表语句放在resources目录下（MiniQQ.sql）
    private static String JDBC_URL ="";
    private static String USER = "";
    private static String PASSWORD = "";
```

> 其中有关JDBC的url可以选择修改成自己本地数据库的url，也可以尝试用我部署在远程服务器上的mysql url（但是这样一来的话，有关数据库的操作（登录、注册等）会很慢，很慢，很慢！）

![image-20240118001755497](C:\Users\11\AppData\Roaming\Typora\typora-user-images\image-20240118001755497.png)



## 运行

------

客户端的入口类为Login，服务端的入口类为Server，为了确保可以同时运行多个客户端，需要修改IDE运行时的配置，这部分可以参考我的项目报告