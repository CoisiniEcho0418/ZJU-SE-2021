package course.Java.Spider;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import java.io.IOException;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.List;
import java.io.FileWriter;
import java.io.InputStream;
import java.net.URL;
import java.net.URLConnection;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.util.HashMap;
import java.util.Map;

// 爬虫方法类（用于爬取数据并存储到本地）
public class JsoupSpider {
    /*
     * 在该工具类中保留了启动方法。这是因为各个页面元素有差异性，所以在爬取各个各个页面的数据之前，需要对一些变量的值做更改。
     * 一般推荐先爬完数据再进行建立索引以及启动主程序这些操作。
    */

    /*
    public static void main(String[] args) throws IOException {
        // 设置要爬取的网站URL
        String baseUrl = "https://aclanthology.org/";
        // 设置要爬取的期刊对应的子页面的url（后缀）
        String pageUrl = "https://aclanthology.org/events/findings-2023/";
        String[] articleLinksList = getArticleLinks(pageUrl);
        // 输出文献链接
        System.out.println("文献链接列表:");
        for (String link : articleLinksList) {
            System.out.println(link);
        }
        for(String link:articleLinksList){
            scrapeAndSaveArticle(link);
        }
    }
    */

    /**
     * 获取当前页面中所有文献的链接（设置上限200条）
     * @param pageUrl 当前页面的URL
     * @return 包含文献链接的字符串数组
     */
    public static String[] getArticleLinks(String pageUrl) {
        List<String> articleLinksList = new ArrayList<>();
        int count=0;

        try {
            // 获取页面内容
            Document document = Jsoup.connect(pageUrl).get();

            // 获取页面中包含2023年某会议所有文献链接的div元素，venueDivID用于指定对应页面的div块的id
            String venueDivID = "2023findings-eacl";
            Element divBlock = document.getElementById(venueDivID);
            // 获取div块中的p标签 列表
            if(divBlock==null){
                return null;
            }
            Elements pLists = divBlock.getElementsByTag("p");

            // 提取文献链接并添加到列表中（设置最多提取200篇ACL文献，30篇其他会议的文献，通过修改count来实现）
            // 跳过第一个p标签（i从1开始是为了跳过第一篇文章）
            for (int i = 1; i < pLists.size() && count<=30; i++) {
                Element p = pLists.get(i);

                // 选择p标签下的第二个span标签
                Elements secondSpans = p.select("span:eq(1)");
                // 选择span标签下的strong标签下的a标签
                Elements aTags = secondSpans.select("strong a");

                // 检查是否有符合条件的a标签
                if (!aTags.isEmpty()) {
                    String link = aTags.attr("abs:href"); // 获取绝对链接
                    articleLinksList.add(link);
                    count++;
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        // 将列表转换为数组并返回
        return articleLinksList.toArray(new String[0]);
    }

    /**
     * 根据传入的url和filename下载对应的pdf并命名为filename.pdf
     * @param pdfUrl pdf的下载链接
     * @param fileName 要设置的pdf文件名
     */
    private static void downloadPDF(String pdfUrl, String fileName) throws IOException {
        URL url = new URL(pdfUrl);
        URLConnection connection = url.openConnection();

        // 处理可能出现的非法字符，将非法字符替换为下划线
        String sanitizedFileName = fileName.replaceAll("[^a-zA-Z0-9.-]", "_");
        // 添加.pdf后缀
        String pdfFileName = sanitizedFileName + ".pdf";

        try (InputStream in = connection.getInputStream()) {
            // 设置本地存储路径
            Path localPath = Path.of("src/main/resources/PDF", pdfFileName);

            // 保存文件到本地
            Files.copy(in, localPath, StandardCopyOption.REPLACE_EXISTING);
        }

        System.out.println(pdfFileName + " downloaded successfully!");
    }

    /**
     * 获取文献其他信息
     * @param articleDocument 包含文献信息的Jsoup文档对象
     * @return 包含其他信息的Map对象
     */
    private static Map<String, String> getOtherArticleInfo(Document articleDocument) {
        Map<String, String> otherInfoMap = new HashMap<>();
        //获取根元素的dl标签块
        Element dlBlock = articleDocument.getElementsByTag("dl").first();
        /*
        获取Anthology ID、Volume、Month、Year、Address、Editors、Venue、SIG、Publisher、
        Note、Pages、Language、URL、DOI、Bibkey、Cite (ACL)、Cite (Informal)、PDF这些信息
        */
        // 一个个获取太麻烦，改用循环实现：
        if (dlBlock != null) {
            try{
                // 获取dl元素下的所有dt元素
                Elements dtElements = dlBlock.select("dt");

                // 遍历dt元素
                for (Element dt : dtElements) {
                    // 获取dt元素的文本内容
                    String key = dt.text();

                    //不获取“Copy Citation:”
                    if(key.equals("Copy Citation:")){
                        continue;
                    }

                    // 获取dt元素后的第一个dd元素
                    Element dd = dt.nextElementSibling();

                    // 检查是否存在dd元素
                    if (dd != null) {
                        //对一些dt段做特殊处理
                        switch (key) {
                            case "Volume:", "Venue:", "URL:", "PDF:" -> {
                                Element a = dd.getElementsByTag("a").first();
                                String value = a != null ? a.text() : "N/A";
                                // 将key-value存入Map对象
                                otherInfoMap.put(key, value);
                            }
                            case "Editors:" -> {
                                Elements aLists = dd.getElementsByTag("a");
                                // 创建一个String数组来存储Editors信息
                                String[] Editors = new String[aLists.size()];
                                // 获取每个a标签的文本内容并存入数组
                                for (int i = 0; i < aLists.size(); i++) {
                                    Element Editor = aLists.get(i);
                                    Editors[i] = Editor.text();
                                }
                                String value = String.join(",", Editors);
                                otherInfoMap.put(key, value);
                            }
                            case "Bibkey:" -> {
                                Element span = dd.select("button span").first();
                                String value = span != null ? span.text() : "N/A";
                                otherInfoMap.put(key, value);
                            }
                            case "Cite (ACL):", "Cite (Informal):" -> {
                                Element span = dd.getElementsByTag("span").first();
                                String value = span != null ? span.text() : "N/A";
                                otherInfoMap.put(key, value);
                            }
                            default -> {
                                // 获取dd元素的文本内容
                                String value = dd.text();
                                // 将key-value存入Map对象
                                otherInfoMap.put(key, value);
                            }
                        }

                    }
                }
            }catch (Exception e) {
                e.printStackTrace();
            }

        }

        return otherInfoMap;
    }

    /**
     * 获取详情页中的BibTex内容
     * @param articleDocument 文献详情页的Document元素
     * @return 包含BibTex内容的字符串
     */
    private static String getBibTex(Document articleDocument){
        Element pre = articleDocument.getElementById("citeBibtexContent");
        return pre != null ? pre.text() : "N/A";
    }

    /**
     * 爬取文献详情页的内容并保存相关信息到本地
     * @param articleLink 某篇文献详情页的url
     */
    public static void scrapeAndSaveArticle(String articleLink) {
        try {
            // 获取文献链接的页面内容
            Document articleDocument = Jsoup.connect(articleLink).get();

            // 1. 获取标题
            Element titleElement = articleDocument.getElementById("title");
            String title = titleElement.select("a").text();

            // 2. 获取作者
            // 选择id为"lead"的p标签下的所有a标签
            Element pTag = articleDocument.getElementsByClass("lead").first();
            Elements authorLinks = pTag.getElementsByTag("a");
            // 创建一个String数组来存储作者信息
            String[] authors = new String[authorLinks.size()];
            // 获取每个a标签的文本内容并存入数组
            for (int i = 0; i < authorLinks.size(); i++) {
                Element authorLink = authorLinks.get(i);
                authors[i] = authorLink.text();
            }

            // 3. 获取摘要
            Element abstractBlock = articleDocument.getElementsByClass("card-body acl-abstract").first();
            String abstractText = abstractBlock.select("span").text();

            // 4. 获取其他信息
            Map<String, String> otherInfo = getOtherArticleInfo(articleDocument);

            // 5. 下载PDF到本地（resources的子目录PDF下）
            Element pdfDivBlock = articleDocument.getElementsByClass("acl-paper-link-block").first();
            // 选择第一个a标签
            Element firstATag = pdfDivBlock.selectFirst("a");
            // 获取a标签中的href属性值
            String pdfUrl = firstATag.attr("href");
            downloadPDF(pdfUrl,title);
            // 输出结果
            System.out.println("PDF URL: " + pdfUrl);
            
            // 6. 获取BibTex的内容
            String BibTex = getBibTex(articleDocument);

            // 7. 将抽取出来的信息写入本地的文本文件当中
            // 创建文件名以标题命名，保存到resources目录下的子目录Text
            // 处理文件名中可能出现的非法字符，并将非法字符替换为下划线
            String sanitizedTitle = title.replaceAll("[^a-zA-Z0-9.-]", "_");
            String fileName = "src/main/resources/Text/" + sanitizedTitle + ".txt";
            // 将信息写入文件
            try (FileWriter writer = new FileWriter(fileName)) {
                // 写入标题、作者和摘要信息
                writer.write("Title: " + title + "\n");
                writer.write("Authors: " + String.join(", ", authors) + "\n");
                writer.write("Abstract: " + abstractText + "\n");
                // 写入其他信息
                for (Map.Entry<String, String> entry : otherInfo.entrySet()) {
                    System.out.println(entry.getKey() + entry.getValue());
                    writer.write(entry.getKey() + entry.getValue() + "\n");
                }
                //写入BibTex
                writer.write("BibTex: " + BibTex + "\n");
            } catch (IOException e) {
                e.printStackTrace();
            }

            System.out.println("Article information saved for: " + title);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }


}
