#include<stdio.h>
#include<time.h>
double POW1(double x,int n);//Algorithm 1
double POW2(double x,int n);//Algorithm 2(iterative version)
double POW3(double x,int n);//Algorithm 2(recursive version)

clock_t start1,start2,start3,stop1,stop2,stop3;
double duration1,duration2,duration3;//��¼ִ��ʱ��(sec)
double ticks1,ticks2,ticks3; 


int main(void){
	double X,result1,result2,result3;
	int N,k,K1,K2,K3;
	printf("������X��N:");
	scanf("%lf%d",&X,&N);	//����X��N
	getchar();//��ȡ�س���
	printf("������Iterations K1 K2 K3:");//����ѭ������K1,K2��K3 
	scanf("%d%d%d",&K1,&K2,&K3);
	printf("\n");
	printf("Result		Ticks		Total Times(sec)\n");//�����ʽ 
	
	//Algorithm 1
	start1=clock();//start at the beginning of the function call
	for(k=0;k<K1;k++){
		result1=POW1(X,N);//ִ��Algorithm 1���ظ�K1�� 
	}
	stop1=clock();//stop at the end of the function call
	ticks1=stop1-start1;//����Ticks 
	duration1=((double)(stop1-start1))/CLK_TCK;//����ʱ�� 
	printf("%f\t%f\t%f\t\n",result1,ticks1,duration1);
	printf("***********************************************\n");//��ӡ����� 
	
	//Algorithm 2(iterative version)
	start2=clock();//start at the beginning of the function call
	for(k=0;k<K2;k++){
		result2=POW2(X,N);//ִ��Algorithm 2(iterative version)���ظ�K2�� 
	}
	stop2=clock();//stop at the end of the function call
	ticks2=stop2-start2;//����Ticks
	duration2=((double)(stop2-start2))/CLK_TCK;//����ʱ��
	printf("%f\t%f\t%f\t\n",result2,ticks2,duration2);
	printf("***********************************************\n");//��ӡ�����
	
	//Algorithm 2(recursive version)
	start3=clock();//start at the beginning of the function call
	for(k=0;k<K3;k++){
		result3=POW3(X,N);//ִ��Algorithm 2(recursive version)���ظ�K3�� 
	}
	stop3=clock();//stop at the end of the function call
	ticks3=stop3-start3;//����Ticks
	duration3=((double)(stop3-start3))/CLK_TCK;//����ʱ�� 
	printf("%f\t%f\t%f\t\n",result3,ticks3,duration3);
	
	return 0;
}

//Algorithm 1
double POW1(double x,int n){
	int i;
	double y=1;	//���result 
	for(i=0;i<n;i++){
		y=y*x;
	}
	return y;
}

//Algorithm 2(iterative version)
double POW2(double x,int n){
	int data[64],i,j;//data�������ڼ�¼ÿ������֮�����ż��
	i=0;//��ʼ��i��Ϊ����ѭ��������׼�� 
	double result=x;//��Ž�� 
	if(n==0){
		return 1;//�ų�ָ��Ϊ0�����; 
	}
	while(n!=1){
		if(n%2==1){
			data[i]=1;//1:odd
			i++;
		}else{
			data[i]=0;
			i++;//0:even
		}
		n=n>>1;//n����2 
	} 
	for(j=i-1;j>=0;j--){
		if(data[j]){
			result=result*result*x;//���data[j]Ϊ1��˵����ʱָ��Ϊ���� 
		}else{
			result=result*result;//���data[j]Ϊ0��˵����ʱָ��Ϊż�� 
		}
	}
	return result;
}

//Algorithm 2(recursive version)
double POW3(double x,int n){
	if(n==0){
		return 1;//N==0,����1 
	}else if(n==1){
		return x;//N==1,����x 
	}else if(n%2==0){
		return POW3(x*x,n/2);
	}else{
		return POW3(x*x,(n-1)/2)*x;
	}
}
