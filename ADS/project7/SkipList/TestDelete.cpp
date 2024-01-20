#include <iostream>
#include <time.h>
#include<fstream>
#include "skiplist.h"
using namespace std;

//print skip list
void printlist(Skiplist* sl) {
	Node* p = NULL;
	for (int i = sl->level - 1; i >= 0; i--) {
		p = sl->head->next[i];
		cout << "LEVEL " << i << ": " << endl;
		while (p != NULL) {
			//Whether it is the last in the same hierarchy
			if (p->next[i] == NULL) {
				cout << " " << p->val << endl;
			}
			else {
				cout << p->val << " -->";
			}
			p = p->next[i];
		}
	}
}

int main(void) {
	//create a skip list
	Skiplist* sl = NULL;
	//Ensure that the generated skip list is not empty
	do {
		sl = createlist();
	} while (sl == NULL);

	srand((unsigned)time(NULL));

	ofstream out;
	out.open("DeleteData.txt", ios::trunc);

	//The number of skip list nodes
	int nodenum;
	cout << "Input node number of skip list:";
	cin >> nodenum;

	//Generate a skip list with the number of nodenums
	//Insert randomly generated numbers (range: 1 ~ nodenum*10)
	for (int i = 0; i < nodenum; i++) {
		int RanddomNumber = rand() % (nodenum * 10) + 1;//Generate random numbers of 1 ~ nodenum*10
		if (!Insert(sl, RanddomNumber)) {//Insert failed
			i--;//Re-perform the insert operation
			continue;
		}
		//Write the generated numbers to a data.txt file
		out << RanddomNumber << " ";
	}

	out << "\n";
	out.close();

	//Print the generated skip list
	printlist(sl);

	//count delete time
	double st = clock();
	//Cycle ten times to increase the total time!!!
	for (int i = 0; i < 10; i++) {
		//Generate random numbers of 1 ~ nodenum*10
		int DeleteNumber = rand() % (nodenum * 10) + 1;
		if (!Delete(sl, DeleteNumber)) {
			cout << "删除结点失败（节点不存在或程序出错）！ val：" << DeleteNumber << endl;
		}
		else {
			cout << "删除结点成功！ val：" << DeleteNumber << endl;
		}
	}
	double ed = clock();

	//print the total delete time(*10)
	cout << "Delete Time: " << ed - st << endl;

	//free skip list
	freesl(sl);
	system("pause");
	return 0;
	
}