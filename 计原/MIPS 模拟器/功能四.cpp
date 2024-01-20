#include<stdio.h>
#include<string.h>
#include<math.h>
#include<stdlib.h>

void help()
{
	printf("�����Ǹó����ʹ��˵����\n"
	"\n>�������Ķ����Ʊ�ʾ��ԭ��|����|���룩��:\n����һ��ʮ������������ȷ����Χ��[-2^31,2^31-1]֮�У����������������\n" 
	"\n>��32λ�����Ʋ���ת��������\n����32λ��0��1��ɵĶ����Ʋ��룬���Դ��ڿո����������Զ��Թ����������0/1�ַ�����������Ԥ֪�ĺ����\n"
	"\n>�������ȸ�������IEEE754��ʾ����\n����һ�������ȸ�����������������ǵ����ȸ�������������������Ѳ��Զ�ѡ�����������������ȷ����Χ��[-3.4*10^38��3.4*10^38]��,���������������\n"
	"\n>��32λ������ת�����ȸ���������\n����32λ��0��1��ɵĶ����Ʊ��룬���Դ��ڿո����������Զ��Թ����������0/1�ַ�����������Ԥ֪�ĺ����\n"
	"\n>��˫���ȸ�������IEEE754��ʾ����\n����һ��˫���ȸ������������������˫���ȸ�������������������Ѳ��Զ�ѡ�����������������ȷ����Χ��[-1.79*10^308,-1.79*10^308]��,���������������\n"
	"\n>��64λ������ת�����ȸ���������\n����64λ��0��1��ɵĶ����Ʊ��룬���Դ��ڿո����������Զ��Թ����������0/1�ַ�����������Ԥ֪�ĺ����\n"
	);
	printf("\n");
}
//ʮ����������ת������(32λ) 
void IntToBinary(int x,char *res)
{
	int i=0;
	while(x>1)
	{
		res[i++]='0'+x%2;
		x=x/2;
	}
	res[i++]='0'+x;
	for(;i<32;i++)
	{
		res[i]='0';
	}
}

//�������ַ���+1 
void ResAddOne(char *res)
{
	int i=0;
	while(res[i]=='1')
	{
		res[i]='0'; 
		i++;
	}
	res[i]='1';
}
//�������ַ���-1
void ResSubOne(char *res)
{
	int i=31;
	while(res[i]=='0')
	{
		res[i]='1';
		i--;
	}
	res[i]='0';
 } 
 
//�����ı�ʾ(32λ) 
void IntRepresentation()
{
	int i,x;
	char OC[32],RC[32],CC[32];
	printf("\n������һ��ʮ��������[-2^31,2^31-1]��");
	scanf("%d",&x);
	if(x==0)
	{
		for(i=0;i<32;i++)
		{
			OC[i]=RC[i]=CC[i]='0';
		}
	}
	else if(x>0)
	{
		IntToBinary(x,OC);
		memcpy(RC,OC,sizeof(OC));
		memcpy(CC,OC,sizeof(OC));
	}
	else
	{
		IntToBinary(-x,OC);
		memcpy(RC,OC,sizeof(OC));
		OC[31]='1';
		for(i=0;i<32;i++)
		{
			RC[i]=='0'?RC[i]='1':RC[i]='0';
		}
		memcpy(CC,RC,sizeof(RC));
		ResAddOne(CC);
	}
	printf("\n %d ��32λ�����ơ�ԭ�롿Ϊ��",x);
	for(i=31;i>=0;i--)
	{
		if((i+1)%4==0)
		{
			printf(" ");
		 } 
		printf("%c",OC[i]);
	}
	printf("\n %d ��32λ�����ơ����롿Ϊ��",x);
	for(i=31;i>=0;i--)
	{
		if((i+1)%4==0)
		{
			printf(" ");
		 } 
		printf("%c",RC[i]);
	}
	printf("\n %d ��32λ�����ơ����롿Ϊ��",x);
	for(i=31;i>=0;i--)
	{
		if((i+1)%4==0)
		{
			printf(" ");
		 } 
		printf("%c",CC[i]);
	}
	printf("\n\n");
}

//�����Ʋ���ת���� 
void ComplementToInt()
{
	int i,res=0;
	int flag;
	char c,code[32]; 
	printf("\n������32λ�����Ʋ��룺");
	for(i=0;i<32;i++)
	{
		scanf("%c",&c);
		while(c==' '||c=='\n')
		{
			scanf("%c",&c);
		}
		code[i]=c;
	}
	code[0]=='0'?flag=1:flag=-1;
	if(flag==1)
	{
		for(i=31;i>=0;i--)
		{
			res+=(code[i]-'0')*pow(2,31-i);
		}
	}
	else
	{
		char code_cp[32];
		memcpy(code_cp,code,sizeof(code));
		ResSubOne(code_cp);
		for(i=31;i>=0;i--)
		{
			code_cp[i]=='0'?code_cp[i]='1':code_cp[i]='0';
			res+=(code_cp[i]-'0')*pow(2,31-i);
		}
		res=-res;	
	}
	
	printf("\n");
	for(i=0;i<32;i++)
	{
		printf("%c",code[i]);
		if((i+1)%4==0)
		{
			printf(" ");
		}
	}
	printf("��ʾ��ʮ��������Ϊ %d\n\n",res);
 } 
 
//��float��ʾΪ�����ƺ�ʮ������ 
void floatToBinaryAndHex(float num, char* binary, char* hex) {
    int i, j;
    char hex_cp[9];
    int *pInt = (int*)&num;
    sprintf(hex, "%08X", *pInt);
    hex[8]='\0';
    strcpy(hex_cp,hex);
    for(i=0;i<8;i++)
    {
    	for(j=(i+1)*4-1;j>=i*4;j--)
    	{
    		if(hex_cp[i]-'0'>9)
    		{
    			hex_cp[i]=hex_cp[i]-7;
			} 
    		binary[j]=(hex_cp[i]-'0')%2+'0';
    		hex_cp[i]=(hex_cp[i]-'0')/2+'0';
		}
	}
	binary[32]='\0';
}

//��double��ʾΪ�����ƺ�ʮ������ 
void doubleToBinaryAndHex(double num, char* binary, char* hex) {
    int i, j;
    char hex_cp[17];
    long long int *pInt = (long long int*)&num;
    sprintf(hex, "%016llX", *pInt);
    hex[16]='\0';
    strcpy(hex_cp,hex);
    for(i=0;i<16;i++)
    {
    	for(j=(i+1)*4-1;j>=i*4;j--)
    	{
    		if(hex_cp[i]-'0'>9)
    		{
    			hex_cp[i]=hex_cp[i]-7;
			} 
    		binary[j]=(hex_cp[i]-'0')%2+'0';
    		hex_cp[i]=(hex_cp[i]-'0')/2+'0';
		}
	}
	binary[65]='\0';
}

//�ж϶���������ܷ���double�洢 
void JudgeDoubleable(long double x)
{
	double doubleNum=(double)x;
    long double recoveredNum=(long double)doubleNum;

    if(fabsl(x-recoveredNum)<1e-30)
	{
        return;
    }else{
        __mingw_printf("���棺����������<double>�洢����ӽ���<double>��Ϊ %.15g��\n",doubleNum);
    }
}
//�ж϶���������ܷ���float�洢 
void JudgeFloatable(double x)
{
	float floatNum=(float)x;
    double recoveredNum=(double)floatNum;

    if(fabs(x-recoveredNum)<1e-8)
	{
        return;
    }else{
        printf("���棺����������<float>�洢����ӽ���<float>��Ϊ %f��\n",floatNum);
    }
}
//�����ȸ�������IEEE754��ʾ 
void FloatRepresentation()
{
	double x;
	printf("\n������һ��������ʮ���Ƹ�������");
	scanf("%lf",&x);
	char binary[33];
    char hex[9];
    memset(binary, 0, sizeof(binary));
    memset(hex, 0, sizeof(hex));
    
    JudgeFloatable(x);
    floatToBinaryAndHex((float)x, binary, hex);
	printf("\n<ʮ �� ��>��ʾΪ��%g\n",(float)x);
    printf("<�� �� ��>��ʾΪ��%s\n", binary);
    printf("<ʮ������>��ʾΪ��0x%s\n\n", hex);
} 
//˫���ȸ�������IEEE754��ʾ 
void DoubleRepresentation()
{
	long double x;
	printf("\n������һ��˫����ʮ���Ƹ�������");
	__mingw_scanf("%Lf",&x);
	char binary[65];
    char hex[17];
    memset(binary, 0, sizeof(binary));
    memset(hex, 0, sizeof(hex));
    
    JudgeDoubleable(x);
    doubleToBinaryAndHex((double)x, binary, hex);
	printf("\n<ʮ �� ��>��ʾΪ��%.15g\n",(double)x);
    printf("<�� �� ��>��ʾΪ��%s\n", binary);
    printf("<ʮ������>��ʾΪ��0x%s\n\n", hex);
	
}
//�����Ʊ���ת�����ȸ����� 
void ComplementToFloat()
{
	int i,exponent=0;
	double ans=0;
	char c,code[33]; 
	printf("\n������32λ�����Ʊ��룺");
	for(i=0;i<32;i++)
	{
		scanf("%c",&c);
		while(c==' '||c=='\n')
		{
			scanf("%c",&c);
		}
		code[i]=c;
	}
	for(i=8;i>=1;i--)
	{
		exponent+=(code[i]-'0')*pow(2,8-i);
	}
	exponent-=127;
	for(i=31;i>=9;i--)
	{
		ans+=(code[i]-'0')*pow(2,-(i-8)+exponent);
	}
	ans+=pow(2,exponent);
	ans=ans*pow(-1,code[0]-'0');
	code[32]='\0';
	printf("\n%s��Ӧ�ĵ����ȸ�����Ϊ��",code); 
	printf("%g\n\n",ans);
}
//�����Ʊ���ת˫���ȸ����� 
void ComplementToDouble()
{
	int i,exponent=0;
	double ans=0;
	char c,code[65]; 
	printf("\n������64λ�����Ʊ��룺");
	for(i=0;i<64;i++)
	{
		scanf("%c",&c);
		while(c==' '||c=='\n')
		{
			scanf("%c",&c);
		}
		code[i]=c;
	}
	for(i=11;i>=1;i--)
	{
		exponent+=(code[i]-'0')*pow(2,11-i);
	}
	exponent-=1023;
	for(i=63;i>=12;i--)
	{
		ans+=(code[i]-'0')*pow(2,-(i-11)+exponent);
	}
	ans+=pow(2,exponent);
	ans=ans*pow(-1,code[0]-'0');
	code[65]='\0';
	printf("\n%s��Ӧ��˫���ȸ�����Ϊ��",code); 
	printf("%.15g\n\n",ans);
}
//������תʮ����ʮ������ 
void BinaryToDecHex()
{
	char c;
	int i,j,k,n,flag=1;
	long long int dec=0;
	char *hex;
	char *binary;
	printf("���������������λ����");
	scanf("%d",&n);
	binary=(char*)malloc((n+1)*sizeof(char));
	hex=(char*)malloc((n/4+(n%4!=0)+1)*sizeof(char));
	memset(hex,'0',sizeof(hex));
	printf("������%dλ����������",n);
	for(i=0;i<n;i++)
	{
		scanf("%c",&c);
		while(c==' '||c=='\n')
		{
			scanf("%c",&c);
		}
		binary[i]=c;
	}
	binary[n]='\0';
	for(i=n-1;i>=0;i--)
	{
		dec+=(binary[i]-'0')*pow(2,n-1-i);
	} 
	for(i=0;i<n/4+(n%4!=0);i++)
	{
		if(i==0&&n%4!=0)
		{
			flag=0;
			for(j=n%4-1,k=0;j>=0;j--,k++)
			{
				hex[0]='0'+(hex[0]-'0')+(binary[j]-'0')*pow(2,k);
			}
			continue;
		}
		for(j=(i+flag)*4+n%4-1,k=0;j>=(i+flag)*4+n%4-4;j--,k++)
		{
			hex[i]='0'+(hex[i]-'0')+(binary[j]-'0')*pow(2,k);
		}
		if(hex[i]>'9')
		{
			hex[i]='A'+(hex[i]-'9')-1;
		}
	}
	hex[n/4+(n%4!=0)]='\0';
	printf("\n�����ƣ�%s\n",binary);
	printf("ʮ���ƣ�%lld\n",dec);
	printf("ʮ�����ƣ�0x%s\n",hex);
	free(binary);
	free(hex);
}
//ʮ����ת������ʮ������
void DecToBinaryHex()
{
	int i,j,k;
	int n=0,flag=1;
	long long int dec,dec_cp;
	char *binary;
	char *hex;
	printf("������ʮ��������");
	scanf("%lld",&dec);
	printf("\nʮ���ƣ�%lld\n",dec);
	dec_cp=dec;
	if(dec==0)
	{
		n=2;	
	}
	else
	{
		n=log2(dec)+1;
	}
	binary=(char*)malloc((n+1)*sizeof(char));
	hex=(char*)malloc((n/4+(n%4!=0)+1)*sizeof(char));
	memset(binary,'0',sizeof(binary));
	memset(hex,'0',sizeof(hex));
	i=n-1;
	while(dec_cp>0)
	{
		binary[i--]='0'+dec_cp%2;
		dec_cp=dec_cp/2;
	}
	binary[n]='\0';
	printf("�����ƣ�%s\n",binary);
	for(i=0;i<n/4+(n%4!=0);i++)
	{
		if(i==0&&n%4!=0)
		{
			flag=0;
			for(j=n%4-1,k=0;j>=0;j--,k++)
			{
				hex[0]='0'+(hex[0]-'0')+(binary[j]-'0')*pow(2,k);
			}
			continue;
		}
		for(j=(i+flag)*4+n%4-1,k=0;j>=(i+flag)*4+n%4-4;j--,k++)
		{
			hex[i]='0'+(hex[i]-'0')+(binary[j]-'0')*pow(2,k);
		}
		if(hex[i]>'9')
		{
			hex[i]='A'+(hex[i]-'9')-1;
		}
	}
	hex[n/4+(n%4!=0)]='\0';
	printf("ʮ�����ƣ�0x%s\n",hex);
} 
//ʮ������ת������ʮ���� 
void HexToBinaryDec()
{
	int i,j,n;
	char c;
	char *hex;
	char *binary;
	long long int dec=0;
	printf("������ʮ����������λ����");
	scanf("%d",&n);
	hex=(char*)malloc((n+1)*sizeof(char));
	binary=(char*)malloc((4*n+1)*sizeof(char));
	printf("������%dλʮ����������0x",n);
	for(i=0;i<n;i++)
	{
		scanf("%c",&c);
		while(c==' '||c=='\n')
		{
			scanf("%c",&c);
		}
		hex[i]=c;
	}
	hex[n]='\0';
	printf("\nʮ�����ƣ�%s\n",hex);
	for(i=0;i<n;i++)
    {
    	for(j=(i+1)*4-1;j>=i*4;j--)
    	{
    		if(hex[i]>='A'&&hex[i]<='F')
    		{
    			hex[i]='0'+hex[i]-'A'+10;
			}
			else if(hex[i]>='a'&&hex[i]<='f')
			{
				hex[i]='0'+hex[i]-'a'+10;
			 } 
    		binary[j]=(hex[i]-'0')%2+'0';
    		hex[i]=(hex[i]-'0')/2+'0';
		}
	}
	binary[4*n]='\0';
	for(i=4*n-1;i>=0;i--)
	{
		dec+=(binary[i]-'0')*pow(2,4*n-1-i);
	}
	printf("�����ƣ�%s\n",binary);
	printf("ʮ���ƣ�%lld\n",dec);
	free(hex);
	free(binary);
 } 
 

void IntOperation()
{
	int flag; 
	printf("  ��ѡ��\n"
	"  1 - �з���������ԭ�롢���롢�����ʾ\n"
	"  2 - 32λ�����Ʋ���ת�з�������\n");
	scanf("%d",&flag);
	switch(flag)
	{
		case 1:IntRepresentation();break;
		case 2:ComplementToInt();break;
		default:printf("ѡ�����\n");break; 
	}
}

void PointOperation()
{
	int flag; 
	printf("  ��ѡ��\n"
	"  1 - �����ȸ������Ķ����Ʊ�ʾ\n"
	"  2 - ˫���ȸ������Ķ����Ʊ�ʾ\n"
	"  3 - �����Ʊ���ת�����ȸ�����\n"
	"  4 - �����Ʊ���ת˫���ȸ�����\n");
	scanf("%d",&flag);
	switch(flag)
	{
		case 1:FloatRepresentation();break;
		case 2:DoubleRepresentation();break;
		case 3:ComplementToFloat();break;
		case 4:ComplementToDouble();break;
		default:printf("ѡ�����\n");break; 
	}
}

void Convertion()
{
	int flag;
	printf("��ģ���ṩ�����������޷���ʮ��������ʮ�����������ת��������ĳһ���ͣ��������������\n" 
	"ע�⣺�뱣֤������λ��<=64�����򽫲����������\n"); 
	printf("\n��ѡ����������ͣ�\n"
	"1-������  2-ʮ����  3-ʮ������\n");
	scanf("%d",&flag);
	switch(flag)
	{
		case 1:BinaryToDecHex();break;
		case 2:DecToBinaryHex();break;
		case 3:HexToBinaryDec();break;
	}
}

int main()
{
	while(1)
	{
		int flag;
		printf("------------------------------------------\n"
		" ������ѡ��\n"
		"   0 - Help\n"
		"   1 - ��  ������\n"
		"   2 - ����������\n"
		"   3 - ����ת��\n"
		"  -1 - �˳�����\n"
		"------------------------------------------\n");
		printf("   ��ѡ���ܣ�"); 
		scanf("%d",&flag);
		if(flag==-1)
		{
			exit(0);
		}
		else
		{
			printf("------------------------------------------\n");
			switch(flag)
			{
				case 0:help();break;
				case 1:IntOperation();break;
				case 2:PointOperation();break;
				case 3:Convertion();break; 
				default:printf("   ����ѡ�����\n");break;
			}
		}
	}
 } 
 
 
 
