package course.Java.Lucene;

import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.document.Document;
import org.apache.lucene.document.Field;
import org.apache.lucene.document.StringField;
import org.apache.lucene.document.TextField;
import org.apache.lucene.index.IndexWriter;
import org.apache.lucene.index.IndexWriterConfig;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;
import org.apache.lucene.util.Version;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class TextIndexer {
    /**
     * 对resources目录下的文档数据建立索引并存储到同目录的子目录下
     * @param dataDir 存储文档数据的目录路径
     * @param indexDir 存储索引的目录路径
     */
    public static void indexDocuments(String dataDir, String indexDir) throws Exception {
        // 设置Lucene索引的存储路径
        Path indexPath = Paths.get(indexDir);
        // 索引目录类,指定索引在硬盘中的位置
        Directory indexDirectory = FSDirectory.open(indexPath.toFile());
        // 创建分词器对象
        Analyzer analyzer = new StandardAnalyzer();
        // 索引写出工具的配置对象
        IndexWriterConfig config = new IndexWriterConfig(Version.LATEST, analyzer);
        // 设置打开方式：OpenMode.APPEND 会在索引库的基础上追加新索引。OpenMode.CREATE会先清空原来数据，再提交新的索引
        config.setOpenMode(IndexWriterConfig.OpenMode.CREATE);
        // 创建索引的写出工具类。参数：索引的目录和配置信息
        IndexWriter indexWriter = new IndexWriter(indexDirectory, config);

        // 读取每个文档并索引相关字段
        File dataFolder = new File(dataDir);
        for (File file : dataFolder.listFiles()) {
            if (file.isFile() && file.getName().endsWith(".txt")) {
                Document luceneDocument = createLuceneDocument(file);
                // 为上面的document建立索引
                indexWriter.addDocument(luceneDocument);
            }
        }

        // 关闭Lucene索引写入器
        indexWriter.close();
        indexDirectory.close();
    }

    /**
     * 对存储文档数据的文件内容进行解析，将相关信息建立索引，并返回document对象
     * @param file 存储文档数据的文件
     * @return 将相关字段建立索引之后的document对象
     */
    private static Document createLuceneDocument(File file) throws Exception {
        // 创建文档对象
        Document luceneDocument = new Document();

        // 使用 BufferedReader 读取文件内容：
        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            StringBuilder contentBuilder = new StringBuilder();
            List<String> authorsList = new ArrayList<>();

            // 逐行读取文件内容：
            while ((line = reader.readLine()) != null) {
                // 逐行构建文档内容：
                contentBuilder.append(line).append("\n");

                // 根据每行的开头提取信息并添加到 Lucene Document 中：
                if (line.startsWith("Title:")) {
                    // 添加 title 字段
                    String titleValue = line.substring(7).trim();
                    luceneDocument.add(new TextField("title", titleValue, TextField.Store.YES));
                    System.out.println("Added title: " + titleValue);
                } else if (line.startsWith("Authors:")) {
                    // 添加 authors 字段
                    String authorsValue = line.substring(9).trim();
                    authorsList.addAll(Arrays.asList(authorsValue.split(", "))); // 以逗号和空格分隔作者
                } else if (line.startsWith("Abstract:")) {
                    // 添加 abstract 字段
                    String abstractValue = line.substring(9).trim();
                    luceneDocument.add(new TextField("abstract", abstractValue, TextField.Store.YES));
                    System.out.println("Added abstract: " + abstractValue);
                } else if (line.startsWith("Venue:")) {
                    // 添加 venue 字段
                    String venueValue = line.substring(6).trim();
                    luceneDocument.add(new TextField("venue", venueValue, TextField.Store.YES));
                    System.out.println("Added venue: " + venueValue);
                } else if (line.startsWith("Volume:")) {
                    // 添加 volume 字段
                    String volumeValue = line.substring(7).trim();
                    luceneDocument.add(new TextField("volume", volumeValue, TextField.Store.YES));
                    System.out.println("Added volume: " + volumeValue);
                } else if (line.startsWith("PDF:")) {
                    // 添加 pdf_url 字段
                    String pdfValue = line.substring(4).trim();
                    luceneDocument.add(new StringField("pdf_url",pdfValue, Field.Store.YES));
                    System.out.println("Added pdf_url: " + pdfValue);
                }
            }

            // 添加每个作者的信息
            for (String author : authorsList) {
                // 使用 TextField 创建一个多值字段
                luceneDocument.add(new TextField("authors", author, TextField.Store.YES));
                System.out.println("Added author: " + author);
            }

            // 使用文件名作为唯一ID
            String fileName = file.getName();
            luceneDocument.add(new StringField("documentId", fileName, StringField.Store.YES));
            System.out.println("Added documentId: " + fileName);

            // 将完整内容也索引
            String contentValue = contentBuilder.toString();
            luceneDocument.add(new TextField("content", contentValue, TextField.Store.YES));
            System.out.println("Added content: " + contentValue);
        }

        return luceneDocument;
    }

}