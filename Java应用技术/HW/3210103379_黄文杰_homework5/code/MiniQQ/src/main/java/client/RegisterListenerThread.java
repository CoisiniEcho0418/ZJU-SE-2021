package client;

import javax.swing.*;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;


public class RegisterListenerThread extends Thread {
    private static final String SERVER_HOST = "127.0.0.1";
    private static final int SERVER_PORT = 3379;
    private Register register;
    private Socket socket;
    private BufferedReader reader;
    private PrintWriter writer;

    public RegisterListenerThread(Register register) {
        this.register = register;
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
            while ((serverMessage = reader.readLine()) != null) {
                System.out.println("Server response: " + serverMessage);
                handleRegisterResult(serverMessage);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // 发送请求到服务端
    public void sendRequest(String request) {
        writer.println(request);
    }

    // 处理注册结果
    private void handleRegisterResult(String message) {
        String[] parts = message.split(" ");
        String result = parts[1];
        if(!"ServerResult:".equals(parts[0])){
            return;
        }
        if("SUCCESS".equals(result)){
            // 注册成功
            register.showInfo("注册成功");
            register.clearText();
        } else if ("USERNAME_EXISTS".equals(result)) {
            // 用户名已存在
            register.showInfo("注册失败，用户名已存在");
        } else if ("REGISTER_FAILED".equals(result)) {
            // 注册失败
            register.showInfo("注册失败，请检查表单信息");
        }else {
            // 其他错误 TODO:处理其他错误逻辑
            register.showInfo("注册失败，发生异常");
        }
    }

    // 关闭连接
    public void close() {
        try {
            if (reader != null) {
                reader.close();
            }
            if (writer != null) {
                writer.close();
            }
            if (socket != null && !socket.isClosed()) {
                socket.close();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}


