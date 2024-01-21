package course.Java;

import course.Java.Spider.JsoupSpider;
import course.Java.Lucene.TextIndexer;
import course.Java.Lucene.PdfIndexer;
import course.Java.Searcher.ScholarSearcher;

import java.io.File;
import java.nio.file.Paths;


// 程序的主类
public class Main {
    /* Tips：由于每个页面的元素有差异性，所以建议先爬取完数据再进行建立索引以及启动搜索引擎主程序这些操作 */
    public static void main(String[] args) {
        /* 1. 先爬取数据并存储到本地 */
//        // 设置要爬取的网站URL
//        String baseUrl = "https://aclanthology.org/";
//        // 设置要爬取的期刊对应的子页面的url（后缀）
//        String pageUrl = "https://aclanthology.org/events/findings-2023/";
//        // 调用 JsoupSpider 类提供的方法完成爬取数据并存储到本地的过程
//        exciteSpider(pageUrl);

        /* 2. 解析获取到的信息并建立合适的索引 */
        // 获取resources目录的绝对路径
        String resourcesPath = new File("src/main/resources").getAbsolutePath();
        // 文本数据目录的相对路径
        String dataDir = "Text";
        // Lucene索引目录的相对路径
        String indexDir = "Index";
        // 完整的文本数据目录和索引目录路径
        String fullDataDir = Paths.get(resourcesPath, dataDir).toString();
        String fullIndexDir = Paths.get(resourcesPath, indexDir).toString();
        // 存储PDF目录的相对路径
        String pdfDir = "PDF";
        // 存储PDF索引目录的相对路径
        String pdfIndexDir = "PDF_Index";
        // 完整的PDF目录和PDF索引目录路径
        String fullPdfDir = Paths.get(resourcesPath, pdfDir).toString();
        String fullPdfIndexDir = Paths.get(resourcesPath, pdfIndexDir).toString();
        // 调用 LuceneIndexer 和 PdfIndexer 类提供的方法完成解析数据并建立索引的过程
//        createIndex(fullDataDir,fullIndexDir,fullPdfDir,fullPdfIndexDir);

        /* 3. 启动搜索引擎 */
        try {
            ScholarSearcher.searchDocuments(fullIndexDir,fullPdfIndexDir);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    /**
     * 调用 JsoupSpider 类提供的方法完成爬取数据并存储到本地的过程
     * @param pageUrl 设置要爬取的期刊对应的子页面的url（后缀）
     */
    public static void exciteSpider(String pageUrl){
        String[] articleLinksList = JsoupSpider.getArticleLinks(pageUrl);

        // 输出文献链接
        System.out.println("文献链接列表:");
        for (String link : articleLinksList) {
            System.out.println(link);
        }

        // 进入每个文献链接里面去爬取相关的信息
        for (String link : articleLinksList) {
            // 爬取文献详情页的内容并保存相关信息到本地
            JsoupSpider.scrapeAndSaveArticle(link);
        }
    }

    /**
     * 调用 LuceneIndexer 和 PdfIndexer 类提供的方法完成解析数据并建立索引的过程
     * @param fullDataDir 完整的文本数据存储目录
     * @param fullIndexDir 完整的文本索引存储目录
     * @param fullPdfDir 完整的PDF文件存储目录
     * @param fullPdfIndexDir 完整的PDF索引存储目录
     */
    public static void createIndex(String fullDataDir, String fullIndexDir, String fullPdfDir, String fullPdfIndexDir){
        try{
            TextIndexer.indexDocuments(fullDataDir, fullIndexDir);
        }catch (Exception e){
            e.printStackTrace();
        }
        try {
            PdfIndexer.indexPdfDocuments(fullPdfDir, fullPdfIndexDir);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
