#include <iostream>
#include <winsock2.h>
#include "define.h"
#pragma warning(disable:4996)
#pragma comment(lib, "WS2_32")


// #define SERVER_PORT	3379 //�����˿�
using namespace std;

//�����߳�ʱ���ݵ����ݽṹ���ں����������׽��ֺͷ���˵�ַ��Ϣ��
struct threadData {
	SOCKET	tcps;
	sockaddr_in serverAddr;
};

// ȫ�ֱ���
bool isExit = false; // �ж��Ƿ��˳�
bool isConnected = false; // �ж��Ƿ�����
bool isCloseThread = false; // �������̵߳Ĺر�
bool isGetClientList = false; // �Ƿ��Ѿ���ȡ�ͻ����б�
HANDLE hThread; // ȫ�����̱߳������������̵߳ȴ����߳�
SOCKET* sClient; // �����׽���,�����׽���


// ��������
void showMenu();
DWORD WINAPI ThreadFuncOfListen(LPVOID lpParam);
void do_read_rspns(SOCKET fd, ResPacket* ptr);
void do_read_ins(SOCKET fd, InsPacket* ptr);
void do_write_cmd(SOCKET fd, ReqPacket* ptr);
//SOCKET create_data_socket();
HANDLE getConnect(SOCKET* sClient);
void breakConnect(SOCKET* sClient);
void getTime(SOCKET* sClient);
void getMultiTime(SOCKET* sClient);
void getName(SOCKET* sClient);
void getClientList(SOCKET* sClient);
void sendMsg(SOCKET* sClient);
void exitConnect(SOCKET* sClient);
void getTime100Times(SOCKET* sClient);


int main(void) {
	int option; // �����û���ѡ��
	sClient = new SOCKET;
	// struct threadData* pThInfo; // `������Ϣ�̺߳���`Ҫ����Ĳ���

	WORD wVersionRequested;
	WSADATA wsaData;
	int err;

	wVersionRequested = MAKEWORD(2, 2);
	//Winsock��ʼ����
	err = WSAStartup(wVersionRequested, &wsaData);
	if (err != 0)
	{
		printf("[ WinSock initialized failed! ]\n");
		return 0;
	}

	//ȷ��WinSock DLL�İ汾��2.2��
	if (LOBYTE(wsaData.wVersion) != 2 || HIBYTE(wsaData.wVersion) != 2)
	{
		printf("[ WinSock version is not 2.2! ]\n");
		WSACleanup();
		return 0;
	}


	//�������ڿ������ӵ�socket��
	*sClient = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
	if (*sClient == INVALID_SOCKET)
	{
		printf("[ Failed to create socket! ]\n");
		WSACleanup();
		closesocket(*sClient);
		delete sClient;
		exit(1);
	}

	// ѭ�������û����������
	while (1) {
		showMenu();
		Sleep(100);
		cin >> option;
		getchar();
		if (isConnected) {
			switch (option) {
				// ����
			case 1:
				hThread=getConnect(sClient);
				break;
				// �Ͽ�����
			case 2:
				breakConnect(sClient);
				break;
				// ��ȡʱ��
			case 3:
				//getTime(sClient);
				getMultiTime(sClient); // ʵ��Ҫ�������send 100��ʱ������
				break;
				// ��ȡ����
			case 4:
				getName(sClient);
				break;
				// ��ȡ������б�
			case 5:
				getClientList(sClient);
				break;
				// ����Ϣ
			case 6:
				sendMsg(sClient);
				break;
				// �˳�
			case 0:
				exitConnect(sClient);
				break;
			default:
				cout << "��������ȷ�����֣�" << endl;
				break;
			}
		}
		else {
			switch (option) {
				// ����
			case 1:
				hThread=getConnect(sClient);
				break;
				// �˳�
			case 0:
				exitConnect(sClient);
				break;
			default:
				cout << "��������ȷ�����֣�" << endl;
				break;
			}
		}
		
		if (isExit) {
			break;
		}
	}

	//���޵ȴ����������߳����н���
	WaitForSingleObject(hThread, INFINITE);
	cout << "% Project Exit %" << endl;

	WSACleanup();
	delete sClient;

	return 0;
}

// ��ӡ�˵�
void showMenu() {
	if (isConnected) {
		//��ӡ����
		cout << "+----------------------------------------------------------------+" << endl;
		cout << "| ѡ �� |          ��ѡ����������ѡ��0~6�����֣�               |" << endl;
		cout << "+----------------------------------------------------------------+" << endl;
		//��ӡ�˵���������
		cout << "|  [1]  | ���ӣ��������ӵ�ָ����ַ�Ͷ˿ڵķ����                 |" << endl;
		cout << "|  [2]  | �Ͽ����ӣ��Ͽ������˵�����                           |" << endl;
		cout << "|  [3]  | ��ȡʱ��: �������˸�����ǰʱ��                       |" << endl;
		cout << "|  [4]  | ��ȡ���֣��������˸��������������                   |" << endl;
		cout << "|  [5]  | ������б��������˸�����ǰ���ӵ����пͻ�����Ϣ   |" << endl;
		cout << "|  [6]  | ����Ϣ���������˰���Ϣת������Ӧ��ŵĿͻ���         |" << endl;
		cout << "|  [0]  | �˳����Ͽ����Ӳ��˳��ͻ��˳���                         |" << endl;
		cout << "+----------------------------------------------------------------+" << endl;
	}
	else {
		//��ӡ����
		cout << "+----------------------------------------------------------------+" << endl;
		cout << "| ѡ �� |          ��ѡ����������ѡ��0~1�����֣�               |" << endl;
		cout << "+----------------------------------------------------------------+" << endl;
		//��ӡ�˵���������
		cout << "|  [1]  | ���ӣ��������ӵ�ָ����ַ�Ͷ˿ڵķ����                 |" << endl;
		cout << "|  [0]  | �˳����Ͽ����Ӳ��˳��ͻ��˳���                         |" << endl;
		cout << "+----------------------------------------------------------------+" << endl;
	}
	
}


//��ȡ�ظ����ģ�
void do_read_rspns(SOCKET fd, ResPacket* ptr)
{
	int count = 0;
	int size = sizeof(ResPacket);
	while (count < size)
	{
		int nRead = recv(fd, (char*)ptr + count, size - count, 0);
		if (nRead <= 0)
		{
			printf("[ Read Response Error! ]");
			closesocket(fd);
			WSACleanup();
			exit(1);
		}
		count += nRead;
	}
}

//��ȡָʾ���� ���޸ĺ�İ汾��ʱ�ò�����
void do_read_ins(SOCKET fd, InsPacket* ptr)
{
	int count = 0;
	int size = sizeof(InsPacket);
	while (count < size)
	{
		int nRead = recv(fd, (char*)ptr + count, size - count, 0);
		if (nRead <= 0)
		{
			printf("[ Read Instruction Error! ]");
			closesocket(fd);
			WSACleanup();
			exit(1);
		}
		count += nRead;
	}
}

//���������
void do_write_cmd(SOCKET fd, ReqPacket* ptr)
{
	int size = sizeof(ReqPacket);

	int flag = send(fd, (char*)ptr, size, 0);

	if (flag == SOCKET_ERROR)
	{
		printf("[ Send Request Error! ]");
		closesocket(fd);
		WSACleanup();
		exit(1);
	}
}

////�������������׽��ֲ���������״̬��
//SOCKET create_data_socket()
//{
//	SOCKET sockfd;
//	struct sockaddr_in my_addr;
//
//	// ���������������ӵ��׽��֣�
//	if ((sockfd = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP)) == INVALID_SOCKET)
//	{
//		printf("[ Socket Error in `create_data_socket`! ]");
//		closesocket(sockfd);
//		WSACleanup();
//		exit(1);
//	}
//
//	my_addr.sin_family = AF_INET;
//	my_addr.sin_port = htons(CLIENT_PORT);
//	my_addr.sin_addr.s_addr = htonl(INADDR_ANY);
//	memset(&(my_addr.sin_zero), 0, sizeof(my_addr.sin_zero));
//
//	// �󶨣�
//	if (bind(sockfd, (struct sockaddr*)&my_addr, sizeof(struct sockaddr)) == SOCKET_ERROR)
//	{
//		int err = WSAGetLastError();
//		printf("[ Bind Error %d in `create_data_socket`! ]\n", err);
//		closesocket(sockfd);
//		WSACleanup();
//		exit(1);
//	}
//
//	// ����������������
//	if (listen(sockfd, 1) == SOCKET_ERROR)
//	{
//		printf("[ Listen Error in `create_data_socket`! ]");
//		closesocket(sockfd);
//		WSACleanup();
//		exit(1);
//	}
//
//	return sockfd;
//}

// ������Ϣ���߳�
DWORD WINAPI ThreadFuncOfListen(LPVOID lpParam) {
	// �����׽���
	SOCKET sListen; 
	sockaddr_in serverAddr;
	int nRead;
	int count = 0;
	int number = 0;
	int size = sizeof(ResPacket);
	ResPacket result;

	sListen = ((threadData*)lpParam)->tcps;
	serverAddr = ((threadData*)lpParam)->serverAddr;
	
	//ÿ�ζ����������ݾ���ʾ���٣�ֱ���������ӶϿ��������߳�֪ͨ�ر�
	while (!isCloseThread)
	{
		number++;
		nRead = recv(sListen, (char *)(&result)+count, size - count, 0);

		if (nRead == SOCKET_ERROR)
		{
			printf("[ Read response error in thread function! ]\n");
			closesocket(sListen);
			WSACleanup();
			delete sClient;
			exit(1);
		}

		if (nRead == 0) //���ݶ�ȡ����
			break;

		count += nRead;
		if (count == size) {
			cout << result.text << " x " << number <<endl;
			count = 0;
		}
		Sleep(100);
	}
	
	delete lpParam;

	return 0;
}

// ����
HANDLE getConnect(SOCKET* sClient) {
	// struct hostent* he;
	char ip[40];
	struct sockaddr_in serverAddr; // �������ĵ�ַ��Ϣ
	struct threadData* pThInfo; // �������߳�Ҫ����Ĳ���
	cout << "���������˵�IP��ַ��" << endl;
	cin >> ip;
	/*if ((he = gethostbyname(ip)) == NULL)
	{
		printf("[ Gethostbyname failed! ]");
		closesocket(*sClient);
		WSACleanup();
		exit(1);
	}*/

	serverAddr.sin_family = AF_INET;
	serverAddr.sin_port = htons(SERVER_PORT);
	serverAddr.sin_addr.s_addr = inet_addr(ip);
	memset(&(serverAddr.sin_zero), 0, sizeof(serverAddr.sin_zero));

	// ���ӷ�������
	if (connect(*sClient, (struct sockaddr*)&serverAddr, sizeof(struct sockaddr)) == SOCKET_ERROR)
	{
		printf("[ Connect error! ]");
		closesocket(*sClient);
		WSACleanup();
		delete sClient;
		exit(1);
	}

	// ��������״̬Ϊ������
	isConnected = true;
	// �����̱߳��ּ���״̬
	isCloseThread = false;

	pThInfo = NULL;
	pThInfo = new threadData;
	if (pThInfo == NULL)
	{
		printf("[ malloc space failed! ]\n");
		closesocket(*sClient);
		WSACleanup();
		delete sClient;
		exit(1);
	}
	//����һ���߳������������Ϣ������
	DWORD dwThreadIdOfListener;
	HANDLE listenThread;
	int len = sizeof(struct threadData);
	//�ȴ����ܿͻ��˿�����������
	pThInfo->tcps = *sClient;
	pThInfo->serverAddr = serverAddr;

	listenThread = CreateThread(
		NULL,                        // no security attributes 
		0,                           // use default stack size  
		ThreadFuncOfListen,          // thread function 
		pThInfo,					 // argument to thread function 
		0,                           // use default creation flags 
		&dwThreadIdOfListener);      // returns the thread identifier 
	// Check the return value for success. 
	if (listenThread == NULL)
	{
		printf("CreateListenThread failed.\n");
		delete pThInfo;
		closesocket(*sClient);
		WSACleanup();
		delete sClient;
		exit(1);
	}

	// ��������˱�ķ���ˣ���Ҫ��ֵȫ�ֱ���isGetClientList
	isGetClientList = false;

	return listenThread;
}

// �Ͽ�����
void breakConnect(SOCKET* sClient) {
	ReqPacket req_packet;
	//��������Ĳ���������������
	req_packet.requestId = QUIT;
	req_packet.clientID = 0; //������ЧID����û�в���
	do_write_cmd(*sClient, &req_packet);

	isConnected = false;
	Sleep(2500);
	closesocket(*sClient);
	isCloseThread = true;
	cout << "���ѶϿ����ӡ���" << endl << endl;

}

// ��ȡʱ��
void getTime(SOCKET* sClient) {
	ReqPacket req_packet;

	//��������Ĳ���������������
	req_packet.requestId = GETTIME;
	req_packet.clientID = 0; //������ЧID����û�в���
	do_write_cmd(*sClient, &req_packet);
	cout << "[ �ѷ��ͻ�ȡʱ������]" << endl << endl;
}

// һ��������send����ʵ��Ҫ��棩
void getMultiTime(SOCKET* sClient) {
	for (int i = 0; i < 100; i++) {
		ReqPacket req_packet;

		//��������Ĳ���������������
		req_packet.requestId = GETTIME;
		req_packet.clientID = 0; //������ЧID����û�в���
		do_write_cmd(*sClient, &req_packet);
		cout << "[ �ѷ��ͻ�ȡʱ������]" << " x" << i << endl << endl;
	}
}

// ��ȡ����
void getName(SOCKET* sClient) {
	ReqPacket req_packet;

	//��������Ĳ���������������
	req_packet.requestId = GETNAME;
	req_packet.clientID = 0; //������ЧID����û�в���
	do_write_cmd(*sClient, &req_packet);
	cout << "[ �ѷ��ͻ�ȡ��������]" << endl << endl;
}

// ��ȡ�ͻ����б�
void getClientList(SOCKET* sClient) {
	ReqPacket req_packet;

	//��������Ĳ���������������
	req_packet.requestId = GETCLIENTLIST;
	req_packet.clientID = 0; //������ЧID����û�в���
	do_write_cmd(*sClient, &req_packet);
	cout << "[ �ѷ��ͻ�ȡ�ͻ����б�����]" << endl << endl;
	isGetClientList = true;
	// TODO:�д��Ľ�����õȵ����ܳɹ��������ã�
	isGetClientList = true;
}

// ������Ϣ
void sendMsg(SOCKET* sClient) {
	ReqPacket req_packet;
	int clientID = 0;
	char message[REQUEST_PARAM_SIZE];

	if (!isGetClientList) {
		cout << "���Ȼ�ȡ�ͻ����б���Ϣ��" << endl << endl;
	}
	else {
		cout << "��������Ҫ������Ϣ�Ŀͻ����б��ţ�";
		cin >> clientID;
		cout << "��������Ҫ���͵���Ϣ��";
		cin >> message;
		//��������Ĳ���������������
		req_packet.requestId = SEND;
		req_packet.clientID = clientID;
		strcpy_s(req_packet.param, message);

		do_write_cmd(*sClient, &req_packet);
		cout << "[ ��Ϣ���ͳɹ���]" << endl << endl;
	}
	
}

//�˳�
void exitConnect(SOCKET* sClient) {
	if (!isConnected) {
		isExit = true;
		cout << "�˳��ɹ���" << endl << endl;
	}
	else {
		breakConnect(sClient);
		isExit = true;
		cout << "�˳��ɹ���" << endl << endl;
	}
	
}
