#include<stdio.h>
#include<stdlib.h>
#include<time.h>
#define CLASSMATE_NUM 9

char* name[CLASSMATE_NUM] = {
"���Ľ�",
"������",
"������",
"��ʥ��",
"������",
"�����",
"������",
"���ʫ|",
"���ٳ�" };
int main()
{
    int numbers_now, numbers_needed, id, i, count;
    printf("****************************\n");
    printf("ë��С��ֹ���ǩ��\n\n\n\n");
    printf("�����뱾�γ�ǩ��Ҫ���������:\n");
    scanf("%d", &numbers_needed);
    if (numbers_needed > CLASSMATE_NUM)
    {
        puts("Not so many classmates!");
        exit(0);
    }
    printf("���γ�ǩ���Ϊ:\n");
    printf("\t����\t����\n");

    int list[numbers_needed + 1];
    list[0] = 0;
    for (numbers_now = 1; numbers_now <= numbers_needed;)
    {
        srand((int)time(0));
        id = rand() % CLASSMATE_NUM;
        if (id != 0)
        {
            for (i = 0, count = 0; i < numbers_now; i++)
            {
                if (id != list[i])
                    count++;
            }
            if (count == numbers_now)
            {
                list[numbers_now] = id;
                printf("\t%d\t%s\n\n", numbers_now, name[id - 1]);
                numbers_now++;
            }
        }
    }
    printf("��ǩ����,��ϲ����ͬѧ�μӻ!!!\n\n\n\n");
    getchar();
    getchar();
    getchar();
    return 0;
}

