package client;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;


public class LoginListenerThread extends Thread {
    private static final String SERVER_HOST = "127.0.0.1";
    private static final int SERVER_PORT = 3379;
    private Login login;
    private Socket socket;
    private BufferedReader reader;
    private PrintWriter writer;

    public LoginListenerThread(Login login) {
        this.login = login;
        try {
            socket = new Socket(SERVER_HOST, SERVER_PORT);
            reader = new BufferedReader(new InputStreamReader(socket.getInputStream()));
            writer = new PrintWriter(socket.getOutputStream(), true);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void run() {
        try {
            String serverMessage;
            while (true) {
                // 读取一行数据
                serverMessage = reader.readLine();
                if (serverMessage == null) {
                    // 输入流已关闭，跳出循环
                    break;
                }
                System.out.println("Server response: " + serverMessage);
                handleLoginResult(serverMessage);
            }
        } catch (IOException e) {
            e.printStackTrace();
            // 关闭连接
            close();
        }
    }



    // 发送请求到服务端
    public void sendRequest(String request) {
        writer.println(request);
    }

    // 处理登录结果
    private void handleLoginResult(String message) {
        String[] parts = message.split(" ");
        String result = parts[1];
        if(!"ServerResult:".equals(parts[0])){
            return;
        }
        if("SUCCESS".equals(result)){
            String username = parts[2];
            // 登录成功
            login.showInfo("登录成功");
            login.openChatRoom(username);
            close();
        } else if ("USERNAME_NOT_FOUND".equals(result)) {
            // 用户名不存在
            login.showInfo("用户名不存在");
        } else if ("PASSWORD_INCORRECT".equals(result)) {
            // 密码错误
            login.showInfo("密码错误");
        }else {
            // 其他错误 TODO:处理其他错误逻辑
            login.showInfo("登录失败，请稍后重试");
        }

    }

    // 关闭连接
    public void close() {
        try {
            if (reader != null) {
                reader.close();
            }
            if (socket != null && !socket.isClosed()) {
                socket.close();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }


}

