package server;

import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

public class Server {
    private ServerSocket serverSocket;
    private final int port = 3379;
    private DatabaseManager databaseManager;
//    远程服务器数据库URL
//    private static String JDBC_URL = "jdbc:mysql://47.115.208.169:3306/MiniQQ?useUnicode=true&useSSL=false&serverTimezone=GMT&characterEncoding=UTF-8";
    // 以下三个部分请修改为本地的数据库配置，SQL建表语句放在resources目录下（MiniQQ.sql）
    private static String JDBC_URL ="jdbc:mysql://localhost:3306/miniqq?useSSL=false&serverTimezone=GMT&characterEncoding=UTF-8";
    private static String USER = "root";
    private static String PASSWORD = "hwj20030418";
    // 存储所有的客户端线程
    public static List<ClientServeThread> clientThreads = new ArrayList<>();

    public Server(DatabaseManager databaseManager) {
        this.databaseManager = databaseManager;
        run();
    }

    public void run(){
        try {
            // 创建ServerSocket，监听指定端口
            serverSocket = new ServerSocket(port);
            System.out.println("Server is running on port " + port);

            // 循环接受客户端连接
            while (true) {
                Socket clientSocket = serverSocket.accept();
                System.out.println("New client connected: " + clientSocket.getInetAddress().getHostAddress());

                // 创建新线程处理客户端请求
                ClientServeThread clientThread = new ClientServeThread(clientSocket, databaseManager);
                clientThreads.add(clientThread);  // 将新的客户端线程添加到集合中
                clientThread.start();
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                if (serverSocket != null && !serverSocket.isClosed()) {
                    serverSocket.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    public static void main(String[] args)  {
        // 创建 DatabaseManager 对象并传递给 Server 构造函数
        DatabaseManager databaseManager = new DatabaseManager(JDBC_URL,USER ,PASSWORD );
        try{
            Connection con = databaseManager.getConnection();
        } catch (Exception e){
            e.printStackTrace();
        }

        new Server(databaseManager);
    }
}
