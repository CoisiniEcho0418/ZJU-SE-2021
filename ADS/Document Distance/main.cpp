#define _CRT_SECURE_NO_WARNINGS 1
#include<iostream>  
#include<string>  
#include<queue>
#include<cmath>
#define MAXNUM 1000
using namespace std;

struct File {
	string title;
	string word[MAXNUM];
	int f[MAXNUM],num,anum;//num:读取到的单词个数，anum:实际存储的单词个数（相同单词只存储一次）
};

File* file = new File[MAXNUM];

double distance(int index1, int index2);


int main(void) {
	int n, m,i,j,k;
	cin >> n;//Document的个数

	//初始化
	for (i = 0; i < n; i++) {
		file[i].num = 0;
		file[i].anum = 0;
	}

	//INPUT1

	queue<string>word_queue;//用队列临时存储每篇文章的所有单词

	for (i = 0; i < n; i++) {
		cin >> file[i].title;
		string temp;//临时变量，用来存储一个单词
		getchar();//读取换行符

		

		char c = getchar();
		while (c != '#') {
			if ((c >= 'a' && c <= 'z') ||( c >= 'A' && c <= 'Z')) {
				temp.insert(temp.length(), 1,c);//将c插入到temp末尾
			}else if (temp.length() > 0) {
				word_queue.push(temp);
				temp.clear();//清空字符串
				
				file[i].num++;//单词数++
			}
			c = getchar();
		}
		//保证所有单词都被读入队列
		if (temp.length() > 0) {
			word_queue.push(temp);
			temp.clear();//清空字符串

			file[i].num++;//单词数++
		}

		//对已存储在队列的单词进行处理（转移到另一个数组存储）
		if (file[i].num == 0) {
			cout << "Empty File";
			continue;
		}
		else {//先往file[i]中存入一个元素
			file[i].word[file[i].anum] = word_queue.front();//将队列中的元素提取出来
			word_queue.pop();//删除提取出来的元素
			file[i].f[file[i].anum]=1;
			file[i].anum++;
			
		}

		for (j = 1; j < file[i].num; j++) {
			int flag = 1;//判断是否单词是否已经存在
			string str = word_queue.front();
			for (k = 0; k < file[i].anum; k++) {
				if (file[i].word[k] == str) {
					file[i].f[k]++;//出现重复的单词
					flag = 0;
					break;
				}
			}
			if (flag) {
				file[i].word[file[i].anum] = str;
				file[i].f[file[i].anum]=1;
				file[i].anum++;
			}
			word_queue.pop();
		}

	}

	//INPUT2

	getchar();//读取换行符
	cin >> m;
	double* f_result = new double[m];//用来存储最后输出的值
	for (i = 0; i < m; i++) {
		char ch1[7], ch2[7];
		int index1 = 0, index2 = 0;
		scanf("%s%s", ch1, ch2);
		string t1(ch1), t2(ch2);
		getchar();//读取换行符
		for (j = 0; j < n; j++) {
			if (file[j].title == t1) {
				index1 = j;
			}
		}
		for (j = 0; j < n; j++) {
			if (file[j].title == t2) {
				index2 = j;
			}
		}
		f_result[i] = distance(index1, index2);

	}
	for (int k = 0; k < m; k++) {
		printf("Case %d: %.3lf\n", k + 1, f_result[k]);
	}
	


	delete[] file;

}

double distance(int index1, int index2) {
	int i,j;
	double result=0,module1=0,module2=0;
	for (i = 0; i < file[index1].anum; i++) {
		module1 += (file[index1].f[i]) * (file[index1].f[i]);
	}
	module1 = sqrt(module1);
	for (i = 0; i < file[index2].anum; i++) {
		module2 += (file[index2].f[i]) * (file[index2].f[i]);
	}
	module2 = sqrt(module2);
	for (i = 0; i < file[index1].anum; i++) {
		for (j = 0; j < file[index2].anum; j++) {
			if (file[index1].word[i] == file[index2].word[j]) {
				result += (file[index1].f[i]) * (file[index2].f[j]);
				break;
			}
		}
	}
	result = result / (module1 * module2);
	return acos(result);
}