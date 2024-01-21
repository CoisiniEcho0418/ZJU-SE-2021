package course.Java.Searcher;

import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.document.Document;
import org.apache.lucene.index.DirectoryReader;
import org.apache.lucene.index.IndexReader;
import org.apache.lucene.index.Term;
import org.apache.lucene.queryparser.classic.QueryParser;
import org.apache.lucene.search.*;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;

import java.io.IOException;
import java.nio.file.Paths;
import java.util.Scanner;

public class ScholarSearcher {
    /**
     * 搜索引擎的主程序
     * @param indexDir 存储文档索引的目录路径
     * @param pdfIndexDir 存储 PDF 索引的目录路径
     */
    public static void searchDocuments(String indexDir, String pdfIndexDir) throws Exception {
        // 设置文档 Lucene索引的存储路径
        Directory docIndexDirectory = FSDirectory.open(Paths.get(indexDir).toFile());
        // 设置PDF Lucene索引的存储路径
        Directory pdfIndexDirectory = FSDirectory.open(Paths.get(pdfIndexDir).toFile());
        // 创建分词器对象
        Analyzer analyzer = new StandardAnalyzer();

        Scanner scanner = new Scanner(System.in);

        while (true) {
            // 显示菜单的提示信息
            showQueryOptions();

            // 定义是否输入了有效数的标志
            boolean isValid;
            // 定义整形变量来接受用户的输入
            int choice;
            // 定义要索引的field
            String field = "";

            do {
                // 每次循环先把有效标志设为true
                isValid = true;
                choice = scanner.nextInt();
                scanner.nextLine(); // 读取换行符

                if (choice == 0) {
                    System.out.println("Exiting the program. Goodbye!");
                    return;
                }
                // 根据用户的选择来确定要索引的字段（选择PDF默认按照content索引）

                switch (choice) {
                    // 1-4: 文档；5: PDF
                    case 1 -> field = "authors";
                    case 2 -> field = "title";
                    case 3 -> field = "abstract";
                    case 4 -> field = "venue";
                    case 5 -> field = "content"; // search PDF file by content
                    default -> {
                        System.out.println("Invalid choice. Please enter a valid number.");
                        // 设置有效标志来让用户重新输入
                        isValid = false;
                    }
                }
            } while (!isValid);


            System.out.print("Enter your search query: ");
            String queryString = scanner.nextLine();

            // 根据用户的选择来决定用哪个目录下的索引文件
            Directory currentDirectory = (choice == 5) ? pdfIndexDirectory : docIndexDirectory;

            // 创建查询解析器,两个参数：要查询的字段的名称，分词器
            QueryParser parser = new QueryParser(field, analyzer);

            // 构建查询对象
            Query query = parser.parse(queryString);

            // 执行查询（IndexReader：索引读取工具）
            try (IndexReader indexReader = DirectoryReader.open(currentDirectory)) {
                // 索引搜索工具
                IndexSearcher indexSearcher = new IndexSearcher(indexReader);
                // 搜索前10个结果
                TopDocs topDocs = indexSearcher.search(query, 10);

                // 输出查询结果
                showQueryResults(topDocs,indexSearcher,choice);

                System.out.print("Enter the number of the document to view details (enter 0 to continue): ");
                do{
                    // 每次循环先把有效标志设为true
                    isValid = true;

                    int docNumber = scanner.nextInt();
                    scanner.nextLine(); // 读取换行符

                    if (docNumber == 0) {
                        // 不查看详细信息，继续进行别的查询
                        System.out.println("Continue to search!");
                    } else if (docNumber >= 1 && docNumber <= topDocs.scoreDocs.length) {
                        // 取出文档编号
                        int selectedDocId = topDocs.scoreDocs[docNumber - 1].doc;
                        // 根据编号去找文档
                        Document selectedDocument = indexSearcher.doc(selectedDocId);

                        // 显示 文档 或者 PDF 的详细信息
                        if (choice == 5) {
                            // If searching PDF files, display PDF details
                            showPdfDetails(selectedDocument,indexDir);
                        } else {
                            // If searching documents, display document details
                            showDocDetails(selectedDocument);
                        }
                    } else {
                        System.out.println("Invalid input. Please enter a valid document number.");
                        isValid = false;
                    }
                } while (!isValid);

            }
        }
    }

    /**
     * 显示查询选项的菜单
     */
    private static void showQueryOptions(){
        System.out.println("Enter a number to perform the corresponding action:");
        System.out.println("0: Exit");
        System.out.println("1: Search by Authors");
        System.out.println("2: Search by Title");
        System.out.println("3: Search by Abstract");
        System.out.println("4: Search by Venue");
        System.out.println("5: Search PDF Files by Content");
        System.out.print("Your choice: ");
    }

    /**
     * 显示查询结果
     * @param topDocs 命中的documents列表
     * @param indexSearcher 调用者传入的IndexSearcher类
     * @param choice 用户输入的查询选项（用来判断是否选择了 PDF 查询）
     */
    private static void  showQueryResults(TopDocs topDocs, IndexSearcher indexSearcher, int choice) throws IOException {
        System.out.println("---------------------------------------------------");
        System.out.println("Search results:");
        for (int i = 0; i < topDocs.scoreDocs.length; i++) {
            // 获得命中的文档 ScoreDoc ，其封装了文档id信息
            // SocreDoc中包含：文档的编号、文档的得分
            ScoreDoc scoreDoc = topDocs.scoreDocs[i];
            //获取文档id
            int docId = scoreDoc.doc;
            //通过文档id获取文档对象
            Document document = indexSearcher.doc(docId);
            // 根据是否查询PDF来返回不同的信息
            if(choice==5){
                System.out.println((i + 1) + ": " + document.get("filename"));
            }else{
                System.out.println((i + 1) + ": " + document.get("title"));
            }
        }
        System.out.println("---------------------------------------------------");
    }

    /**
     * 显示文档数据的详细信息
     * @param selectedDocument 用户选择要查看详细信息的document
     */
    private static void showDocDetails(Document selectedDocument){
        // 显示 DocumentId,Title,Authors,Abstract,Venue,Volume,pdf_url,Content这些信息
        System.out.println("---------------------------------------------------");
        System.out.println("Selected Document Details:");
        System.out.println("DocumentId: " + selectedDocument.get("documentId"));
        System.out.println("Title: " + selectedDocument.get("title"));
        System.out.println("Authors: " + String.join(", ", selectedDocument.getValues("authors")));
        System.out.println("Abstract: " + selectedDocument.get("abstract"));
        System.out.println("Venue: " + selectedDocument.get("venue"));
        System.out.println("Volume: " + selectedDocument.get("volume"));
        System.out.println("PDF URL: " + selectedDocument.get("pdf_url"));
        System.out.println("Content: " + selectedDocument.get("content"));
        System.out.println("---------------------------------------------------");
    }

    /**
     * 显示 PDF 的详细信息
     * @param selectedDocument 用户选择要查看详细信息的 PDF document
     * @param docIndexPath 存储文档索引的目录路径（要根据PDF的filename来找到与之一一对应的文档索引，并从中获取pdf_url字段）
     */
    private static void showPdfDetails(Document selectedDocument, String docIndexPath) {
        // 显示 filename 和 pdf_url 这些信息
        System.out.println("---------------------------------------------------");
        System.out.println("Selected PDF Document Details:");
        System.out.println("Filename: " + selectedDocument.get("filename"));

        // 构造对应文档索引的 documentId
        String documentId = selectedDocument.get("filename") + ".txt";

        // 在文档索引的目录下搜索该 documentId 对应的文档
        try (Directory docIndexDirectory = FSDirectory.open(Paths.get(docIndexPath).toFile());
             IndexReader docIndexReader = DirectoryReader.open(docIndexDirectory)) {
            IndexSearcher docIndexSearcher = new IndexSearcher(docIndexReader);

            // 构建查询对象，根据文档的 documentId 字段搜索
            Query docIdQuery = new TermQuery(new Term("documentId", documentId));
            TopDocs docIdTopDocs = docIndexSearcher.search(docIdQuery, 1);

            if (docIdTopDocs.totalHits > 0) {
                // 提取找到的文档中的 pdf_url 字段
                int docId = docIdTopDocs.scoreDocs[0].doc;
                Document docIndexDocument = docIndexSearcher.doc(docId);
                String pdfUrl = docIndexDocument.get("pdf_url");
                System.out.println("PDF URL: " + pdfUrl);
            } else {
                System.out.println("No corresponding document found in the document index.");
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        System.out.println("---------------------------------------------------");
    }


}
