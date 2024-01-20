#include<stdio.h>
#include<stdlib.h>
#include<string.h>

#define MEMSPACE 0XFFFF

char MEMORY[MEMSPACE][17];			//�����ڴ�����
char MDR[17];
char IR[17];
unsigned short PC;						
unsigned short MAR;
signed short CC;
signed short R[8];


void BR(void);
void ADD(void);
void LD(void);
void ST(void);
void JSR(void);
void AND(void);
void LDR(void);
void STR(void);
void NOT(void);
void LDI(void);
void STI(void);
void JMP(void);
void LEA(void);
int HALT(void);


int main(void){
	int i,j,flag,symbol,ISHALT;
	char line[17];					//�洢��һ�л����루the starting address��
	unsigned short sum=0;
	ISHALT=1;						//ISHALT(0��halt  1��ִ��) 
	//��ʼ���ڴ� 
	for(i=0;i<MEMSPACE;i++){
		for(j=0;j<16;j++){
			if(j==0||j==4||j==8||j==12){
				MEMORY[i][j]='0';
			}else{
				MEMORY[i][j]='1';
			}
		}
		MEMORY[i][16]='\0';
	}
	
	//��ʼ���Ĵ���
	for(i=0;i<8;i++){
		R[i]=0x7777;
	} 
	
	//���ڶ����һ�л����루the starting address of the program��
	scanf("%s",line);
	line[16]='\0';
	getchar();
	for(i=0;i<16;i++){
		sum=sum*2+line[i]-'0';
	}
	PC=sum;
	i=sum;
	
	//��������д���ڴ� 
	while(1){
		flag=scanf("%s",MEMORY[i]);
		MEMORY[i][16]='\0';
		if(flag==EOF){
			break;
		}
		i++;
		getchar();
	}
	
	//ָ��ѭ�� 
	while(ISHALT){
		//ȡָ�� 
		MAR=PC;
		PC++;
		for(i=0;i<16;i++){
			MDR[i]=MEMORY[MAR][i];
			IR[i]=MDR[i];
		}
		MDR[16]='\0';
		IR[16]='\0';
		//����
		symbol=0;
		for(i=0;i<4;i++){
			symbol=symbol*2+IR[i]-'0';
		} 
		switch(symbol){
			case 0://0000	BR
				BR();
				break;
			case 1://0001	ADD
				ADD();
				break;
			case 2://0010	LD
				LD();
				break;
			case 3://0011	ST
				ST();
				break;
			case 4://0100	JSR
				JSR();
				break;
			case 5://0101	AND
				AND();
				break;
			case 6://0110	LDR
				LDR();
				break;
			case 7://0111	STR
				STR();
				break;
			case 8://1000	RTI(����Ҫ) 
				break;
			case 9://1001	NOT
				NOT();
				break;
			case 10://1010	LDI
				LDI();
				break;
			case 11://1011	STI
				STI();
				break;
			case 12://1100	JMP
				JMP();
				break;		
			case 13://1101	�� 
				break;	
			case 14://1110	LEA
				LEA();
				break;
			case 15://1111	TRAP(HALT)
				ISHALT=HALT();
				break;		
		}
	}
	
	//OUTPUT
	for(i=0;i<8;i++){
		printf("R%d = x%04hX\n",i,R[i]);
	}
	
	return 0;
}


void BR(void){
	int i;
	signed short PCoffset=0;
	if((CC<0&&IR[4]=='1')||(CC==0&&IR[5]=='1')||(CC>0&&IR[6]=='1')){
		if(IR[7]=='0'){
			for(i=8;i<16;i++){
				PCoffset=PCoffset*2+IR[i]-'0';
			}
		}else{
			for(i=0;i<7;i++){
				PCoffset=PCoffset*2+1;				//����λ��չ 
			}
			for(i=7;i<16;i++){
				PCoffset=PCoffset*2+IR[i]-'0';
			}
		}
		PC=PC+PCoffset;
	}

}


void ADD(void){
	int DR,SR1,SR2,i;
	signed short imm=0;
	//����DR 
	DR=0;
	for(i=4;i<=6;i++){
		DR=DR*2+IR[i]-'0';
	}
	//����SR1
	SR1=0; 
	for(i=7;i<=9;i++){
		SR1=SR1*2+IR[i]-'0';
	}
	
	if(IR[10]=='0'){
		//����SR2
		SR2=0; 
		for(i=13;i<=15;i++){
			SR2=SR2*2+IR[i]-'0';
		}
		R[DR]=R[SR1]+R[SR2];
	}else{
		if(IR[11]=='0'){
			for(i=12;i<16;i++){
				imm=imm*2+IR[i]-'0';
			}
		}else{
			//����λ��չ 
			for(i=1;i<=11;i++){
				imm=imm*2+1;
			}
			for(i=11;i<16;i++){
				imm=imm*2+IR[i]-'0';
			}
		}
		R[DR]=R[SR1]+imm;
	}
	//sec CC
	CC=R[DR];
}


void LD(void){
	int DR,i;
	unsigned short k;
	signed short PCoffset=0;
	//����DR 
	DR=0;
	for(i=4;i<=6;i++){
		DR=DR*2+IR[i]-'0';
	}
	//���� PCoffset
	if(IR[7]=='0'){
		for(i=8;i<16;i++){
			PCoffset=PCoffset*2+IR[i]-'0';
		}
	}else{
		for(i=0;i<7;i++){
			PCoffset=PCoffset*2+1;				//����λ��չ
		}
		for(i=7;i<16;i++){
			PCoffset=PCoffset*2+IR[i]-'0';
		}
	}
	k=PC+PCoffset;
	
	R[DR]=0;
	for(i=0;i<16;i++){
		R[DR]=R[DR]*2+MEMORY[k][i]-'0';
	}
	CC=R[DR];
}


void ST(void){
	int SR,i;
	unsigned short k,temp;
	signed short PCoffset=0;
	//����SR 
	SR=0;
	for(i=4;i<=6;i++){
		SR=SR*2+IR[i]-'0';
	}
	//���� PCoffset
	if(IR[7]=='0'){
		for(i=8;i<16;i++){
			PCoffset=PCoffset*2+IR[i]-'0';
		}
	}else{
		for(i=0;i<7;i++){
			PCoffset=PCoffset*2+1;				//����λ��չ
		}
		for(i=7;i<16;i++){
			PCoffset=PCoffset*2+IR[i]-'0';
		}
	}
	k=PC+PCoffset;
	
	temp=(unsigned short)R[SR];
	for(i=0;i<16;i++){
		MEMORY[k][15-i]=temp%2+'0';
		temp=temp/2;
	}
}


void JSR(void){
	int i,BaseR;
	unsigned short temp;
	signed short PCoffset=0;
	temp=PC;
	//����BaseR 
	BaseR=0;
	for(i=7;i<=9;i++){
		BaseR=BaseR*2+IR[i]-'0';
	}
	
	if(IR[4]=='0'){
		PC=(unsigned short)R[BaseR];
	}else{
		 //���� PCoffset
		if(IR[5]=='0'){
			for(i=6;i<16;i++){
				PCoffset=PCoffset*2+IR[i]-'0';
			}
		}else{
			for(i=0;i<5;i++){
				PCoffset=PCoffset*2+1;				//����λ��չ
			}
			for(i=5;i<16;i++){
				PCoffset=PCoffset*2+IR[i]-'0';
			}	
		}
		PC=PC+PCoffset;
	}
	
	R[7]=(signed short)temp;
}


void AND(void){
	int DR,SR1,SR2,i;
	signed short imm=0;
	DR=SR1=SR2=0;
	//����DR 
	for(i=4;i<=6;i++){
		DR=DR*2+IR[i]-'0';
	}
	//����SR1
	for(i=7;i<=9;i++){
		SR1=SR1*2+IR[i]-'0';
	}
	if(IR[10]=='0'){
		//����SR2 
		for(i=13;i<=15;i++){
			SR2=SR2*2+IR[i]-'0';
		}
		R[DR]=R[SR1]&R[SR2];
	}else{
		if(IR[11]=='0'){
			for(i=12;i<16;i++){
				imm=imm*2+IR[i]-'0';
			}
		}else{
			//����λ��չ 
			for(i=1;i<=11;i++){
				imm=imm*2+1;
			}
			for(i=11;i<16;i++){
				imm=imm*2+IR[i]-'0';
			}
		}
		R[DR]=R[SR1]&imm;
	}
	//sec CC
	CC=R[DR];
}


void LDR(void){
	int i,BaseR,DR;
	unsigned short k;
	signed short offset=0;
	//���� DR 
	DR=0;
	for(i=4;i<=6;i++){
		DR=DR*2+IR[i]-'0';
	}
	//���� BaseR 
	BaseR=0;
	for(i=7;i<=9;i++){
		BaseR=BaseR*2+IR[i]-'0';
	}
	//���� offset
	if(IR[10]=='0'){
		for(i=11;i<16;i++){
			offset=offset*2+IR[i]-'0';
		}
	}else{
		for(i=0;i<10;i++){
			offset=offset*2+1;				//����λ��չ
		}
		for(i=10;i<16;i++){
			offset=offset*2+IR[i]-'0';
		}
	}
	k=(unsigned short)R[BaseR]+offset;
	
	R[DR]=0;
	for(i=0;i<16;i++){
		R[DR]=R[DR]*2+MEMORY[k][i]-'0';
	}
	CC=R[DR];
}


void STR(void){
	int i,BaseR,SR;
	unsigned short k,temp;
	signed short offset=0;
	//���� SR 
	SR=0;
	for(i=4;i<=6;i++){
		SR=SR*2+IR[i]-'0';
	}
	//���� BaseR 
	BaseR=0;
	for(i=7;i<=9;i++){
		BaseR=BaseR*2+IR[i]-'0';
	}
	//���� offset
	if(IR[10]=='0'){
		for(i=11;i<16;i++){
			offset=offset*2+IR[i]-'0';
		}
	}else{
		for(i=0;i<10;i++){
			offset=offset*2+1;				//����λ��չ
		}
		for(i=10;i<16;i++){
			offset=offset*2+IR[i]-'0';
		}
	}
	k=(unsigned short)R[BaseR]+offset;
	
	temp=(unsigned short)R[SR];
	for(i=0;i<16;i++){
		MEMORY[k][15-i]=temp%2+'0';
		temp=temp/2;
	}
}


void NOT(void){
	int i,DR,SR;
	//���� DR 
	DR=0;
	for(i=4;i<=6;i++){
		DR=DR*2+IR[i]-'0';
	}
	//���� SR 
	SR=0;
	for(i=7;i<=9;i++){
		SR=SR*2+IR[i]-'0';
	}
	
	R[DR]=~R[SR];
	CC=R[DR];
}


void LDI(void){
	int i,DR;
	unsigned short k1,k2;
	signed short PCoffset=0;
	//���� DR 
	DR=0;
	for(i=4;i<=6;i++){
		DR=DR*2+IR[i]-'0';
	} 
	//���� PCoffset
	if(IR[7]=='0'){
		for(i=8;i<16;i++){
			PCoffset=PCoffset*2+IR[i]-'0';
		}
	}else{
		for(i=0;i<7;i++){
			PCoffset=PCoffset*2+1;				//����λ��չ
		}
		for(i=7;i<16;i++){
			PCoffset=PCoffset*2+IR[i]-'0';
		}
	}
	k1=PC+PCoffset;
	k2=0;
	for(i=0;i<16;i++){
		k2=k2*2+MEMORY[k1][i]-'0';
	}
	
	R[DR]=0;
	for(i=0;i<16;i++){
		R[DR]=R[DR]*2+MEMORY[k2][i]-'0';
	}
	CC=R[DR];
}


void STI(void){
	int i,SR;
	unsigned short k1,k2,temp;
	signed short PCoffset=0;
	//���� SR 
	SR=0;
	for(i=4;i<=6;i++){
		SR=SR*2+IR[i]-'0';
	} 
	//���� PCoffset
	if(IR[7]=='0'){
		for(i=8;i<16;i++){
			PCoffset=PCoffset*2+IR[i]-'0';
		}
	}else{
		for(i=0;i<7;i++){
			PCoffset=PCoffset*2+1;				//����λ��չ
		}
		for(i=7;i<16;i++){
			PCoffset=PCoffset*2+IR[i]-'0';
		}
	}
	k1=PC+PCoffset;
	k2=0;
	for(i=0;i<16;i++){
		k2=k2*2+MEMORY[k1][i]-'0';
	}
	
	temp=(unsigned short)R[SR];
	for(i=0;i<16;i++){
		MEMORY[k2][15-i]=temp%2+'0';
		temp=temp/2;
	}
}


void JMP(void){
	int i,BaseR;
	//���� BaseR 
	BaseR=0;
	for(i=7;i<=9;i++){
		BaseR=BaseR*2+IR[i]-'0';
	}
	PC=(unsigned short)R[BaseR];
}


void LEA(void){
	int i,DR;
	signed short PCoffset=0;
	//���� DR 
	DR=0;
	for(i=4;i<=6;i++){
		DR=DR*2+IR[i]-'0';
	} 
	//���� PCoffset
	if(IR[7]=='0'){
		for(i=8;i<16;i++){
			PCoffset=PCoffset*2+IR[i]-'0';
		}
	}else{
		for(i=0;i<7;i++){
			PCoffset=PCoffset*2+1;				//����λ��չ
		}
		for(i=7;i<16;i++){
			PCoffset=PCoffset*2+IR[i]-'0';
		}
	}
	
	R[DR]=(signed short)PC+PCoffset;
}


int HALT(void){
	int ishalt;
	ishalt=0;
	return ishalt;
}
