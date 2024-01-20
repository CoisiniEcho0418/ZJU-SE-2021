#include<stdio.h>
#include<stdlib.h>
#include<time.h>
#define CLASSMATE_NUM 9

char* name[CLASSMATE_NUM] = {
"黄文杰",
"孙培林",
"张钊铭",
"张圣安",
"王俊怡",
"沈书豪",
"戴伊婷",
"胡朗珅",
"王荣晨" };
int main()
{
    int numbers_now, numbers_needed, id, i, count;
    printf("****************************\n");
    printf("毛概小组分锅抽签器\n\n\n\n");
    printf("请输入本次抽签需要抽出的人数:\n");
    scanf("%d", &numbers_needed);
    if (numbers_needed > CLASSMATE_NUM)
    {
        puts("Not so many classmates!");
        exit(0);
    }
    printf("本次抽签结果为:\n");
    printf("\t人数\t姓名\n");

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
    printf("抽签结束,恭喜以上同学参加活动!!!\n\n\n\n");
    getchar();
    getchar();
    getchar();
    return 0;
}

