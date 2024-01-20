#include<stdio.h>
#include<string.h>
#include<math.h>
#include<stdlib.h>

void help()
{
	printf("以下是该程序的使用说明：\n"
	"\n>【整数的二进制表示（原码|反码|补码）】:\n输入一个十进制整数，请确保范围在[-2^31,2^31-1]之中，否则会产生溢出错误；\n" 
	"\n>【32位二进制补码转整数】：\n输入32位由0或1组成的二进制补码，可以存在空格符（程序会自动略过），输入非0/1字符将产生不可预知的后果；\n"
	"\n>【单精度浮点数的IEEE754表示】：\n输入一个单精度浮点数，若输入的数非单精度浮点数，程序会予以提醒并自动选择于其最近的数，请确保范围在[-3.4*10^38，3.4*10^38]中,否则会产生溢出错误；\n"
	"\n>【32位二进制转单精度浮点数】：\n输入32位由0或1组成的二进制编码，可以存在空格符（程序会自动略过），输入非0/1字符将产生不可预知的后果；\n"
	"\n>【双精度浮点数的IEEE754表示】：\n输入一个双精度浮点数，若输入的数非双精度浮点数，程序会予以提醒并自动选择于其最近的数，请确保范围在[-1.79*10^308,-1.79*10^308]中,否则会产生溢出错误；\n"
	"\n>【64位二进制转单精度浮点数】：\n输入64位由0或1组成的二进制编码，可以存在空格符（程序会自动略过），输入非0/1字符将产生不可预知的后果；\n"
	);
	printf("\n");
}
//十进制正整数转二进制(32位) 
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

//二进制字符串+1 
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
//二进制字符串-1
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
 
//整数的表示(32位) 
void IntRepresentation()
{
	int i,x;
	char OC[32],RC[32],CC[32];
	printf("\n请输入一个十进制整数[-2^31,2^31-1]：");
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
	printf("\n %d 的32位二进制【原码】为：",x);
	for(i=31;i>=0;i--)
	{
		if((i+1)%4==0)
		{
			printf(" ");
		 } 
		printf("%c",OC[i]);
	}
	printf("\n %d 的32位二进制【反码】为：",x);
	for(i=31;i>=0;i--)
	{
		if((i+1)%4==0)
		{
			printf(" ");
		 } 
		printf("%c",RC[i]);
	}
	printf("\n %d 的32位二进制【补码】为：",x);
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

//二进制补码转整数 
void ComplementToInt()
{
	int i,res=0;
	int flag;
	char c,code[32]; 
	printf("\n请输入32位二进制补码：");
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
	printf("表示的十进制整数为 %d\n\n",res);
 } 
 
//将float表示为二进制和十六进制 
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

//将double表示为二进制和十六进制 
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

//判断读入的数据能否用double存储 
void JudgeDoubleable(long double x)
{
	double doubleNum=(double)x;
    long double recoveredNum=(long double)doubleNum;

    if(fabsl(x-recoveredNum)<1e-30)
	{
        return;
    }else{
        __mingw_printf("警告：该数不能用<double>存储，最接近的<double>数为 %.15g。\n",doubleNum);
    }
}
//判断读入的数据能否用float存储 
void JudgeFloatable(double x)
{
	float floatNum=(float)x;
    double recoveredNum=(double)floatNum;

    if(fabs(x-recoveredNum)<1e-8)
	{
        return;
    }else{
        printf("警告：该数不能用<float>存储，最接近的<float>数为 %f。\n",floatNum);
    }
}
//单精度浮点数的IEEE754表示 
void FloatRepresentation()
{
	double x;
	printf("\n请输入一个单精度十进制浮点数：");
	scanf("%lf",&x);
	char binary[33];
    char hex[9];
    memset(binary, 0, sizeof(binary));
    memset(hex, 0, sizeof(hex));
    
    JudgeFloatable(x);
    floatToBinaryAndHex((float)x, binary, hex);
	printf("\n<十 进 制>表示为：%g\n",(float)x);
    printf("<二 进 制>表示为：%s\n", binary);
    printf("<十六进制>表示为：0x%s\n\n", hex);
} 
//双精度浮点数的IEEE754表示 
void DoubleRepresentation()
{
	long double x;
	printf("\n请输入一个双精度十进制浮点数：");
	__mingw_scanf("%Lf",&x);
	char binary[65];
    char hex[17];
    memset(binary, 0, sizeof(binary));
    memset(hex, 0, sizeof(hex));
    
    JudgeDoubleable(x);
    doubleToBinaryAndHex((double)x, binary, hex);
	printf("\n<十 进 制>表示为：%.15g\n",(double)x);
    printf("<二 进 制>表示为：%s\n", binary);
    printf("<十六进制>表示为：0x%s\n\n", hex);
	
}
//二进制编码转单精度浮点数 
void ComplementToFloat()
{
	int i,exponent=0;
	double ans=0;
	char c,code[33]; 
	printf("\n请输入32位二进制编码：");
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
	printf("\n%s对应的单精度浮点数为：",code); 
	printf("%g\n\n",ans);
}
//二进制编码转双精度浮点数 
void ComplementToDouble()
{
	int i,exponent=0;
	double ans=0;
	char c,code[65]; 
	printf("\n请输入64位二进制编码：");
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
	printf("\n%s对应的双精度浮点数为：",code); 
	printf("%.15g\n\n",ans);
}
//二进制转十进制十六进制 
void BinaryToDecHex()
{
	char c;
	int i,j,k,n,flag=1;
	long long int dec=0;
	char *hex;
	char *binary;
	printf("请输入二进制数的位数：");
	scanf("%d",&n);
	binary=(char*)malloc((n+1)*sizeof(char));
	hex=(char*)malloc((n/4+(n%4!=0)+1)*sizeof(char));
	memset(hex,'0',sizeof(hex));
	printf("请输入%d位二进制数：",n);
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
	printf("\n二进制：%s\n",binary);
	printf("十进制：%lld\n",dec);
	printf("十六进制：0x%s\n",hex);
	free(binary);
	free(hex);
}
//十进制转二进制十六进制
void DecToBinaryHex()
{
	int i,j,k;
	int n=0,flag=1;
	long long int dec,dec_cp;
	char *binary;
	char *hex;
	printf("请输入十进制数：");
	scanf("%lld",&dec);
	printf("\n十进制：%lld\n",dec);
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
	printf("二进制：%s\n",binary);
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
	printf("十六进制：0x%s\n",hex);
} 
//十六进制转二进制十进制 
void HexToBinaryDec()
{
	int i,j,n;
	char c;
	char *hex;
	char *binary;
	long long int dec=0;
	printf("请输入十六进制数的位数：");
	scanf("%d",&n);
	hex=(char*)malloc((n+1)*sizeof(char));
	binary=(char*)malloc((4*n+1)*sizeof(char));
	printf("请输入%d位十六进制数：0x",n);
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
	printf("\n十六进制：%s\n",hex);
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
	printf("二进制：%s\n",binary);
	printf("十进制：%lld\n",dec);
	free(hex);
	free(binary);
 } 
 

void IntOperation()
{
	int flag; 
	printf("  请选择：\n"
	"  1 - 有符号整数的原码、反码、补码表示\n"
	"  2 - 32位二进制补码转有符号整数\n");
	scanf("%d",&flag);
	switch(flag)
	{
		case 1:IntRepresentation();break;
		case 2:ComplementToInt();break;
		default:printf("选择错误！\n");break; 
	}
}

void PointOperation()
{
	int flag; 
	printf("  请选择：\n"
	"  1 - 单精度浮点数的二进制表示\n"
	"  2 - 双精度浮点数的二进制表示\n"
	"  3 - 二进制编码转单精度浮点数\n"
	"  4 - 二进制编码转双精度浮点数\n");
	scanf("%d",&flag);
	switch(flag)
	{
		case 1:FloatRepresentation();break;
		case 2:DoubleRepresentation();break;
		case 3:ComplementToFloat();break;
		case 4:ComplementToDouble();break;
		default:printf("选择错误！\n");break; 
	}
}

void Convertion()
{
	int flag;
	printf("本模块提供二进制数、无符号十进制数、十六进制数间的转换，输入某一类型，输出另两种类型\n" 
	"注意：请保证二进制位数<=64，否则将产生溢出错误\n"); 
	printf("\n请选择输入的类型：\n"
	"1-二进制  2-十进制  3-十六进制\n");
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
		" 【功能选择】\n"
		"   0 - Help\n"
		"   1 - 整  数功能\n"
		"   2 - 浮点数功能\n"
		"   3 - 进制转换\n"
		"  -1 - 退出程序\n"
		"------------------------------------------\n");
		printf("   请选择功能："); 
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
				default:printf("   功能选择错误！\n");break;
			}
		}
	}
 } 
 
 
 
