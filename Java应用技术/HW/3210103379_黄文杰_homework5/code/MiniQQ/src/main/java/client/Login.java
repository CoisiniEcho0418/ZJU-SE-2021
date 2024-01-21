package client;

import javax.swing.*;
import java.awt.*;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.net.URL;

public class Login extends JFrame {
    private JPanel root;
    private JLabel userNameLabel,passWordLabel,imageLabel,textLabel;
    private JTextField userTextField;
    private JButton enterButton,registerButton;
    private JPasswordField passWordTextField;
    private LoginListenerThread thread;

    public Login() {
        thread=new LoginListenerThread(this);
        init();
    }

    public void init(){
        //设置窗口风格
        setTitle("MiniQQ"); // 设置title为"MiniQQ"
        setDefaultCloseOperation(EXIT_ON_CLOSE);
        setBounds(600, 250, 500, 435);
        setVisible(true);

        root = new JPanel();      //定义面板容器
        setContentPane(root);     //设置主容器
        setLayout(null);         //设置面板为绝对布局
        root.setBackground(Color.white);

        // 设置楷体字体，字体风格为普通，字体大小为16
        Font labelFont = new Font("楷体", Font.PLAIN, 16);
        Font tipFont = new Font("楷体",Font.BOLD,20);

        // 图片
        ImageIcon originalImageIcon = createImageIcon("/img/QQ.jpg"); // 加载图片
        assert originalImageIcon != null;
        Image originalImage = originalImageIcon.getImage();
        // 缩放图片
        Image scaledImage = originalImage.getScaledInstance(150, 150, Image.SCALE_SMOOTH);
        ImageIcon scaledImageIcon = new ImageIcon(scaledImage);
        imageLabel = new JLabel(scaledImageIcon);
        imageLabel.setSize(imageLabel.getPreferredSize());         // 设置组件的大小
        imageLabel.setBackground(Color.blue);
        int x = (getWidth() - imageLabel.getWidth()) / 2;           // 计算使组件水平居中的 x 坐标
        imageLabel.setLocation(x, 10);                         // 设置组件的位置
        root.add(imageLabel);

        // 文字
        textLabel = new JLabel("欢迎使用MiniQQ！");
        textLabel.setFont(tipFont);
        FontMetrics fontMetrics = getFontMetrics(tipFont);          // 使用FontMetrics获取字体宽度
        int textWidth = fontMetrics.stringWidth(textLabel.getText());
        textLabel.setSize(textWidth, tipFont.getSize());
        x = (getWidth() - textLabel.getWidth()) / 2;
        textLabel.setLocation(x, 190);
        root.add(textLabel);

        //用户名标签
        userNameLabel = new JLabel("用户名：");
        userNameLabel.setBounds(90, 230, 100, 50);
        userNameLabel.setFont(labelFont);
        root.add(userNameLabel);

        //用户名文本框
        userTextField = new JTextField();
        userTextField.setBounds(170, 242, 220, 30);
        userTextField.setFont(labelFont);
        root.add(userTextField);

        //密码标签
        passWordLabel = new JLabel("密 码：");       //定义标签对象
        passWordLabel.setBounds(90, 270, 100, 50);
        passWordLabel.setFont(labelFont);
        root.add(passWordLabel);

        //密码文本框
        passWordTextField = new JPasswordField();
        passWordTextField.setBounds(170, 282, 220, 30);
        passWordTextField.setFont(labelFont);
        passWordTextField.setEchoChar('●');       //设置回显字符
        root.add(passWordTextField);

        //登录按钮
        enterButton = new JButton("登 录");          //定义按钮对象
        enterButton.setBounds(130, 330, 80, 30);
        enterButton.setFont(labelFont);
        // 设置登录按钮的点击事件
        enterButton.addActionListener(e -> {
            String username = userTextField.getText();
            String password = new String(passWordTextField.getPassword());
            // 先判断输入的用户名和密码是否为空
            if(username.isEmpty() || password.isEmpty()){
                JOptionPane.showMessageDialog(this, "用户名和密码不能为空！");
                return;
            }

            thread.sendRequest("LOGIN username:" + username + " password:" + password);
        });
        root.add(enterButton);

        //注册按钮
        registerButton = new JButton("注 册");
        registerButton.setBounds(270, 330, 80, 30);
        registerButton.setFont(labelFont);
        registerButton.addActionListener(e -> {
            // 处理注册按钮点击事件
            new Register().setVisible(true); // 弹出注册窗口
        });
        root.add(registerButton);

        // 添加窗口关闭事件监听器
        addWindowListener(new WindowAdapter() {
            @Override
            public void windowClosing(WindowEvent e) {
                // 关闭窗口时关闭线程
                thread.close();
            }
        });

        // 启动线程
        thread.start();
    }

    // 获取图片的 ImageIcon
    private ImageIcon createImageIcon(String path) {
        URL imgUrl = getClass().getResource(path);
        if (imgUrl != null) {
            return new ImageIcon(imgUrl);
        } else {
            System.err.println("Couldn't find file: " + path);
            return null;
        }
    }

    public void showInfo(String info){
        JOptionPane.showMessageDialog(this, info);
    }

    public void openChatRoom(String username){
        GroupChat chatRoom = new GroupChat(username);
        setVisible(false);
    }

    // main方法
    public static void main(String[] args) {
        SwingUtilities.invokeLater(Login::new);
    }
}

