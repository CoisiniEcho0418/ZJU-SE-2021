#pragma once
#ifndef DEFINE_H
#define DEFINE_H

//�����������˿�
#define SERVER_PORT 2981
//�ͻ��������˿�
#define CLIENT_PORT 5020
//�����Ĳ�������Ĵ�С
#define REQUEST_PARAM_SIZE 256
//ָʾ���Ĳ�������Ĵ�С
#define INSTRUCTION_TEXT_SIZE 256
//�ظ�������Ϣ����Ĵ�С
#define RESPONSE_TEXT_SIZE 256
#define DATA_BUFSIZE 4096

//�����ĵ�����
typedef enum
{
    GETTIME, GETNAME, GETCLIENTLIST, SEND, QUIT
} RequestID;

//�����ģ��ӿͻ��˷���������
typedef struct RequestPacket
{
    RequestID requestId;
    int clientID;
    char param[REQUEST_PARAM_SIZE];
} ReqPacket;

//ָʾ���ĵ�����
typedef enum
{
    MESSAGE
} InstructionID;

//ָʾ���ģ��ӷ����������ͻ���
typedef struct InstructionPacket
{
    InstructionID instructionId;
    char text[INSTRUCTION_TEXT_SIZE];
} InsPacket;

//�ظ����ĵ�����
typedef enum
{
    OK, ERR
} ResponseID;

//�ظ����ģ��ӷ����������ͻ���
typedef struct ResponsePacket
{
    ResponseID responseId;
    char text[RESPONSE_TEXT_SIZE];
} ResPacket;


#endif
