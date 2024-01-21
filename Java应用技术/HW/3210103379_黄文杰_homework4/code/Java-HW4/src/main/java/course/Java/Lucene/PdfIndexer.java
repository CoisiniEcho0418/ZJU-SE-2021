package course.Java.Lucene;

import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.document.Document;
import org.apache.lucene.document.TextField;
import org.apache.lucene.index.IndexWriter;
import org.apache.lucene.index.IndexWriterConfig;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;

import org.apache.lucene.util.Version;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.text.PDFTextStripper;

import java.io.File;
import java.nio.file.Paths;

public class PdfIndexer {
    /**
     * 对resources目录下的 PDF 文件内容进行解析、建立索引并存储到同目录的子目录下
     * @param pdfDir 存储 PDF 文件的目录路径
     * @param indexDir 存储 PDF 索引的目录路径
     */
    public static void indexPdfDocuments(String pdfDir, String indexDir) throws Exception {
        // 设置 Lucene 索引的存储路径
        Directory indexDirectory = FSDirectory.open(Paths.get(indexDir).toFile());
        // 创建分词器对象
        Analyzer analyzer = new StandardAnalyzer();
        // 索引写出工具的配置对象
        IndexWriterConfig config = new IndexWriterConfig(Version.LATEST, analyzer);
        // 设置打开方式：OpenMode.APPEND 会在索引库的基础上追加新索引。OpenMode.CREATE 会先清空原来数据，再提交新的索引
        config.setOpenMode(IndexWriterConfig.OpenMode.CREATE);
        // 创建索引的写出工具类。参数：索引的目录和配置信息
        IndexWriter indexWriter = new IndexWriter(indexDirectory, config);

        // 读取每个 PDF 文档并索引相关字段
        File pdfFolder = new File(pdfDir);
        for (File file : pdfFolder.listFiles()) {
            if (file.isFile() && file.getName().endsWith(".pdf")) {
                Document luceneDocument = createPdfDocument(file);
                indexWriter.addDocument(luceneDocument);
            }
        }

        // 关闭 Lucene 索引写入器
        indexWriter.close();
        indexDirectory.close();
    }

    /**
     * 对 PDF 文件的内容进行解析，将相关信息建立索引，并返回document对象
     * @param file PDF文件
     * @return 将相关字段建立索引之后的document对象
     */
    private static Document createPdfDocument(File file) {
        // 创建文档对象
        Document luceneDocument = new Document();

        // 使用 PDFBox 读取 PDF 文件内容
        try (PDDocument pdfDocument = PDDocument.load(file)) {
            // 创建 PDFTextStripper 对象以从 PDF 中提取文本
            PDFTextStripper pdfStripper = new PDFTextStripper();
            try {
                // 从 PDF 文档提取文本内容
                String content = pdfStripper.getText(pdfDocument);

                // 将完整内容也索引，但不进行存储
                luceneDocument.add(new TextField("content", content, TextField.Store.NO));

                // 使用去掉 ".pdf" 后缀的文件名作为filename字段进行索引
                String fileName = file.getName().replace(".pdf", "");
                luceneDocument.add(new TextField("filename", fileName, TextField.Store.YES));
                System.out.println("Added fileName: " + fileName);
            } catch (Exception e) {
                // 输出异常信息
                System.err.println("Error extracting text from PDF: " + e.getMessage());
                e.printStackTrace();
            }
        } catch (Exception ex) {
            // 输出加载 PDF 文件时的异常信息
            System.err.println("Error loading PDF document: " + ex.getMessage());
            ex.printStackTrace();
        }

        return luceneDocument;
    }


}

