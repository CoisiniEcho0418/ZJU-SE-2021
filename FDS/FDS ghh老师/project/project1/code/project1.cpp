#include<stdio.h>
#include<time.h>

// Global variables 
clock_t start1,start2,start3,stop1,stop2,stop3;
double duration1,duration2,duration3;// Record execution time (sec)
double ticks1,ticks2,ticks3; 
bool is_exit = false; // Whether to exit the main menu
bool is_exit_update = false; // Whether to exit the update menu for automation 
double X = 1.0001;
long k1[8],k2[8],k3[8]; // Corresponding K values for different N values
long N[8] = {1000,5000,10000,20000,40000,60000,80000,100000};
double total_duration1[8],total_duration2[8],total_duration3[8]; // Accumulated time (after amplifying the loop) 
double total_ticks1[8],total_ticks2[8],total_ticks3[8]; // Accumulated ticks
double total_average_ticks1[8],total_average_ticks2[8],total_average_ticks3[8]; // Used to output averages 
double total_average_duration1[8],total_average_duration2[8],total_average_duration3[8]; // Used to output averages
double actual_duration1[8],actual_duration2[8],actual_duration3[8]; // Output actual time 
int number = 0; // Record how many times automation has been performed 

// Function declarations 
double PowOfAlgorithm1(double x,int n); // Algorithm 1
double POWOfIterativeAlgorithm2(double x,int n); // Algorithm 2(iterative version)
double PowOfRecursiveAlgorithm2(double x,int n); // Algorithm 2(recursive version)
void ManualShowTest(); // Manual testing (for user input option 1) 
void AutoShowTest(); // Automated testing (for user input option 2)
void UpdateGlobalValueOfK(); // Modify configuration items for automation testing (for user input option 3) 
void ShowAverage(); // Output averages based on automation testing results and counts 
void ShowMenu1(); // Print a more aesthetically pleasing main menu
void ShowMenu2(); // Print a more aesthetically pleasing update menu for automation

int main(void){
	// Initialize global variables 
	for(int i=0;i<2;i++){
		k1[i]=10000;
	}
	for(int i=2;i<8;i++){
		k1[i]=1000;
	}
	for(int i=0;i<8;i++){
		k2[i]=1000000;
		k3[i]=1000000;
	}
	
	
	// Loop waiting for user input 
	while(!is_exit){
		int op; // Set test mode
		ShowMenu1(); // Call a more aesthetically pleasing menu interface
		scanf("%d",&op);
		getchar();
		printf("\n");
		switch(op){
			case 1:
				// Manual testing
				ManualShowTest();
				break;
			case 2:
				// Automated testing
				AutoShowTest();
				break;
			case 3:
				// Modify configuration items for automation testing
				UpdateGlobalValueOfK();
				break;
			case 4:
				// Output averages based on automation testing results and counts
				ShowAverage();
				break; 
			case 5:
				// Exit
				is_exit = true;
				break;
			default:
				printf("��������ȷ�����֣�\n");
				break;
		}
	}
	
	return 0;
}

//Algorithm 1
double PowOfAlgorithm1(double x,int n){
	int i;
	double result=1;	// Store the result 
	for(i=0;i<n;i++){
		result=result*x;
	}
	return result;
}

//Algorithm 2(iterative version)
double POWOfIterativeAlgorithm2(double x,int n){
	int data[64],i,j;// The data array is used to record the parity after each division
	i=0;// Initialize i for subsequent loop traversal
	double result=x;// Store the result 
	if(n==0){
		return 1;// Exclude the case where the exponent is 0
	}
	while(n!=1){
		if(n%2==1){
			data[i]=1;//1:odd
			i++;
		}else{
			data[i]=0;
			i++;//0:even
		}
		n=n>>1;// Divide n by 2 
	} 
	for(j=i-1;j>=0;j--){
		if(data[j]){
			result=result*result*x;// If data[j] is 1, it means the exponent is odd 
		}else{
			result=result*result;// If data[j] is 0, it means the exponent is even
		}
	}
	return result;
}

//Algorithm 2(recursive version)
double PowOfRecursiveAlgorithm2(double x,int n){
	if(n==0){
		return 1;// N == 0, return 1
	}else if(n==1){
		return x;// N == 1, return x
	}else if(n%2==0){
		return PowOfRecursiveAlgorithm2(x*x,n/2);
	}else{
		return PowOfRecursiveAlgorithm2(x*x,(n-1)/2)*x;
	}
}

// Manual input to obtain test results 
void  ManualShowTest(){
	double X,result1,result2,result3;
	int N,k,K1,K2,K3;
	printf("������X��N:");
	scanf("%lf%d",&X,&N);	// Read X and N
	getchar();// Read the newline character
	printf("������Iterations K1 K2 K3:");// Read the number of iterations K1, K2, and K3 
	scanf("%d%d%d",&K1,&K2,&K3);
	printf("\n");
	printf("Result		Ticks		Total Times(sec)\n");// Output format 
	//Algorithm 1
	start1=clock();//start at the beginning of the function call
	for(k=0;k<K1;k++){
		result1=PowOfAlgorithm1(X,N);// Execute Algorithm 1, repeat K1 times 
	}
	stop1=clock();//stop at the end of the function call
	ticks1=stop1-start1;// Calculate ticks
	duration1=((double)(stop1-start1))/CLK_TCK;// Calculate time 
	printf("%f\t%f\t%f\t\n",result1,ticks1,duration1);
	printf("-----------------------------------------------\n");// Print separator
	
	//Algorithm 2(iterative version)
	start2=clock();//start at the beginning of the function call
	for(k=0;k<K2;k++){
		result2=POWOfIterativeAlgorithm2(X,N);// ExecuteAlgorithm 2(iterative version)��repeat K2 times
	}
	stop2=clock();//stop at the end of the function call
	ticks2=stop2-start2;// Calculate ticks
	duration2=((double)(stop2-start2))/CLK_TCK;// Calculate time
	printf("%f\t%f\t%f\t\n",result2,ticks2,duration2);
	printf("-----------------------------------------------\n");// Print separator 
	
	//Algorithm 2(recursive version)
	start3=clock();//start at the beginning of the function call
	for(k=0;k<K3;k++){
		result3=PowOfRecursiveAlgorithm2(X,N);// ExecuteAlgorithm 2(recursive version)��repeat K3 times
	}
	stop3=clock();//stop at the end of the function call
	ticks3=stop3-start3;// CalculateTicks
	duration3=((double)(stop3-start3))/CLK_TCK;// Calculate time
	printf("%f\t%f\t%f\t\n",result3,ticks3,duration3);
}

// Automated testing, automatically give results based on recommended K values
void AutoShowTest(){
	number++; // Increment number each time automated testing is called 
	double result1,result2,result3;
	for(int i=0;i<8;i++){
		//Algorithm 1
		start1=clock();//start at the beginning of the function call
		for(int k=0;k<k1[i];k++){
			result1=PowOfAlgorithm1(X,N[i]);// Execute Algorithm 1, repeat K1 times 
		}
		stop1=clock();//stop at the end of the function call
		ticks1=stop1-start1;// Calculate ticks
		duration1=((double)(stop1-start1))/CLK_TCK;// Calculate time
		total_ticks1[i]+=ticks1; 
		total_duration1[i]+= duration1; // Accumulate time
		printf("( X:%lf , N:%ld )\n",X,N[i]);
		printf("-----------------------------------------------\n");// Print separator
		printf("Result		Ticks		Total Times(sec)\n");
		printf("-----------------------------------------------\n");
		printf("%f\t%f\t%f\t\n",result1,ticks1,duration1);
		printf("-----------------------------------------------\n"); 
		
		//Algorithm 2(iterative version)
		start2=clock();//start at the beginning of the function call
		for(int k=0;k<k2[i];k++){
			result2=POWOfIterativeAlgorithm2(X,N[i]);
		}
		stop2=clock();//stop at the end of the function call
		ticks2=stop2-start2;
		duration2=((double)(stop2-start2))/CLK_TCK;
		total_ticks2[i]+=ticks2;
		total_duration2[i]+= duration2;
		printf("%f\t%f\t%f\t\n",result2,ticks2,duration2);
		printf("-----------------------------------------------\n"); 
		
		//Algorithm 2(recursive version)
		start3=clock();//start at the beginning of the function call
		for(int k=0;k<k3[i];k++){
			result3=PowOfRecursiveAlgorithm2(X,N[i]);
		}
		stop3=clock();//stop at the end of the function call
		ticks3=stop3-start3;
		duration3=((double)(stop3-start3))/CLK_TCK;
		total_ticks3[i]+=ticks3;
		total_duration3[i]+= duration3;
		printf("%f\t%f\t%f\t\n",result3,ticks3,duration3);
		printf("\n");
	} 
}

void UpdateGlobalValueOfK(){
	is_exit_update = false; // Check if exit
	bool is_valid = false; // Check if user input is valid 
	int op;
	int index;
	while(!is_exit_update){
		ShowMenu2(); // Call a more aesthetically pleasing menu interface
		scanf("%d",&op);
		getchar();
		printf("\n");
		is_valid = false; 
		switch(op){
			case 1:
				while(!is_valid){
					printf("\n��������Ҫ�޸ĵ�Kֵ�±���������0-7�ֱ����1000/5000/10000/.../100000����") ;
					scanf("%d",&index);
					getchar();
					printf("\n");
					if(index<0||index>7){
						is_valid = false;
						printf("��������Ч���±�����\n");
					}else{
						printf("\n��������Ҫ�޸ĳɵ�ֵ:");
						scanf("%d",&k1[index]);
						printf("\n");
						is_valid = true;
					}		
				}
				break;
			case 2:
				while(!is_valid){
					printf("\n��������Ҫ�޸ĵ�Kֵ�±���������0-7�ֱ����1000/5000/10000/.../100000����") ;
					scanf("%d",&index);
					getchar();
					printf("\n");
					if(index<0||index>7){
						is_valid = false;
						printf("��������Ч���±�����\n");
					}else{
						printf("\n��������Ҫ�޸ĳɵ�ֵ:");
						scanf("%d",&k2[index]);
						printf("\n");
						is_valid = true;
					}		
				}
				break;
			case 3:
				while(!is_valid){
					printf("\n��������Ҫ�޸ĵ�Kֵ�±���������0-7�ֱ����1000/5000/10000/.../100000����") ;
					scanf("%d",&index);
					getchar();
					printf("\n");
					if(index<0||index>7){
						is_valid = false;
						printf("��������Ч���±�����\n");
					}else{
						printf("\n��������Ҫ�޸ĳɵ�ֵ:");
						scanf("%d",&k3[index]);
						printf("\n");
						is_valid = true;
					}		
				}
				break;
			case 4:
				printf("��������Ҫ�޸ĵ�X��ֵ��");
				scanf("%lf",&X);
				getchar();
				printf("\n");
				break;
			case 5:
				is_exit_update = true;
				break;
			default:
				printf("��������ȷ������\n");
				break;
		}
	}
	
}

void ShowAverage(){
	
	for(int i=0;i<8;i++){
		total_average_duration1[i]=total_duration1[i]*1.0/number;
		total_average_duration2[i]=total_duration2[i]*1.0/number;
		total_average_duration3[i]=total_duration3[i]*1.0/number;
		total_average_ticks1[i]=total_ticks1[i]*1.0/number;
		total_average_ticks2[i]=total_ticks2[i]*1.0/number;
		total_average_ticks3[i]=total_ticks3[i]*1.0/number;
		actual_duration1[i]=total_average_duration1[i]*1.0/k1[i];
		actual_duration2[i]=total_average_duration2[i]*1.0/k2[i];
		actual_duration3[i]=total_average_duration3[i]*1.0/k3[i];
		printf("( X:%lf , N:%ld )\n",X,N[i]);
		printf("-----------------------------------------------------------------------\n");
		printf("K\t\tTicks\t\tTotal Durations(sec)\tSingle Duration\n");
		printf("-----------------------------------------------------------------------\n");
		printf("%ld\t\t%f\t%f\t\t%.10f\t\t\n",k1[i],total_average_ticks1[i],total_average_duration1[i],actual_duration1[i]);
		printf("-----------------------------------------------------------------------\n");
		printf("%ld\t\t%f\t%f\t\t%.10f\t\t\n",k2[i],total_average_ticks2[i],total_average_duration2[i],actual_duration2[i]);
		printf("-----------------------------------------------------------------------\n");
		printf("%ld\t\t%f\t%f\t\t%.10f\t\t\n",k3[i],total_average_ticks3[i],total_average_duration3[i],actual_duration3[i]);
		printf("\n");
	} 
}

void ShowMenu1(){
	// Print title
	printf( "+----------------------------------------------------------------+\n");
	printf( "| ѡ �� |          ��ѡ����������ѡ��1~5�����֣�               |\n");
	printf( "+----------------------------------------------------------------+\n");
	// Print menu content
	printf( "|  [1]  | �ֶ����ԣ�  �ֶ�����X/N/K���в���                      |\n");
	printf( "|  [2]  | �Զ������ԣ��������Ƽ����õ�X/N/K�����Զ�������        |\n");
	printf( "|  [3]  | �޸����ã�  �޸��Զ�������Ĭ�����õ�X/N/K��ֵ          |\n");
	printf( "|  [4]  | ���ƽ�����������Զ������ԵĽ�����ܴ��������ƽ����   |\n");
	printf( "|  [5]  | �˳���      �˳�����                                   |\n");
	printf( "+----------------------------------------------------------------+\n");
	printf("\n");
}

void ShowMenu2(){
	// Print title
	printf( "+----------------------------------------------------------------+\n");
	printf( "| ѡ �� |          ��ѡ����������ѡ��1~5�����֣�               |\n");
	printf( "+----------------------------------------------------------------+\n");
	// Print menu content
	printf( "|  [1]  | (K for algorithm1)��           �޸�algorithm1�е�Kֵ   |\n");
	printf( "|  [2]  | (K for algorithm2(iterative)): �޸�algorithm2�е�Kֵ   |\n");
	printf( "|  [3]  | (K for algorithm(recursive)):  �޸�algorithm2�е�Kֵ   |\n");
	printf( "|  [4]  | X��        �޸�X��ֵ                                   |\n");
	printf( "|  [5]  | Exit��     �˳�ѡ��                                    |\n");
	printf( "+----------------------------------------------------------------+\n");
	printf("\n");
}


