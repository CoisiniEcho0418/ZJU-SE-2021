#define _CRT_SECURE_NO_WARNINGS //vs�����±��붨��ú�,���򱨴�
#include<iostream>
#include<string>
#define LINE_MAX 0xFF

using namespace std;

int main(void) {
	/*
	FILE* file = fopen("C:/Users/11/Desktop/�Ű�/HW1/Caesar cipher/����.txt", "r"); //��ֻ����ʽ��
	if (file == NULL) {  //��ʧ��ֱ�ӷ���
		cout << "error" << endl;
		return -1;
	}
	char str[0xFF];
	*/
	
	/*
	* //�������ı�����str�ַ�����
	int k = 0;
	char c = fgetc(file); 
	while (c != '-') {
		cout << c;
		str[k++] = c;
		c = fgetc(file);
	}
	cout << endl;
	str[k] = '\0';
	*/
	
	/*
	int len = 0;
	fgets(str, LINE_MAX, file);
	len = strlen(str);
	if (str[len - 1]=='\n') {
		str[len - 1] = '\0';
		len--;
	}
	if (str[len - 1] == '\r') {
		str[len - 1] = '\0';
		len--;
	}
	cout << str << endl;
	*/

	char str[] = "MALTIRRUEZFCRMALRKZYIOLEXMALOIYUAERICFMALACWALRMDYEUPLFWLCRMEDYEUMAIMULIZLRKZZEKYFLFGHOHRMLZH";
	int len = strlen(str);

	cout << endl;
	cout << "**************************����ing**************************" << endl;
	cout << endl;
	
	for (int i = 1; i <= 25; i++) {
		int j = 0;
		char str1[0xFF] = { '\0' };
		while (str[j] != '\0') {
			str1[j] = (str[j] - 'A' + i) % 26 + 'A';
			cout << str1[j] ;
			j++;
		}
		cout << endl;
		
	}
	//fclose(file);

	cout <<endl<<"���ģ�"<<endl;
	int j = 0;
	char str1[0xFF] = { '\0' };
	while (str[j] != '\0') {
		str1[j] = (str[j] - 'A' + 10) % 26 + 'A';
		cout << str1[j];
		j++;
	}
	
	cout << endl;
	char buf[LINE_MAX] = { 0 };
	cin >> buf;
	int len2 = strlen(buf);
	if (buf[len - 1] == '\n') {
		buf[len - 1] = '\0';
		len--;
	}
	if (buf[len - 1] == '\r') {
		buf[len - 1] == '\0';
		len--;
	}
	cout << buf << endl;
	j = 0;
	char buf1[LINE_MAX] = { 0 };
	while (buf[j] != '\0') {
		buf1[j] = (buf[j] - 'a' +16) % 26 + 'a';
		cout << buf1[j];
		j++;
	}
}