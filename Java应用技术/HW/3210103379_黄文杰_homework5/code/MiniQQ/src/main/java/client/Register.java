package client;

import javax.swing.*;
import java.awt.*;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.util.Arrays;

public class Register extends JFrame {

    private JTextField usernameField;
    private JPasswordField passwordField;
    private JPasswordField confirmPasswordField;
    private RegisterListenerThread thread;

    public Register() {
        thread=new RegisterListenerThread(this);
        init();
    }

    public void init(){
        setTitle("注册界面");
        setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        setBounds(650, 350, 400, 300);

        JPanel contentPanel = new JPanel(new BorderLayout());
        contentPanel.setBackground(Color.white);

        JPanel centerPanel = new JPanel(new GridBagLayout());
        centerPanel.setBackground(Color.white);
        GridBagConstraints gbc = new GridBagConstraints();
        gbc.insets = new Insets(10, 5, 10, 5);
        gbc.anchor = GridBagConstraints.WEST;

        Font labelFont = new Font("楷体", Font.PLAIN, 16);

        JLabel usernameLabel = new JLabel("用户名:");
        usernameLabel.setFont(labelFont);
        usernameField = new JTextField(25);
        usernameField.setFont(labelFont);
        Dimension usernameFieldSize = usernameField.getPreferredSize();
        usernameFieldSize.height = 30;
        usernameField.setPreferredSize(usernameFieldSize);

        JLabel passwordLabel = new JLabel("密码:");
        passwordLabel.setFont(labelFont);
        passwordField = new JPasswordField(25);
        passwordField.setFont(labelFont);
        passwordField.setEchoChar('●');
        Dimension pwdFieldSize = passwordField.getPreferredSize();
        pwdFieldSize.height = 30;
        passwordField.setPreferredSize(pwdFieldSize);

        JLabel confirmPasswordLabel = new JLabel("确认密码:");
        confirmPasswordLabel.setFont(labelFont);
        confirmPasswordField = new JPasswordField(25);
        confirmPasswordField.setFont(labelFont);
        confirmPasswordField.setEchoChar('●');
        Dimension confirmPwdFieldSize = passwordField.getPreferredSize();
        confirmPwdFieldSize.height = 30;
        confirmPasswordField.setPreferredSize(confirmPwdFieldSize);

        gbc.fill = GridBagConstraints.HORIZONTAL;
        gbc.gridx = 0;
        gbc.gridy = 0;
        centerPanel.add(usernameLabel, gbc);
        gbc.gridx = 1;
        centerPanel.add(usernameField, gbc);

        gbc.gridx = 0;
        gbc.gridy = 1;
        centerPanel.add(passwordLabel, gbc);
        gbc.gridx = 1;
        centerPanel.add(passwordField, gbc);

        gbc.gridx = 0;
        gbc.gridy = 2;
        centerPanel.add(confirmPasswordLabel, gbc);
        gbc.gridx = 1;
        centerPanel.add(confirmPasswordField, gbc);

        JButton confirmButton = new JButton("确认");
        JButton cancelButton = new JButton("取消");
        confirmButton.setFont(labelFont);
        cancelButton.setFont(labelFont);

        JPanel buttonPanel = new JPanel(new FlowLayout(FlowLayout.CENTER, 30, 30));
        buttonPanel.add(confirmButton);
        buttonPanel.add(cancelButton);
        buttonPanel.setBackground(Color.white);

        // 确认按钮处理事件（注册）
        confirmButton.addActionListener(e -> {
            String username = usernameField.getText();
            char[] password = passwordField.getPassword();
            char[] confirmPassword = confirmPasswordField.getPassword();

            if (username.isEmpty() || password.length == 0 || confirmPassword.length == 0) {
                JOptionPane.showMessageDialog(this, "用户名、密码和确认密码不能为空！");
                return;
            }

            if (!Arrays.equals(password, confirmPassword)) {
                JOptionPane.showMessageDialog(this, "密码和确认密码不一致");
                return;
            }

            // 将char[]密码数组转换为字符串
            String passwordString = new String(password);

            thread.sendRequest("REGISTER username:" + username + " password:" + passwordString);

        });

        cancelButton.addActionListener(e -> {
            dispose();
        });

        // 添加窗口关闭事件监听器
        addWindowListener(new WindowAdapter() {
            @Override
            public void windowClosing(WindowEvent e) {
                // 关闭窗口时关闭线程
                thread.close();
            }
        });

        contentPanel.add(centerPanel, BorderLayout.CENTER);
        contentPanel.add(buttonPanel, BorderLayout.SOUTH);
        contentPanel.add(Box.createVerticalStrut(20), BorderLayout.NORTH);

        setContentPane(contentPanel);
        // 线程启动
        thread.start();
    }

    public void showInfo(String info){
        JOptionPane.showMessageDialog(this, info);
    }

    public void clearText(){
        usernameField.setText("");
        passwordField.setText("");
        confirmPasswordField.setText("");
        setVisible(false);
    }

}
