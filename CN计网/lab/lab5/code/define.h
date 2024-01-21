#pragma once
#ifndef DEFINE_H
#define DEFINE_H

//服务器侦听端口
#define SERVER_PORT 2981
//客户端侦听端口
#define CLIENT_PORT 5020
//请求报文参数缓存的大小
#define REQUEST_PARAM_SIZE 256
//指示报文参数缓存的大小
#define INSTRUCTION_TEXT_SIZE 256
//回复报文消息缓存的大小
#define RESPONSE_TEXT_SIZE 256
#define DATA_BUFSIZE 4096

//请求报文的类型
typedef enum
{
    GETTIME, GETNAME, GETCLIENTLIST, SEND, QUIT
} RequestID;

//请求报文，从客户端发往服务器
typedef struct RequestPacket
{
    RequestID requestId;
    int clientID;
    char param[REQUEST_PARAM_SIZE];
} ReqPacket;

//指示报文的类型
typedef enum
{
    MESSAGE
} InstructionID;

//指示报文，从服务器发往客户端
typedef struct InstructionPacket
{
    InstructionID instructionId;
    char text[INSTRUCTION_TEXT_SIZE];
} InsPacket;

//回复报文的类型
typedef enum
{
    OK, ERR
} ResponseID;

//回复报文，从服务器发往客户端
typedef struct ResponsePacket
{
    ResponseID responseId;
    char text[RESPONSE_TEXT_SIZE];
} ResPacket;


#endif
