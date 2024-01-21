#include <iostream>
#include <winsock2.h>
#include "define.h"
#pragma warning(disable:4996)
#pragma comment(lib, "WS2_32")


// #define SERVER_PORT	3379 //侦听端口
using namespace std;

//创建线程时传递的数据结构，内含控制连接套接字和服务端地址信息：
struct threadData {
	SOCKET	tcps;
	sockaddr_in serverAddr;
};

// 全局变量
bool isExit = false; // 判断是否退出
bool isConnected = false; // 判断是否连接
bool isCloseThread = false; // 控制子线程的关闭
bool isGetClientList = false; // 是否已经获取客户端列表
HANDLE hThread; // 全局子线程变量，用于主线程等待子线程
SOCKET* sClient; // 连接套接字,监听套接字


// 函数声明
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
	int option; // 接收用户的选择
	sClient = new SOCKET;
	// struct threadData* pThInfo; // `接受消息线程函数`要传入的参数

	WORD wVersionRequested;
	WSADATA wsaData;
	int err;

	wVersionRequested = MAKEWORD(2, 2);
	//Winsock初始化：
	err = WSAStartup(wVersionRequested, &wsaData);
	if (err != 0)
	{
		printf("[ WinSock initialized failed! ]\n");
		return 0;
	}

	//确认WinSock DLL的版本是2.2：
	if (LOBYTE(wsaData.wVersion) != 2 || HIBYTE(wsaData.wVersion) != 2)
	{
		printf("[ WinSock version is not 2.2! ]\n");
		WSACleanup();
		return 0;
	}


	//创建用于控制连接的socket：
	*sClient = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
	if (*sClient == INVALID_SOCKET)
	{
		printf("[ Failed to create socket! ]\n");
		WSACleanup();
		closesocket(*sClient);
		delete sClient;
		exit(1);
	}

	// 循环读入用户输入的请求
	while (1) {
		showMenu();
		Sleep(100);
		cin >> option;
		getchar();
		if (isConnected) {
			switch (option) {
				// 连接
			case 1:
				hThread=getConnect(sClient);
				break;
				// 断开连接
			case 2:
				breakConnect(sClient);
				break;
				// 获取时间
			case 3:
				//getTime(sClient);
				getMultiTime(sClient); // 实验要求的连续send 100次时间请求
				break;
				// 获取名字
			case 4:
				getName(sClient);
				break;
				// 获取活动连接列表
			case 5:
				getClientList(sClient);
				break;
				// 发消息
			case 6:
				sendMsg(sClient);
				break;
				// 退出
			case 0:
				exitConnect(sClient);
				break;
			default:
				cout << "请输入正确的数字！" << endl;
				break;
			}
		}
		else {
			switch (option) {
				// 连接
			case 1:
				hThread=getConnect(sClient);
				break;
				// 退出
			case 0:
				exitConnect(sClient);
				break;
			default:
				cout << "请输入正确的数字！" << endl;
				break;
			}
		}
		
		if (isExit) {
			break;
		}
	}

	//无限等待，除非子线程运行结束
	WaitForSingleObject(hThread, INFINITE);
	cout << "% Project Exit %" << endl;

	WSACleanup();
	delete sClient;

	return 0;
}

// 打印菜单
void showMenu() {
	if (isConnected) {
		//打印标题
		cout << "+----------------------------------------------------------------+" << endl;
		cout << "| 选 项 |          请选择输入您的选择（0~6的数字）               |" << endl;
		cout << "+----------------------------------------------------------------+" << endl;
		//打印菜单主体内容
		cout << "|  [1]  | 连接：请求连接到指定地址和端口的服务端                 |" << endl;
		cout << "|  [2]  | 断开连接：断开与服务端的连接                           |" << endl;
		cout << "|  [3]  | 获取时间: 请求服务端给出当前时间                       |" << endl;
		cout << "|  [4]  | 获取名字：请求服务端给出其机器的名称                   |" << endl;
		cout << "|  [5]  | 活动连接列表：请求服务端给出当前连接的所有客户端信息   |" << endl;
		cout << "|  [6]  | 发消息：请求服务端把消息转发给对应编号的客户端         |" << endl;
		cout << "|  [0]  | 退出：断开连接并退出客户端程序                         |" << endl;
		cout << "+----------------------------------------------------------------+" << endl;
	}
	else {
		//打印标题
		cout << "+----------------------------------------------------------------+" << endl;
		cout << "| 选 项 |          请选择输入您的选择（0~1的数字）               |" << endl;
		cout << "+----------------------------------------------------------------+" << endl;
		//打印菜单主体内容
		cout << "|  [1]  | 连接：请求连接到指定地址和端口的服务端                 |" << endl;
		cout << "|  [0]  | 退出：断开连接并退出客户端程序                         |" << endl;
		cout << "+----------------------------------------------------------------+" << endl;
	}
	
}


//读取回复报文：
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

//读取指示报文 （修改后的版本暂时用不到）
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

//发送命令报文
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

////创建数据连接套接字并进入侦听状态：
//SOCKET create_data_socket()
//{
//	SOCKET sockfd;
//	struct sockaddr_in my_addr;
//
//	// 创建用于数据连接的套接字：
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
//	// 绑定：
//	if (bind(sockfd, (struct sockaddr*)&my_addr, sizeof(struct sockaddr)) == SOCKET_ERROR)
//	{
//		int err = WSAGetLastError();
//		printf("[ Bind Error %d in `create_data_socket`! ]\n", err);
//		closesocket(sockfd);
//		WSACleanup();
//		exit(1);
//	}
//
//	// 侦听数据连接请求：
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

// 接收消息子线程
DWORD WINAPI ThreadFuncOfListen(LPVOID lpParam) {
	// 监听套接字
	SOCKET sListen; 
	sockaddr_in serverAddr;
	int nRead;
	int count = 0;
	int number = 0;
	int size = sizeof(ResPacket);
	ResPacket result;

	sListen = ((threadData*)lpParam)->tcps;
	serverAddr = ((threadData*)lpParam)->serverAddr;
	
	//每次读到多少数据就显示多少，直到数据连接断开或者主线程通知关闭
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

		if (nRead == 0) //数据读取结束
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

// 连接
HANDLE getConnect(SOCKET* sClient) {
	// struct hostent* he;
	char ip[40];
	struct sockaddr_in serverAddr; // 服务器的地址信息
	struct threadData* pThInfo; // 创建子线程要传入的参数
	cout << "请输入服务端的IP地址：" << endl;
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

	// 连接服务器：
	if (connect(*sClient, (struct sockaddr*)&serverAddr, sizeof(struct sockaddr)) == SOCKET_ERROR)
	{
		printf("[ Connect error! ]");
		closesocket(*sClient);
		WSACleanup();
		delete sClient;
		exit(1);
	}

	// 设置连接状态为已连接
	isConnected = true;
	// 让子线程保持监听状态
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
	//创建一个线程来处理接收消息的请求：
	DWORD dwThreadIdOfListener;
	HANDLE listenThread;
	int len = sizeof(struct threadData);
	//等待接受客户端控制连接请求
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

	// 如果连接了别的服务端，需要充值全局变量isGetClientList
	isGetClientList = false;

	return listenThread;
}

// 断开连接
void breakConnect(SOCKET* sClient) {
	ReqPacket req_packet;
	//构建命令报文并发送至服务器：
	req_packet.requestId = QUIT;
	req_packet.clientID = 0; //设置无效ID，且没有参数
	do_write_cmd(*sClient, &req_packet);

	isConnected = false;
	Sleep(2500);
	closesocket(*sClient);
	isCloseThread = true;
	cout << "您已断开连接……" << endl << endl;

}

// 获取时间
void getTime(SOCKET* sClient) {
	ReqPacket req_packet;

	//构建命令报文并发送至服务器：
	req_packet.requestId = GETTIME;
	req_packet.clientID = 0; //设置无效ID，且没有参数
	do_write_cmd(*sClient, &req_packet);
	cout << "[ 已发送获取时间请求！]" << endl << endl;
}

// 一次命令，多次send请求（实验要求版）
void getMultiTime(SOCKET* sClient) {
	for (int i = 0; i < 100; i++) {
		ReqPacket req_packet;

		//构建命令报文并发送至服务器：
		req_packet.requestId = GETTIME;
		req_packet.clientID = 0; //设置无效ID，且没有参数
		do_write_cmd(*sClient, &req_packet);
		cout << "[ 已发送获取时间请求！]" << " x" << i << endl << endl;
	}
}

// 获取名字
void getName(SOCKET* sClient) {
	ReqPacket req_packet;

	//构建命令报文并发送至服务器：
	req_packet.requestId = GETNAME;
	req_packet.clientID = 0; //设置无效ID，且没有参数
	do_write_cmd(*sClient, &req_packet);
	cout << "[ 已发送获取名字请求！]" << endl << endl;
}

// 获取客户端列表
void getClientList(SOCKET* sClient) {
	ReqPacket req_packet;

	//构建命令报文并发送至服务器：
	req_packet.requestId = GETCLIENTLIST;
	req_packet.clientID = 0; //设置无效ID，且没有参数
	do_write_cmd(*sClient, &req_packet);
	cout << "[ 已发送获取客户端列表请求！]" << endl << endl;
	isGetClientList = true;
	// TODO:有待改进（最好等到接受成功再来设置）
	isGetClientList = true;
}

// 发送信息
void sendMsg(SOCKET* sClient) {
	ReqPacket req_packet;
	int clientID = 0;
	char message[REQUEST_PARAM_SIZE];

	if (!isGetClientList) {
		cout << "请先获取客户端列表信息！" << endl << endl;
	}
	else {
		cout << "请输入您要发送信息的客户端列表编号：";
		cin >> clientID;
		cout << "请输入您要发送的信息：";
		cin >> message;
		//构建命令报文并发送至服务器：
		req_packet.requestId = SEND;
		req_packet.clientID = clientID;
		strcpy_s(req_packet.param, message);

		do_write_cmd(*sClient, &req_packet);
		cout << "[ 消息发送成功！]" << endl << endl;
	}
	
}

//退出
void exitConnect(SOCKET* sClient) {
	if (!isConnected) {
		isExit = true;
		cout << "退出成功！" << endl << endl;
	}
	else {
		breakConnect(sClient);
		isExit = true;
		cout << "退出成功！" << endl << endl;
	}
	
}
