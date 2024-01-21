package server;

import java.io.*;
import java.net.Socket;
import java.util.ArrayList;
import java.util.List;

public class ClientServeThread extends Thread {
    // 在服务端维护在线用户列表
    private static List<String> onlineUsers = new ArrayList<>();
    private final Socket clientSocket;
    private BufferedReader reader;
    private PrintWriter writer;
    private final DatabaseManager databaseManager;
    private String username;

    public ClientServeThread(Socket clientSocket, DatabaseManager databaseManager) {
        this.clientSocket = clientSocket;
        this.databaseManager = databaseManager;
        try {
            reader = new BufferedReader(new InputStreamReader(clientSocket.getInputStream()));
            writer = new PrintWriter(clientSocket.getOutputStream(), true);
            // 向客户端发送欢迎消息
            writer.println("Welcome to MINIQQ Server!");
            writer.flush();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void run() {
        try {
            // 处理客户端请求逻辑
            String clientMessage;
            while ((clientMessage = reader.readLine()) != null) {
                System.out.println("Received message from client: " + clientMessage);
                handleClientRequest(clientMessage);
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            // 在线用户列表中移除离线用户
            synchronized (onlineUsers) {
                onlineUsers.remove(this.username);
                broadcastOnlineUsers(); // 更新在线用户列表
                writer.println("USER_LEAVE ["+this.username+"]离开了房间");
            }

            try {
                if (reader != null) {
                    reader.close();
                }
                if (writer != null) {
                    writer.close();
                }
                if (clientSocket != null && !clientSocket.isClosed()) {
                    clientSocket.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    private void handleClientRequest(String clientMessage) {
        String[] parts = clientMessage.split(" ");
        String command = parts[0];

        if ("REGISTER".equals(command)) {
            handleRegister(parts);
        } else if ("LOGIN".equals(command)) {
            handleLogin(parts);
        } else if ("GROUP_MESSAGE".equals(command)) {
            handleGroupMessage(clientMessage);
        } else if ("GROUP_LOGIN".equals(command)) {
            // 为实例的username属性赋值
            String user = parts[1].split(":")[1];
            this.username=user;
            // 在线用户列表中添加新登录用户
            synchronized (onlineUsers) {
                onlineUsers.add(username);
                broadcastOnlineUsers(); // 更新在线用户列表
            }
            handleGroupMessage(clientMessage);
        } else {
            // 处理其他命令（TODO:）
            // ...
        }
    }

    private void handleLogin(String[] parts) {
        String[] userDetails = parts[1].split(":");
        String[] pwdDetails = parts[2].split(":");
        String username = userDetails[1];
        String password = pwdDetails[1];

        if (!checkIfUsernameExists(username)) {
            writer.println("ServerResult: USERNAME_NOT_FOUND");
        } else {
            if (databaseManager.login(username, password)) {
                // 登录成功
                writer.println("ServerResult: SUCCESS "+username);
                writer.flush();
            } else {
                // 登录失败
                writer.println("ServerResult: PASSWORD_INCORRECT");
                writer.flush();
            }
        }
    }

    private void handleRegister(String[] parts) {
        String[] userDetails = parts[1].split(":");
        String[] pwdDetails = parts[2].split(":");
        String username = userDetails[1];
        String password = pwdDetails[1];

        if (checkIfUsernameExists(username)) {
            writer.println("ServerResult: USERNAME_EXISTS");
        } else {
            if (databaseManager.register(username, password)) {
                // 注册成功
                writer.println("ServerResult: SUCCESS");
                writer.flush();
            } else {
                // 注册失败
                writer.println("ServerResult: REGISTER_FAILED");
                writer.flush();
            }
        }
    }

    // 检查用户名是否存在
    private boolean checkIfUsernameExists(String username) {
        return databaseManager.checkIfUsernameExists(username);
    }

    // 向单个客户端发送消息
    public void sendMessage(String message) {
        writer.println(message);
    }

    // 处理群聊消息（同时也包括设置username）
    private void handleGroupMessage(String message) {
        // 群发消息给所有在线客户端
        synchronized (onlineUsers) {
            for (ClientServeThread clientThread : Server.clientThreads) {
                if (clientThread != this) {
                    clientThread.sendMessage(message);
                }
            }
        }
    }

    // 广播在线用户列表给所有客户端
    private void broadcastOnlineUsers() {
        StringBuilder userListMessage = new StringBuilder("MEMBER_LIST ");
        synchronized (onlineUsers) {
            for (String user : onlineUsers) {
                userListMessage.append(user).append(" ");
            }
        }

        // 发送在线用户列表给所有在线客户端
        for (ClientServeThread clientThread : Server.clientThreads) {
            clientThread.sendMessage(userListMessage.toString());
        }
    }

}
