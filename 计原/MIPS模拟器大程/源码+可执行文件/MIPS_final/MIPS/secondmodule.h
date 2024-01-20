#ifndef SECONDMODULE_H
#define SECONDMODULE_H
#include <string.h>
#include <qstring.h>

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
void IntRepresentation(QString s,QString *OC_,QString *RC_,QString *CC_)
{
    int i,x;
    char OC[33],RC[33],CC[33];
    OC[32]=RC[32]=CC[32]='\0';
    x = s.toInt();
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

    char temp;
    for(i=0;i<16;i++){
        temp = OC[i];
        OC[i] = OC[31-i];
        OC[31-i] = temp;
        temp = RC[i];
        RC[i] = RC[31-i];
        RC[31-i] = temp;
        temp = CC[i];
        CC[i] = CC[31-i];
        CC[31-i] = temp;
    }

    *OC_ = QString(QLatin1String(OC));
    *RC_ = QString(QLatin1String(RC));
    *CC_ = QString(QLatin1String(CC));
}
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
void ComplementToInt(QString s,int *res_)
{
    int i,res=0;
    int flag;
    char c,*code,*code_cp;
    QByteArray ba=s.toLatin1();
    code = code_cp = ba.data();
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
        ResSubOne(code_cp);
        for(i=31;i>=0;i--)
        {
            code_cp[i]=='0'?code_cp[i]='1':code_cp[i]='0';
            res+=(code_cp[i]-'0')*pow(2,31-i);
        }
        res=-res;
    }
    *res_ = res;
}

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
int JudgeFloatable(double x)
{
    float floatNum=(float)x;
    double recoveredNum=(double)floatNum;

    if(fabs(x-recoveredNum)<1e-8)
    {
        return 1;
    }else{
        return 0;
    }
}
void FloatRepresentation(double x,char *bin_,char *hex_)
{
    char binary[33];
    char hex[9];
    memset(binary, 0, sizeof(binary));
    memset(hex, 0, sizeof(hex));

    floatToBinaryAndHex((float)x, binary, hex);
    strncpy(bin_,binary,sizeof(binary));
    strncpy(hex_,hex,sizeof(hex));
}
void doubleToBinaryAndHex(double num, char* binary, char* hex) {
    int i, j;
    char hex_cp[17];
    long long int *pInt = (long long int*)&num;
    sprintf(hex, "%016llX", *pInt);
    hex[16]='\0';
    strncpy(hex_cp,hex,17);
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
int JudgeDoubleable(long double x)
{
    double doubleNum=(double)x;
    long double recoveredNum=(long double)doubleNum;

    if(fabsl(x-recoveredNum)<1e-30)
    {
        return 1;
    }else{
        return 0;
    }
}
void DoubleRepresentation(long double x,char *bin_,char *hex_)
{
    char binary[65];
    char hex[17];
    memset(binary, 0, sizeof(binary));
    memset(hex, 0, sizeof(hex));
    doubleToBinaryAndHex((double)x, binary, hex);
    strncpy(bin_,binary,sizeof(binary));
    strncpy(hex_,hex,sizeof(hex));

}


void ComplementToFloat(QString s,double *res)
{
    int i,exponent=0;
    double ans=0;
    char c,*code;
    QByteArray ba=s.toLatin1();
    code = ba.data();

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
    *res = ans;
}



void ComplementToDouble(QString s,double *res)
{
    int i,exponent=0;
    double ans=0;
    char c,*code;
    QByteArray ba=s.toLatin1();
    code = ba.data();
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
    *res = ans;
}

void BinaryToDecHex(QString bin_,QString *dec_,QString *hex_)
{
    char c;
    int i,j,k,n,flag=1;
    long long int dec=0;
    char *hex;
    char *binary;
    n=bin_.length();
    QByteArray ba=bin_.toLatin1();
    binary = ba.data();
    hex=(char*)malloc((n/4+(n%4!=0)+1)*sizeof(char));
    memset(hex,'0',(n/4+(n%4!=0)+1));
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

    *dec_ = QString::number(dec);
    *hex_ = QString::fromUtf8(hex);

    free(hex);
}

//十进制转二进制十六进制
void DecToBinaryHex(QString dec_,QString *bin_,QString *hex_)
{
    int i,j,k;
    int n=0,flag=1;
    long long int dec;
    char *binary;
    char *hex;
    dec = dec_.toLongLong();
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
    memset(binary,'0',n+1);
    memset(hex,'0',(n/4+(n%4!=0)+1));
    i=n-1;
    while(dec>0)
    {
        binary[i--]='0'+dec%2;
        dec=dec/2;
    }
    binary[n]='\0';
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
    *bin_ = QString::fromUtf8(binary);
    *hex_ = QString::fromUtf8(hex);
}
//十六进制转二进制十进制
void HexToBinaryDec(QString hex_,QString *bin_,QString *dec_)
{
    int i,j,n;
    char c;
    char *hex;
    char *binary;
    long long int dec=0;
    n = hex_.length();
    QByteArray ba = hex_.toLatin1();
    hex = ba.data();
    binary=(char*)malloc((4*n+1)*sizeof(char));
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
    *bin_ = QString::fromUtf8(binary);
    *dec_ = QString::number(dec);
    free(binary);
}

#endif // SECONDMODULE_H
