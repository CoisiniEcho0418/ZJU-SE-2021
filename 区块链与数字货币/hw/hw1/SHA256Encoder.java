import java.util.Arrays;
import java.util.concurrent.*;
import java.util.concurrent.atomic.*;

/**
@author hwj
@create: 2024-09-22 20:41
@Description: 
*/
public class SHA256Encoder {

    // 初始哈希值（H0, H1, ..., H7）
    private static final int[] H = {
            0x6a09e667, 0xbb67ae85, 0x3c6ef372, 0xa54ff53a,
            0x510e527f, 0x9b05688c, 0x1f83d9ab, 0x5be0cd19
    };

    // SHA-256的64个混淆常量K
    private static final int[] K = {
            0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5, 0x3956c25b, 0x59f111f1, 0x923f82a4, 0xab1c5ed5,
            0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3, 0x72be5d74, 0x80deb1fe, 0x9bdc06a7, 0xc19bf174,
            0xe49b69c1, 0xefbe4786, 0x0fc19dc6, 0x240ca1cc, 0x2de92c6f, 0x4a7484aa, 0x5cb0a9dc, 0x76f988da,
            0x983e5152, 0xa831c66d, 0xb00327c8, 0xbf597fc7, 0xc6e00bf3, 0xd5a79147, 0x06ca6351, 0x14292967,
            0x27b70a85, 0x2e1b2138, 0x4d2c6dfc, 0x53380d13, 0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85,
            0xa2bfe8a1, 0xa81a664b, 0xc24b8b70, 0xc76c51a3, 0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070,
            0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5, 0x391c0cb3, 0x4ed8aa4a, 0x5b9cca4f, 0x682e6ff3,
            0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208, 0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2
    };

    // 循环右移
    private static int rightRotate(int value, int bits) {
        return (value >>> bits) | (value << (32 - bits));
    }

    // SHA-256算法实现
    public static String sha256(String message) {
        byte[] bytes = message.getBytes();
        int[] paddedMessage = padMessage(bytes);

        int[] hash = Arrays.copyOf(H, H.length); // 初始化hash值
        int[] w = new int[64]; // 消息扩展块

        // 处理每一个512位的块
        for (int i = 0; i < paddedMessage.length / 16; i++) {
            // 拆分（每一个 512bits 块拆成 16 个 32bits 块放入w[0~15]中）
            System.arraycopy(paddedMessage, i * 16, w, 0, 16);

            // 扩散
            for (int t = 16; t < 64; t++) {
                int s0 = rightRotate(w[t - 15], 7) ^ rightRotate(w[t - 15], 18) ^ (w[t - 15] >>> 3);
                int s1 = rightRotate(w[t - 2], 17) ^ rightRotate(w[t - 2], 19) ^ (w[t - 2] >>> 10);
                w[t] = w[t - 16] + s0 + w[t - 7] + s1;
            }

            // 初始哈希值
            int a = hash[0];
            int b = hash[1];
            int c = hash[2];
            int d = hash[3];
            int e = hash[4];
            int f = hash[5];
            int g = hash[6];
            int h = hash[7];

            // 64次迭代混淆
            for (int t = 0; t < 64; t++) {
                int s1 = rightRotate(e, 6) ^ rightRotate(e, 11) ^ rightRotate(e, 25);
                int ch = (e & f) ^ ((~e) & g);
                int temp1 = h + s1 + ch + K[t] + w[t];
                int s0 = rightRotate(a, 2) ^ rightRotate(a, 13) ^ rightRotate(a, 22);
                int maj = (a & b) ^ (a & c) ^ (b & c);
                int temp2 = s0 + maj;

                h = g;
                g = f;
                f = e;
                e = d + temp1;
                d = c;
                c = b;
                b = a;
                a = temp1 + temp2;
            }

            // 计算下一块的初始哈希值
            hash[0] += a;
            hash[1] += b;
            hash[2] += c;
            hash[3] += d;
            hash[4] += e;
            hash[5] += f;
            hash[6] += g;
            hash[7] += h;
        }

        // 将哈希值转换为十六进制字符串
        StringBuilder hexString = new StringBuilder();
        for (int hval : hash) {
            hexString.append(String.format("%08x", hval));
        }
        return hexString.toString();
    }

    // 填充消息
    private static int[] padMessage(byte[] message) {
        int originalLength = message.length;
        int blockCount = ((originalLength + 8) / 64) + 1; // 保证填充位数在1~512之间
        int totalLength = blockCount * 16; // 以32位整数为单位

        int[] paddedMessage = new int[totalLength];

        // 将消息复制到填充后的数组中
        for (int i = 0; i < originalLength; i++) {
            paddedMessage[i / 4] |= (message[i] & 0xFF) << (24 - (i % 4) * 8);
        }

        // 添加1位'1'，其余位补零
        paddedMessage[originalLength / 4] |= 0x80 << (24 - (originalLength % 4) * 8);

        // 添加原消息的长度（以比特为单位）
        long messageBitsLength = (long) originalLength * 8;
        paddedMessage[totalLength - 2] = (int) (messageBitsLength >>> 32);
        paddedMessage[totalLength - 1] = (int) messageBitsLength;

        return paddedMessage;
    }

    // 将哈希值转换为二进制字符串
    public static String hexToBinary(String hex) {
        StringBuilder binary = new StringBuilder();
        for (int i = 0; i < hex.length(); i++) {
            String bin = Integer.toBinaryString(Integer.parseInt(hex.substring(i, i + 1), 16));
            bin = "0".repeat(4-bin.length()) + bin;
            binary.append(bin);
        }
        return binary.toString();
    }

    // 查找前n位为0的nonce
    public static void findNonce(String baseText, int zeroBits) {
        long startTime = System.currentTimeMillis();
        long nonce = 0;
        while (true) {
            String testText = baseText + nonce;
            String hash = sha256(testText);
            String binaryHash = hexToBinary(hash);
            // 检查前n位是否为0
            if (binaryHash.startsWith("0".repeat(zeroBits))) {
                // 确保是前zeroBits位为0，且后面位不为0
                if (binaryHash.charAt(zeroBits) != '0') {
                    long endTime = System.currentTimeMillis();
                    long duration = endTime - startTime;
                    System.out.println("Hash: " + hash);
                    System.out.println("BinaryHash: " + binaryHash);
                    System.out.println("Nonce: " + nonce);
                    System.out.println("Used Time: " + (duration / 1000.0) + " seconds");
                    break;
                }
            }
            nonce++;
        }
    }

    // 查找前n位为0的nonce（多线程版本）
    public static void findNonceParallel(String baseText, int zeroBits, int threadCount) {
        long startTime = System.currentTimeMillis();
        AtomicLong nonce = new AtomicLong(0);
        AtomicBoolean found = new AtomicBoolean(false); // 是否找到nonce
        ExecutorService executor = Executors.newFixedThreadPool(threadCount);

        for (int i = 0; i < threadCount; i++) {
            executor.submit(() -> {
                while (!found.get()) {
                    long currentNonce = nonce.getAndIncrement();
                    String testText = baseText + currentNonce;
                    String hash = sha256(testText);
                    String binaryHash = hexToBinary(hash);
                    // 检查前n位是否为0
                    if (binaryHash.startsWith("0".repeat(zeroBits))) {
                        // 确保是前zeroBits位为0，且后面位不为0
                        if (binaryHash.charAt(zeroBits) != '0') {
                            found.set(true); // 标记为找到
                            long endTime = System.currentTimeMillis();
                            System.out.println("Hash: " + hash);
                            System.out.println("BinaryHash: " + binaryHash);
                            System.out.println("Nonce: " + currentNonce);
                            System.out.println("Used Time: " + (endTime - startTime) / 1000.0 + " seconds");
                        }
                    }
                }
            });
        }

        executor.shutdown();
        while (!executor.isTerminated()) {
            // 等待所有线程完成
        }
    }

    // 同时查找多为指定前缀为0的nonce（多线程版本）
    public static void findMultiNonceParallel(String baseText, int threadCount, int[] zeroBitsArray) {
        long startTime = System.currentTimeMillis();

        AtomicLong nonce = new AtomicLong(0);
        int numTargets = zeroBitsArray.length;
        AtomicBoolean[] foundArray = new AtomicBoolean[numTargets];
        AtomicInteger successCounts = new AtomicInteger(0);

        // 初始化每个 AtomicBoolean，表示每个前缀位数是否找到
        for (int i = 0; i < numTargets; i++) {
            foundArray[i] = new AtomicBoolean(false);
        }

        ExecutorService executor = new ThreadPoolExecutor(threadCount,2*threadCount,60, TimeUnit.SECONDS,new ArrayBlockingQueue<>(100),Executors.defaultThreadFactory(),new ThreadPoolExecutor.AbortPolicy());

        for (int i = 0; i < threadCount; i++) {
            executor.submit(() -> {
                while (successCounts.get()!=numTargets) {
                    long currentNonce = nonce.getAndIncrement();
                    String testText = baseText + currentNonce;
                    String hash = sha256(testText);
                    String binaryHash = hexToBinary(hash);

                    // 逐个检查不同前缀位数的条件
                    for (int j = 0; j < numTargets; j++) {
                        int zeroBits = zeroBitsArray[j];
                        if (!foundArray[j].get() && binaryHash.startsWith("0".repeat(zeroBits)) && binaryHash.charAt(zeroBits) != '0') {
                            foundArray[j].set(true);  // 标记为找到
                            successCounts.getAndIncrement();
                            long endTime = System.currentTimeMillis();
                            System.out.println(zeroBits + " bits Hash: " + hash);
                            System.out.println(zeroBits + " bits BinaryHash: " + binaryHash);
                            System.out.println(zeroBits + " bits Nonce: " + currentNonce);
                            System.out.println(zeroBits + " bits Used Time: " + (endTime - startTime) / 1000.0 + " seconds");
                        }
                    }
                }
            });
        }

        executor.shutdown();
        while (!executor.isTerminated()) {
            // 等待所有线程完成
        }
    }

    public static void main(String[] args) {
        String baseText = "Blockchain@ZhejiangUniversity";
        // 优化版，在一个方法里同时找30、31、32前缀0的nonce
        System.out.println("Searching for nonce with specified multiple bits prefix:");
        findMultiNonceParallel(baseText, 8,new int[]{30,31,32}); // 4 个线程
//        System.out.println("30bits zero prefix nonce:");
//        //findNonce(baseText,30);
//        findNonceParallel(baseText, 30, 4);
//        System.out.println("-------------------------");
//        System.out.println("31bits zero prefix nonce:");
//        //findNonce(baseText,31);
//        findNonceParallel(baseText, 31, 4);
//        System.out.println("-------------------------");
//        System.out.println("32bits zero prefix nonce:");
//        //findNonce(baseText,32);
//        findNonceParallel(baseText, 32, 4);
    }
}

