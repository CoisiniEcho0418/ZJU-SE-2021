import java.net.ServerSocket;
import java.net.Socket;
import java.io.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class WebServer {
    private static final int PORT = 3379; // 监听的端口号（学号后4位）
    private static volatile boolean isExit = false; // 是否退出程序的标志
    private static final List<Thread> threads = new ArrayList<>(); // 线程池

    public static void main(String[] args) {
        try {
            ServerSocket serverSocket = new ServerSocket(PORT);
            serverSocket.setReuseAddress(true); // 设置 SO_REUSEADDR 套接字选项以启用地址重用
            System.out.println("Server is listening on port " + PORT);
            System.out.println("[% 输入'exit' 可以结束运行 %]");

            Scanner in = new Scanner(System.in);

            // 处理客户端连接的线程
            Thread clientHandleThread = new Thread(() -> {
                while (!isExit) {
                    try {
                        // accept方法会阻塞等待
                        Socket clientSocket = serverSocket.accept();
                        if (!isExit) {
                            Thread thread = new Thread(() -> handleRequest(clientSocket));
                            thread.start();
                            threads.add(thread);
                        } else {
                            clientSocket.close(); // 如果标志位已经设置为退出，就关闭新连接的socket
                        }
                    } catch (IOException e) {
                        // 在 isExit 为 true 时，执行 serverSocket.accept() 会抛出 SocketException，可以忽略该异常
                        if (!isExit) {
                            e.printStackTrace();
                        }
                    }
                }
            });
            clientHandleThread.start();

            // 主线程等待用户输入
            while (!isExit) {
                String option = in.nextLine();
                System.out.println("用户输入: " + option);
                // 当用户输入exit时，主线程通知各子线程退出
                if(option.equals("exit")){
                    isExit = true;
                    serverSocket.close(); // 立即关闭serverSocket，中断子线程的accept()阻塞
                    clientHandleThread.interrupt(); // 中断accept()的阻塞
                    break;
                }
            }

            // 等待所有子线程退出
            for (Thread thread : threads) {
                try {
                    thread.join();
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }

            // 关闭 ServerSocket（先关客户端再关server端）
            serverSocket.close();
            System.exit(0);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private static void handleRequest(Socket clientSocket) {
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(clientSocket.getInputStream()));
             BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(clientSocket.getOutputStream()))) {

            // 读取HTTP请求头
            String requestLine = reader.readLine();

            // 解析请求方法、文件和路径名
            String[] requestParts = requestLine.split(" ");
            String method = requestParts[0];
            String filePath = requestParts[1];

            // 创建Response对象，用于处理响应
            Response response = new Response(writer, clientSocket.getOutputStream());

            // 处理GET请求
            if (method.equals("GET")) {
                // 根据文件路径读取文件内容
                // 构建HTTP响应头
                // 发送响应头和文件内容给客户端
                serveGetRequest(filePath, response);
            }
            // 处理POST请求
            else if (method.equals("POST")) {
                // 读取请求体，提取登录名和密码
                // 根据登录名和密码构建响应内容
                // 构建HTTP响应头
                // 发送响应头和响应内容给客户端
                // System.out.println("requestLine: "+requestLine);
                // System.out.println("filePath: "+filePath);
                servePostRequest(filePath, reader, response);
            }

        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                // 发送完毕后，关闭socket，退出子线程。
                clientSocket.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    private static void serveGetRequest(String filePath, Response response) throws IOException {
        // 根据文件路径读取文件内容（url需要指定二级子目录，例如/text/test.txt），否则找不到对应文件
        Path resourcePath = Paths.get("./source", filePath);
        // System.out.println("resource: " + resourcePath);
        // 如果文件不存在，返回404
        if (!Files.exists(resourcePath) || !Files.isRegularFile(resourcePath)) {
            // 调用发送错误请求方法
            response.setStatus(404);
            response.setStatusMsg("Not Found");
            response.setHeaders("Content-Type", "text/html");
            response.setHeaders("Content-Length", String.valueOf("<h1>404 Not Found</h1>".length()));
            response.send("<h1>404 Not Found</h1>");
            return;
        }
        byte[] fileContent = Files.readAllBytes(resourcePath);

        // 构建HTTP响应头
        response.setStatus(200);
        response.setStatusMsg("OK");
        response.setHeaders("Content-Type", getContentType(filePath));
        response.setHeaders("Content-Length", String.valueOf(fileContent.length));

        // 如果是图片类型，直接写入字节流
        if (getContentType(filePath).startsWith("image/")){
            response.sendImage(fileContent);
        }else{
            // 调用response的send方法发送响应头和文件内容给客户端
            response.send(new String(fileContent));
        }
    }

    private static void servePostRequest(String filePath, BufferedReader reader, Response response) throws IOException {
        // 处理 POST 请求逻辑
        if (!filePath.equals("/html/dopost")) {
            // 如果解析出来的文件和路径名不是 /html/dopost，则返回 404 Not Found
            response.setStatus(404);
            response.setHeaders("Content-Type", "text/html");
            response.setHeaders("Content-Length","0");
            response.setStatusMsg("Not Found");
            response.send("<h1>404 Not Found</h1>");
            return;
        }

        // 读取请求体，获取取登录名和密码
        String line;
        int contentLength = 0;
        // System.out.println("Request Header: ");
        // 需注意请求头和请求体以\r\n\r\n分隔，所以读取到第二个\r\n时，下面的循环会退出
        while ((line = reader.readLine()) != null && !line.isEmpty()) {
            // System.out.println(line);
            if (line.startsWith("Content-Length: ")) {
                // 获得”Content-Length: “之后第一个字符的下标
                int index = "Content-Length: ".length();
                // 获得"Content-Length: "之后的数值
                contentLength = Integer.parseInt(line.substring(index));
            }
        }

        // 循环退出时，请求头的内容已经读取完毕
        String formLine;
        // System.out.println("Request Body: ");
        // 如果 Content-Length 大于 0，则说明有请求体内容数据需要读取
        if (contentLength > 0) {
            char[] bodyData = new char[contentLength];
            reader.read(bodyData);
            formLine = String.valueOf(bodyData);
        }else{ // 请求体为空说明用户填了空表单，直接返回登陆失败的消息提示
            // 将响应消息封装成 HTML 格式
            String responseBody = "<html><body>Login Failed!</body></html>";
            // 构建 HTTP 响应头
            response.setStatus(401);
            response.setHeaders("Content-Type", "text/html");
            response.setHeaders("Content-Length", String.valueOf(responseBody.length()));
            // 发送响应头和响应内容给客户端
            response.send(responseBody);
            return;
        }

        // System.out.println(formLine);
        // 获取登录名（login）和密码（pass）的值 (login=xxx&pass=xxx)，请求体是以&分割的
        String[] bodyParts = formLine.split("&");
        String login = null;
        String password = null;
        for (String part : bodyParts) {
            String[] keyValue = part.split("=");
            if (keyValue.length == 2) {
                if (keyValue[0].equals("login")) {
                    login = keyValue[1];
                } else if (keyValue[0].equals("pass")) {
                    password = keyValue[1];
                }
            }
        }

        // 设置学号和学号后四位作为校验的用户名和密码
        String student_id = "3210103379";
        String id_last_four_bit = "3379";
        // 判断登录是否成功
        boolean loginSuccess = (login != null && login.equals(student_id) && password != null && password.equals(id_last_four_bit));

        // 将响应消息封装成 HTML 格式
        String responseBody = "<html><body>";
        if (loginSuccess) {
            responseBody += "Login Successful!";
        } else {
            responseBody += "Login Failed!";
        }
        responseBody += "</body></html>";

        // 构建 HTTP 响应头
        response.setStatus(loginSuccess ? 200 : 401);
        response.setHeaders("Content-Type", "text/html");
        response.setHeaders("Content-Length", String.valueOf(responseBody.length()));

        // 发送响应头和响应内容给客户端
        response.send(responseBody);
    }

    // 获取请求头的content-type
    private static String getContentType(String filePath) {
        if (filePath.endsWith(".html")) {
            return "text/html";
        } else if (filePath.endsWith(".jpg")||filePath.endsWith(".jpeg")) {
            return "image/jpeg";
        } else if (filePath.endsWith(".txt")) {
            return "text/plain";
        } else if (filePath.endsWith(".png")) {
            return "image/png";
        }
        // 默认为纯文本
        return "text/plain";
    }
}
