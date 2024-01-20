#define _CRT_SECURE_NO_WARNINGS
#include<iostream>
#include <string>
#include<cstdio>
using namespace std;

void add(string str1, string str2);

void sub(string str1, string str2);

void mul(string str1, string str2);

int div_sub(char* op1,const char* op2);

void div(string str1, string str2);

string DH_sub(string str);//用于DH算法的循环判断

string DH_mul(string str1, string str2);

string DH_mod(string str1, string str2);

void DH(string str3, string str4, string str5, string str6);

int main(void) {
	string str1, str2,str3,str4,str5,str6;
	cout << "INPUT1:" << endl;
	cout << "a:"; cin >> str1;
	cout << "b:"; cin >> str2;
	cout << endl;
	cout << "OUPUT1:" << endl;
	cout << "a+b:"; add(str1, str2);
	cout << "a-b:"; sub(str1, str2);
	cout << "a*b:"; mul(str1, str2);
	div(str1, str2);
	cout << endl;
	cout << "INPUT2:" << endl;
	cout << "p:"; cin >> str3;//str3:p
	cout << "g:"; cin >> str4;//str4:g
	cout << "A’s private key (a):"; cin >> str5;//str5:a
	cout << "B’s private key (b):"; cin >> str6;//str6:b
	cout << endl;
	cout << "OUTPUT2:" << endl;
	DH(str3, str4, str5, str6);

}

void add(string str1, string str2) {
	int i, temp,k=0;//K:存储进位信息
	const char* char1 = str1.c_str();
	const char* char2 = str2.c_str();
	if (str1.length() <= str2.length()) {
		char* result = new char[str2.length() + 2];
		for (i = 0; i < str1.length();i++) {
			temp = (char1[str1.length() - 1 - i] - '0') + (char2[str2.length() - 1 - i] - '0') + k;
			if (temp >= 10) {
				k = temp / 10;
				temp = temp % 10;
				
			}
			else {
				k = 0;
			}
			result[i] = temp + '0';//倒序存储
		}
		for (i = str1.length(); i < str2.length(); i++) {
			temp= (char2[str2.length() - 1 - i] - '0') + k;
			if (temp >= 10) {
				k = temp / 10;
				temp = temp % 10;
				
			}
			else {
				k = 0;
			}
			result[i] = temp + '0';//倒序存储
		}
		if (k > 0) {
			result[i++] = k + '0';
		}
		result[i] = '\0';
		//倒序输出
		for (i = strlen(result)-1; i >= 0; i--) {
			printf("%c", result[i]);
		}
		cout << endl;
		delete[]result;
	}
	else {
		char* result = new char[str1.length() + 2];
		for (i = 0; i < str2.length(); i++) {
			temp = (char2[str2.length() - 1 - i] - '0') + (char1[str1.length() - 1 - i] - '0') + k;
			if (temp >= 10) {
				k = temp / 10;
				temp = temp % 10;
				
			}
			else {
				k = 0;
			}
			result[i] = temp + '0';//倒序存储
		}
		for (i = str2.length(); i < str1.length(); i++) {
			temp = char1[str1.length() - 1 - i] - '0' + k;
			if (temp >= 10) {
				k = temp / 10;
				temp = temp % 10;
				
			}
			else {
				k = 0;
			}
			result[i] = temp + '0';//倒序存储
		}
		if (k > 0) {
			result[i++] = k + '0';
		}
		result[i] = '\0';
		//倒序输出
		for (i = strlen(result) - 1; i >= 0; i--) {
			printf("%c", result[i]);
		}
		cout << endl;
		delete[]result;
	}
	
}

void sub(string str1, string str2) {
	int i, temp, k = 0,flag=0;//K:存储借位信息,flag:用于标记是否找到第一个不为0的最高位
	const char* char1 = str1.c_str();
	const char* char2 = str2.c_str();
	if (str1.length() < str2.length()||(str1.length() == str2.length() && str1 < str2)) {
		char* result = new char[str2.length()+1];
		for (i = 0; i < str1.length(); i++) {
			temp = (char2[str2.length() - 1 - i] - '0') - (char1[str1.length() - 1 - i] - '0') + k;
			if (temp < 0) {
				k = -1;
				temp += 10;
			}
			else {
				k = 0;
			}
			result[i] = temp + '0';//倒序存储
		}
		for (i = str1.length(); i < str2.length(); i++) {
			temp= (char2[str2.length() - 1 - i] - '0') + k;
			if (temp < 0) {
				k = -1;
				temp += 10;
			}
			else {
				k = 0;
			}
			result[i] = temp + '0';//倒序存储
		}
		result[i] = '\0';
		cout << '-';
		//倒序输出
		for (i = strlen(result) - 1; i >= 0; i--) {
			if (result[i] != '0' && flag == 0) {
				flag = 1;
			}
			if (flag == 0) {
				continue;
			}
			printf("%c", result[i]);
		}
		if (flag == 0) {
			cout << "0";
		}
		cout << endl;
		delete[]result;
	}
	else if (str1 == str2) {
		cout << "0" << endl;
	}
	else {
		char* result = new char[str1.length() + 1];
		for (i = 0; i < str2.length(); i++) {
			temp = (char1[str1.length() - 1 - i] - '0') - (char2[str2.length() - 1 - i] - '0') + k;
			if (temp < 0) {
				k = -1;
				temp += 10;
			}
			else {
				k = 0;
			}
			result[i] = temp + '0';//倒序存储
		}
		for (i = str2.length(); i < str1.length(); i++) {
			temp = (char1[str1.length() - 1 - i] - '0') + k;
			if (temp < 0) {
				k = -1;
				temp += 10;
			}
			else {
				k = 0;
			}
			result[i] = temp + '0';//倒序存储
		}
		result[i] = '\0';
		//倒序输出
		for (i = strlen(result) - 1; i >= 0; i--) {
			if (result[i] != '0' && flag == 0) {
				flag = 1;
			}

			if (flag == 0) {
				continue;
			}
			printf("%c", result[i]);
		}
		cout << endl;
		delete[]result;
	}
}

void mul(string str1, string str2) {
	char* result = new char[str1.length() + str2.length()+1];//a位数乘以b位数最多（a+b）位
	const char* char1 = str1.c_str();
	const char* char2 = str2.c_str();
	int i,j, temp, k = 0;//k:存储进位信息
	if (str1 == "0") {
		cout << "0" << endl;
		return;
	}
	for (i = 0; i < str1.length() + str2.length(); i++) {
		result[i] = '0';
	}
	result[i] = '\0';
	for (i = 0; i < str2.length(); i++) {
		k = 0;
		for (j = 0; j < str1.length(); j++) {
			temp = (char2[str2.length()-1-i] - '0') * (char1[str1.length()-1-j] - '0') + result[j + i] - '0'+k;
			if (temp >= 10) {
				k = temp / 10;
				temp = temp % 10;
			}
			else {
				k = 0;
			}
			result[j + i] = temp + '0';//倒序存储
		}
		if (k > 0) {
			result[j + i] = k + '0';//倒序存储
		}
	}
	int index;
	if (result[strlen(result)-1] == '0') {
		index = strlen(result) - 1;
	}
	else {
		index = strlen(result);
	}
	for (i = index - 1; i >= 0; i--) {
		printf("%c", result[i]);
	}
	cout << endl;
	delete[]result;
}

int div_sub(char *op1, const char *op2) {//返回两数相除的商
	string str1 = op1;
	string str2 = op2;
	char* t1 = new char[str1.length()+1];
	char* t2 = new char[str2.length()+1];
	strcpy(t1, op1);
	strcpy(t2, op2);
	int i,temp=0,result=0,k=0;//temp:存储对位相减的差  result:存储结果  k:存储借位信息
	if (str1.length() == str2.length() && str1 < str2) {
		delete[]t1;
		delete[]t2;
		return 0;
	}
	else if (str1 == str2) {
		delete[]t1;
		delete[]t2;
		return 1;
	}
	else {
		while (strlen(t1) > strlen(t2)||(strlen(t1) == strlen(t2) && strcmp(t1, t2) >= 0)) {
			for (i = 0; i < strlen(t2) ; i++) {
				temp = t1[strlen(t1) - 1 - i] - t2[strlen(t2) - 1 - i] + k;
				if (temp < 0) {
					k = -1;
					temp += 10;
				}
				else {
					k = 0;
				}
				t1[strlen(t1) - 1 - i] = temp + '0';
			}
			if (strlen(t1) > strlen(t2) && k == -1) {
				t1[0] = t1[0] - 1;
				k = 0;
			}
			if (strlen(t1) > strlen(t2) && t1[0] == '0') {
				for (i = 0; i < strlen(t1) - 1; i++) {
					t1[i] = t1[i + 1];
				}
				t1[i] = '\0';
			}
			result++;
		}
		delete[]t1;
		delete[]t2;
		return result;
	}
}

void div(string str1, string str2) {
	if (str1.length() < str2.length()) {//被除数小于除数
		cout << "a/b:0" << endl;
		cout << "a%b:" << str1 << endl;
	}
	else if (str1 == str2) {//两数相等
		cout << "a/b:1" << endl;
		cout << "a%b:0" << endl;
	}
	else if (str1.length() == str2.length() && str1 < str2) {//被除数小于除数
		cout << "a/b:0" << endl;
		cout << "a%b:" << str1 << endl;
	}
	else {
		char* result1 = new char[str1.length()- str2.length()+3];//存储商
		char* result2 = new char[str2.length()+2];//存储余数
		const char* char3 = str1.c_str();//为了赋值给char1
		const char* char2 = str2.c_str();//存储除数
		char* char1 = new char[strlen(char3)+1];
		strcpy(char1, char3);//char1:存储被除数
		char* t1 = new char[str2.length() + 3];//用来存储临时的被除数
		int i, j,temp,num,index;//num:存储返回的商,index:记录被除数第一个不为0的位数

		//商部分
		for (i = 0; i < str1.length() - str2.length() + 1; i++) {
			temp = 0; index = 0;
			while (char1[index] == '0' && index < i) {
				index++;
			}
			for (j = 0; j < str2.length(); j++) {
				t1[j] = char1[index+j];
			}
			t1[j] = '\0';
			if (t1[0] == '0') {
				num = 0;
				result1[i] = '0';
				continue;
			}
			num = div_sub(t1, char2);
			if (num == 0) {
				if (index + j < strlen(char1)) {
					t1[j] = char1[index + j];
					t1[j + 1] = '\0';
					num = div_sub(t1, char2);
				}
				else {
					result1[i] = '\0';
					continue;
				}
				
			}

			int x,k = 0;//k:存储借位信息
			for (j = 0; j < num; j++) {
				k = 0;
				for (x = 0; x < strlen(char2); x++) {
					temp = t1[strlen(t1) - 1 - x] - char2[strlen(char2) - 1 - x] + k;
					if (temp < 0) {
						temp += 10;
						k = -1;
					}
					else {
						k = 0;
					}
					t1[strlen(t1) - 1 - x] = temp + '0';
				}
				if (k == -1) {
					t1[strlen(t1) - 1 - x] = t1[strlen(t1) - 1 - x] - 1;
					k = 0;
				}
			}
			for (j = 0; j < strlen(t1); j++) {
				char1[index + j] = t1[j];
			}

			result1[i] = num + '0';
		}
		result1[i] = '\0';
		while (result1[0] == '0') {
			for (i = 0; i < strlen(result1) - 1; i++) {
				result1[i] = result1[i + 1];
			}
			result1[i] = '\0';
		}
		cout << "a/b:" << result1 << endl;

		//余数部分
		int flag = 0;//插入标记
		int k=0;//余数字符数组的索引
		for (i = 0; i < strlen(char1); i++) {
			if (flag == 0 && char1[i] != '0') {
				flag = 1;
				result2[k++] = char1[i];
			}
			else if (flag == 0) {
				continue;
			}
			else {
				result2[k++] = char1[i];
			}
		}
		result2[k] = '\0';
		if (flag == 0) {
			cout << "a%b:0" << endl;
		}
		else {
			cout << "a%b:" << result2 << endl;
		}

		delete[]result1;
		delete[]result2;
		delete[]char1;
		delete[]t1;
	}
}

string DH_sub(string str) {
	const char* char1 = str.c_str();//为了赋值给result
	char* result = new char[str.length() + 2];
	int i,j,temp,k=-1,index=0;//index用来存储返回字符串第一个不为0的位置索引
	for (i = 0; i < str.length(); i++) {
		temp = (char1[str.length() - 1 - i] - '0') + k;
		if (temp < 0) {
			k = -1;
			temp += 10;
		}
		else {
			k = 0;
		}
		result[i] = temp + '0';//倒序存储
	}
	result[i] = '\0';

	char* result1 = new char[strlen(result) + 1];//存储返回的字符串结果
	for (i = 0; i < strlen(result); i++) {
		result1[i] = result[strlen(result) - 1 - i];
	}
	result1[i] = '\0';
	i = 0;
	while (result1[i] == '0' && i < strlen(result1)) {
		i++;
	}
	if (i == strlen(result1)) {
		return "0";
	}
	else {
		index = i;
	}
	j = 0;
	for (i = index; i < strlen(result1); i++) {
		result1[j++] = result1[i];
	}
	result1[j] = '\0';
	string out = result1;
	return out;

	delete[] result;
	delete[] result1;
}

string DH_mul(string str1, string str2) {
	char* result = new char[str1.length() + str2.length() + 1];//a位数乘以b位数最多（a+b）位
	const char* char1 = str1.c_str();
	const char* char2 = str2.c_str();
	int i, j, temp, k = 0;//k:存储进位信息
	if (str1 == "0") {
		return "0";
	}
	for (i = 0; i < str1.length() + str2.length(); i++) {
		result[i] = '0';
	}
	result[i] = '\0';
	for (i = 0; i < str2.length(); i++) {
		k = 0;
		for (j = 0; j < str1.length(); j++) {
			temp = (char2[str2.length() - 1 - i] - '0') * (char1[str1.length() - 1 - j] - '0') + result[j + i] - '0' + k;
			if (temp >= 10) {
				k = temp / 10;
				temp = temp % 10;
			}
			else {
				k = 0;
			}
			result[j + i] = temp + '0';//倒序存储
		}
		if (k > 0) {
			result[j + i] = k + '0';//倒序存储
		}
	}
	int index;
	if (result[strlen(result) - 1] == '0') {
		index = strlen(result) - 1;
	}
	else {
		index = strlen(result);
	}
	char* result1 = new char[index+1];//存储输出结果
	for (i = 0; i < index; i++) {
		result1[i] = result[index - 1 - i];
	}
	result1[i] = '\0';
	return result1;

	delete[] result;
	delete[] result1;
}

string DH_mod(string str1, string str2) {
	if (str1.length() < str2.length()) {//被除数小于除数
		return str1;
	}
	else if (str1 == str2) {//两数相等
		return "1";
	}
	else if (str1.length() == str2.length() && str1 < str2) {//被除数小于除数
		return str1;
	}
	else {//商部分不用管，懒得删了
		char* result1 = new char[str1.length() - str2.length() + 3];//存储商
		char* result2 = new char[str2.length() + 2];//存储余数
		const char* char3 = str1.c_str();//为了赋值给char1
		const char* char2 = str2.c_str();//存储除数
		char* char1 = new char[strlen(char3) + 1];
		strcpy(char1, char3);//char1:存储被除数
		char* t1 = new char[str2.length() + 3];//用来存储临时的被除数
		int i, j, temp, num, index;//num:存储返回的商,index:记录被除数第一个不为0的位数

		//商部分
		for (i = 0; i < str1.length() - str2.length() + 1; i++) {
			temp = 0; index = 0;
			while (char1[index] == '0' && index < i) {
				index++;
			}
			for (j = 0; j < str2.length(); j++) {
				t1[j] = char1[index + j];
			}
			t1[j] = '\0';
			if (t1[0] == '0') {
				num = 0;
				result1[i] = '0';
				continue;
			}
			num = div_sub(t1, char2);
			if (num == 0) {
				if (index + j < strlen(char1)) {
					t1[j] = char1[index + j];
					t1[j + 1] = '\0';
					num = div_sub(t1, char2);
				}
				else {
					result1[i] = '\0';
					continue;
				}

			}

			int x, k = 0;//k:存储借位信息
			for (j = 0; j < num; j++) {
				k = 0;
				for (x = 0; x < strlen(char2); x++) {
					temp = t1[strlen(t1) - 1 - x] - char2[strlen(char2) - 1 - x] + k;
					if (temp < 0) {
						temp += 10;
						k = -1;
					}
					else {
						k = 0;
					}
					t1[strlen(t1) - 1 - x] = temp + '0';
				}
				if (k == -1) {
					t1[strlen(t1) - 1 - x] = t1[strlen(t1) - 1 - x] - 1;
					k = 0;
				}
			}
			for (j = 0; j < strlen(t1); j++) {
				char1[index + j] = t1[j];
			}

			result1[i] = num + '0';
		}
		result1[i] = '\0';
		while (result1[0] == '0') {
			for (i = 0; i < strlen(result1) - 1; i++) {
				result1[i] = result1[i + 1];
			}
			result1[i] = '\0';
		}

		//余数部分
		int flag = 0;//插入标记
		int k = 0;//余数字符数组的索引
		for (i = 0; i < strlen(char1); i++) {
			if (flag == 0 && char1[i] != '0') {
				flag = 1;
				result2[k++] = char1[i];
			}
			else if (flag == 0) {
				continue;
			}
			else {
				result2[k++] = char1[i];
			}
		}
		result2[k] = '\0';
		if (flag == 0) {
			return "0";
		}
		else {
			string out;
			out = result2;
			return out;
		}

		delete[]result1;
		delete[]result2;
		delete[]char1;
		delete[]t1;
	}
}

void DH(string str3, string str4, string str5, string str6) {
	string A, B, K;
	string p = str3;
	string g = str4;
	string a = str5;
	string b = str6;

	//计算A
	if (a == "0") {
		A = "1";
		cout << "A’s public key:" << A << endl;
	}
	else {
		string num1 = a;
		string t1 = "1";//保存余数
		while (num1 != "0") {
			t1 = DH_mul(t1, g);//t1=t1*g
			t1 = DH_mod(t1, p);//t1=t1%p
			num1 = DH_sub(num1);//a--
		}
		A = t1;
		cout << "A’s public key:" << A << endl;
	}
	

	//计算B
	if (b == "0") {
		B = "1";
		cout << "B’s public key:" << B << endl;
	}
	else {
		string num2 = b;
		string t2 = "1";//保存余数
		while (num2 != "0") {
			t2 = DH_mul(t2, g);//t2=t2*g
			t2 = DH_mod(t2, p);//t2=t2%p
			num2 = DH_sub(num2);//b--
		}
		B = t2;
		cout << "B’s public key:" << B << endl;
	}
	

	//计算K
	if (a == "0" || b == "0") {
		K = "1";
		cout << "Session key K:" << K << endl;
	}
	else {
		string num3 = a;
		string t3 = "1";//保存余数
		while (num3 != "0") {
			t3 = DH_mul(t3, B);//t3=t3*g
			t3 = DH_mod(t3, p);//t3=t3%p
			num3 = DH_sub(num3);//a--
		}
		K = t3;
		cout << "Session key K:" << K << endl;
	}
	
}
