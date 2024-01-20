#include<iostream>
#include<cmath>
#define mod 1000000007
using namespace std;

long long RBTree(int nodenum);//������������Ϊlong long����N�ϴ�ʱ��int��long���ͻ��������

int main(void) {
	int n;
	cin >> n;
	cout << RBTree(n);
}

long long RBTree(int nodenum) {
	//int maxH = int(floor(log2(double(nodenum + 1))));
	int maxH = floor(log2(nodenum + 1));//����ڲ��ڵ�Ϊnodenumʱ����������߶�
	//����������ά���飬numB[i][j]��ʾ�߶�Ϊi���ڲ��ڵ���Ϊj�ĺڸ�������ĸ�����numR[i][j]��ʾ��ʾ�߶�Ϊi���ڲ��ڵ���Ϊj�ĺ��������ĸ���
	long long** numB = new long long* [maxH + 1];//�洢����Ҳ��Ϊlong long����int��long���ͻ��������
	long long** numR = new long long* [maxH + 1];
	for (int i = 0; i < maxH + 1; i++) {
		numB[i] = new long long[nodenum + 1];
		numR[i] = new long long[nodenum + 1];
	}
	//���鶨����ϣ�������г�ʼ��
	for (int i = 0; i < maxH + 1; i++) {
		for (int j = 0; j < nodenum + 1; j++) {
			numB[i][j] = numR[i][j] = 0;
		}
	}
	//��ʼ�������Ը�Ϊ1��numB��numR����ֵ��
	numB[1][1] = 1; numB[1][2] = 2; numB[1][3] = 1;
	numR[1][1] = 1;
	//������������i��j�������µ��ƹ�ϵʽ��numR[i][j]=SUM(numB[i][j-k-1]*numB[i][k]) (k=1,2,...j-2),
	//numB[i][j]=SUM((numB[i-1][j-k-1]+numR[i][j-k-1])*(numB[i-1][k]+numR[i][k])) (k=1,2,...j-2)
	//���ͣ����ں����������������ӽڵ��Ϊ����ͬ�ߵĺڸ�������������ںڸ���������������ӽڵ��Ϊ�߶ȼ�һ��˫�ڡ�˫�졢һ��һ�졣
	for (int i = 2; i <= maxH; i++) {
		//���ڸ�Ϊi�ĺ���������ڲ��ڵ�������Ϊ2^i-1�����Ϊ2^(2*i)-1���ڸ��������2^(2*i)-1������������2^(2*i-1)-1������ȡ�ϴ�ֵ��
		int min = int(pow(2.0, double(i))) - 1;//�����ڲ��ڵ���
		int max = int(pow(2.0, double(2 * i))) - 1;//����ڲ��ڵ���()
		if (max > nodenum) {//�������ڵ�����������
			max = nodenum;
		}
		for (int j = min; j <= max; j++) {//����min��max������ѭ������
			for (int k = 1; k < j - 1; k++) {//�ȼ���numR[i][j]����ΪnumB[i][j]�ļ�����õ�numR[i][j]
				numR[i][j] += (numB[i - 1][j - k - 1] % mod) * (numB[i - 1][k] % mod);
				numR[i][j] %= mod;
			}
			for (int k = 1; k < j - 1; k++) {
				numB[i][j] += ((numB[i - 1][j - k - 1] + numR[i][j - k - 1]) % mod) * ((numB[i - 1][k] + numR[i][k]) % mod);
				numB[i][j] %= mod;
			}
		}
	}

	//������
	long long result = 0;
	for (int i = 1; i <= maxH; i++) {
		result += numB[i][nodenum] % mod;
	}
	result = result % mod;

	//�ͷ��ڴ�
	for (int i = 0; i < maxH + 1; i++) {
		delete[]numB[i];
		delete[]numR[i];
	}
	delete[]numB;
	delete[]numR;

	//���ؽ��
	return result;
}