package client;

import javax.swing.*;
import java.awt.*;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.BufferedReader;
import java.io.PrintWriter;
import java.net.Socket;
import java.text.SimpleDateFormat;
import java.util.Date;

public class GroupChat extends JFrame {
    private static final String SERVER_HOST = "127.0.0.1";
    private static final int SERVER_PORT = 3379;
    private Socket socket;
    private JTextArea chatArea;
    private JTextArea memberListArea;
    private JTextField messageField;
    private final String username;
    private ChatroomListenerThread listenerThread;

    public GroupChat(String username) {
        this.username=username;
        connectToServer(); // 初始化 socket 连接
        init();
    }

    private void connectToServer() {
        try {
            socket = new Socket(SERVER_HOST, SERVER_PORT);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void startListenerThread() {
        try {
            BufferedReader reader = new BufferedReader(new InputStreamReader(socket.getInputStream()));
            listenerThread = new ChatroomListenerThread(reader, this);
            listenerThread.start();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public void init(){
        setTitle("MiniQQ聊天室");
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setSize(800, 600);
        setLocationRelativeTo(null);

        // 设置楷体字体，字体风格为普通，字体大小为16
        Font font = new Font("楷体", Font.PLAIN, 16);

        // 创建面板
        JPanel mainPanel = new JPanel(new BorderLayout(10, 10)); // 添加边距

        // 聊天信息显示区域
        chatArea = new JTextArea("*****************登录成功，欢迎来到MiniQQ聊天室！*******************\n");
        chatArea.setEditable(false);
        chatArea.setFont(font); // 设置字体
        JScrollPane chatScrollPane = new JScrollPane(chatArea);
        mainPanel.add(chatScrollPane, BorderLayout.CENTER);

        // 成员列表显示区域
        memberListArea = new JTextArea("在线成员列表:\n");
        memberListArea.setEditable(false);
        memberListArea.setFont(font); // 设置字体
        JScrollPane memberScrollPane = new JScrollPane(memberListArea);
        memberScrollPane.setPreferredSize(new Dimension(200, getHeight())); // 调整宽度
        mainPanel.add(memberScrollPane, BorderLayout.EAST);

        // 消息发送区域
        JPanel messagePanel = new JPanel(new BorderLayout(10, 10)); // 添加边距
        messageField = new JTextField();
        messageField.setFont(font); // 设置字体
        JButton sendButton = new JButton("发送");
        sendButton.setFont(font); // 设置字体
        messagePanel.add(messageField, BorderLayout.CENTER);
        messagePanel.add(sendButton, BorderLayout.EAST);
        mainPanel.add(messagePanel, BorderLayout.SOUTH);

        // 调整消息输入框和发送按钮的高度
        Dimension inputFieldSize = messageField.getPreferredSize();
        inputFieldSize.height = 40;
        messageField.setPreferredSize(inputFieldSize);

        Dimension buttonSize = sendButton.getPreferredSize();
        buttonSize.height = 40;
        sendButton.setPreferredSize(buttonSize);

        // 添加发送按钮的点击事件监听器
        sendButton.addActionListener(e -> sendMessage());

        // 添加整体的边距
        mainPanel.setBorder(BorderFactory.createEmptyBorder(10, 10, 10, 10));

        // 添加窗口关闭事件监听器
        addWindowListener(new WindowAdapter() {
            @Override
            public void windowClosing(WindowEvent e) {
                // 关闭窗口时关闭线程
                closeThread();
            }
        });

        setContentPane(mainPanel);
        setVisible(true);
        startListenerThread();
        sendLoginMessage();
    }

    private void sendMessage() {
        // 获取消息文本
        String message = messageField.getText();
        if (message.isEmpty()){
            JOptionPane.showMessageDialog(this, "输入内容不能为空");
        }else{
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String currentTime = dateFormat.format(new Date());

            // 构建消息格式：时间 + 用户名 + 内容
            String formattedMessage = "GROUP_MESSAGE currentTime:" + currentTime + " username:" + username + " message:" + message;
            // 发送消息到服务器
            try {
                PrintWriter writer = new PrintWriter(socket.getOutputStream(), true);
                writer.println(formattedMessage);
            } catch (IOException ex) {
                ex.printStackTrace();
            }
            appendChatMessage("");
            appendChatMessage(currentTime);
            appendChatMessage("(你): "+message);
            // 清空消息输入框
            messageField.setText("");
        }
    }

    private void sendLoginMessage(){
//        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//        String currentTime = dateFormat.format(new Date());
        // 构建消息格式：时间 + 用户名 + 内容
        // String formattedMessage = "GROUP_LOGIN currentTime:" + currentTime + " username:" + username;

        String formattedMessage = "GROUP_LOGIN " + "username:" + this.username;
        // 发送消息到服务器
        try {
            PrintWriter writer = new PrintWriter(socket.getOutputStream(), true);
            writer.println(formattedMessage);
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        appendChatMessage("[你("+this.username+")]进入了房间");
    }

    // 给聊天框增加信息
    public void appendChatMessage(String message) {
        chatArea.append(message + "\n");
    }

    // 给用户列表增加信息
    public void updateMemberMessage(String[] message) {
        memberListArea.setText("在线成员列表:\n");
        for(String user:message){
            memberListArea.append(user+ "\n");
        }

    }

    // 关闭线程的方法
    private void closeThread() {
        try {
            // 关闭 Socket
            if (socket != null && !socket.isClosed()) {
                socket.close();
            }

            // 关闭监听线程
            if (listenerThread != null && listenerThread.isAlive()) {
                listenerThread.interrupt();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}

