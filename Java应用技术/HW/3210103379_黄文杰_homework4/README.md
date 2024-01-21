- 该项目爬取的文献会议(2023)有：ACL、EACL、IWSLT、TACL、Findings
2. 其中爬取到的数据存储在路径为\code\Java-HW4\src\main\resources的两个子目录Text和PDF下（PDF文件由于太占空间已被删除，重新运行爬虫程序即可重新爬取），且该项目对其中的文档信息和PDF文件都建立了索引，都放在同目录（\code\Java-HW4\src\main\resources）的两个子目录Index和PDF_Index下。
3. 该项目是一个maven项目，项目主要功能的源代码都放在路径\code\Java-HW4\src\main\java\course\Java下。其中有三个Package：Lucence、Searcher、Spider，分别对应建立索引、搜索引擎、爬取数据的三个功能。