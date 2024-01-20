#include<iostream>
#include<cmath>
#define mod 1000000007
using namespace std;

long long RBTree(int nodenum);//返回类型设置为long long（当N较大时，int和long类型会有溢出）

int main(void) {
	int n;
	cin >> n;
	cout << RBTree(n);
}

long long RBTree(int nodenum) {
	//int maxH = int(floor(log2(double(nodenum + 1))));
	int maxH = floor(log2(nodenum + 1));//算出内部节点为nodenum时红黑树的最大高度
	//定义两个二维数组，numB[i][j]表示高度为i、内部节点数为j的黑根红黑树的个数，numR[i][j]表示表示高度为i、内部节点数为j的红根红黑树的个数
	long long** numB = new long long* [maxH + 1];//存储类型也设为long long，（int和long类型会有溢出）
	long long** numR = new long long* [maxH + 1];
	for (int i = 0; i < maxH + 1; i++) {
		numB[i] = new long long[nodenum + 1];
		numR[i] = new long long[nodenum + 1];
	}
	//数组定义完毕，对其进行初始化
	for (int i = 0; i < maxH + 1; i++) {
		for (int j = 0; j < nodenum + 1; j++) {
			numB[i][j] = numR[i][j] = 0;
		}
	}
	//初始条件（对高为1的numB和numR赋初值）
	numB[1][1] = 1; numB[1][2] = 2; numB[1][3] = 1;
	numR[1][1] = 1;
	//填表：对于任意的i和j，有如下递推关系式：numR[i][j]=SUM(numB[i][j-k-1]*numB[i][k]) (k=1,2,...j-2),
	//numB[i][j]=SUM((numB[i-1][j-k-1]+numR[i][j-k-1])*(numB[i-1][k]+numR[i][k])) (k=1,2,...j-2)
	//解释：对于红根红黑树，其两个子节点必为两个同高的黑根红黑树；而对于黑根红黑树，其两个子节点可为高度减一的双黑、双红、一黑一红。
	for (int i = 2; i <= maxH; i++) {
		//对于高为i的红黑树，其内部节点数最少为2^i-1，最多为2^(2*i)-1（黑根红黑树是2^(2*i)-1，红根红黑树是2^(2*i-1)-1，两者取较大值）
		int min = int(pow(2.0, double(i))) - 1;//最少内部节点数
		int max = int(pow(2.0, double(2 * i))) - 1;//最多内部节点数()
		if (max > nodenum) {//考虑最大节点数溢出的情况
			max = nodenum;
		}
		for (int j = min; j <= max; j++) {//定义min和max来减少循环次数
			for (int k = 1; k < j - 1; k++) {//先计算numR[i][j]，因为numB[i][j]的计算会用到numR[i][j]
				numR[i][j] += (numB[i - 1][j - k - 1] % mod) * (numB[i - 1][k] % mod);
				numR[i][j] %= mod;
			}
			for (int k = 1; k < j - 1; k++) {
				numB[i][j] += ((numB[i - 1][j - k - 1] + numR[i][j - k - 1]) % mod) * ((numB[i - 1][k] + numR[i][k]) % mod);
				numB[i][j] %= mod;
			}
		}
	}

	//计算结果
	long long result = 0;
	for (int i = 1; i <= maxH; i++) {
		result += numB[i][nodenum] % mod;
	}
	result = result % mod;

	//释放内存
	for (int i = 0; i < maxH + 1; i++) {
		delete[]numB[i];
		delete[]numR[i];
	}
	delete[]numB;
	delete[]numR;

	//返回结果
	return result;
}