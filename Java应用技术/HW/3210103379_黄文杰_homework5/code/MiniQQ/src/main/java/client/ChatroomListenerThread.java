package client;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.Arrays;

public class ChatroomListenerThread extends Thread {
    private BufferedReader reader;
    private GroupChat groupChat;

    public ChatroomListenerThread(BufferedReader reader, GroupChat groupChat) {
        this.reader = reader;
        this.groupChat = groupChat;
    }

    @Override
    public void run() {
        try {
            String serverMessage;
            while ((serverMessage = reader.readLine()) != null) {
                // 处理服务器发送的消息
                processServerMessage(serverMessage);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void processServerMessage(String serverMessage) {
        String[] parts = serverMessage.split(" ");
        String command = parts[0];
        if("GROUP_MESSAGE".equals(command)){
            String time = parts[1].split(":")[1]+" "+parts[2];
            String user = parts[3].split(":")[1];
            String message = parts[4].split(":")[1];
            groupChat.appendChatMessage("");
            groupChat.appendChatMessage(time);
            groupChat.appendChatMessage(user+": "+message);
        } else if ("GROUP_LOGIN".equals(command)){
            String user = parts[1].split(":")[1];
            groupChat.appendChatMessage("["+user+"]进入了房间");
        } else if ("MEMBER_LIST".equals(command)) {
            // 去掉第一个元素
            String[] memberList = Arrays.copyOfRange(parts, 1, parts.length);
            groupChat.updateMemberMessage(memberList);
        } else if ("USER_LEAVE".equals(command)) {
            String leaveInfo = parts[1];
            groupChat.appendChatMessage(leaveInfo);
        }
    }
}
