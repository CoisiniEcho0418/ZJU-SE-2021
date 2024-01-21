import java.io.BufferedWriter;
import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;

public class Response {
    private BufferedWriter writer;
    private OutputStream outputStream; // 添加 OutputStream
    private HashMap<String, String> headers = new HashMap<>();
    private int status;
    private String msg;

    public Response(BufferedWriter writer, OutputStream outputStream) {
        this.writer = writer;
        this.outputStream = outputStream; // 初始化 OutputStream
        this.msg = "";
    }

    public void setHeaders(String key, String value) {
        this.headers.put(key, value);
    }

    public void setStatusMsg(String msg) {
        this.msg = msg;
    }

    public void setStatus(int statusCode) {
        this.status = statusCode;
    }

    public OutputStream getOutputStream() {
        return this.outputStream;
    }

    // 发送文本内容（包括html）的方法
    public void send(String data) {
        try {
            StringBuilder dataBuilder = new StringBuilder();
            dataBuilder.append("HTTP/1.1 ").append(this.status).append(" ").append(this.msg).append("\r\n");
            for (String key : this.headers.keySet()) {
                dataBuilder.append(key).append(": ").append(this.headers.get(key)).append("\r\n");
            }
            dataBuilder.append("\r\n").append(data);

            writer.write(dataBuilder.toString());
            writer.flush();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // 发送图片的方法（通过写入字节流的方式而不是String的方式）
    public void sendImage(byte[] imageData) {
        try {
            // Build HTTP response headers for an image
            StringBuilder headersBuilder = new StringBuilder();
            headersBuilder.append("HTTP/1.1 ").append(this.status).append(" ").append(this.msg).append("\r\n");
            for (String key : this.headers.keySet()) {
                headersBuilder.append(key).append(": ").append(this.headers.get(key)).append("\r\n");
            }
            headersBuilder.append("\r\n");

            // Write headers to the output stream
            outputStream.write(headersBuilder.toString().getBytes());

            // Write image data to the output stream
            outputStream.write(imageData);
            outputStream.flush();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
