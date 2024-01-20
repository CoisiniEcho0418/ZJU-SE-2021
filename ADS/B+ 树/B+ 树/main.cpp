#include<stdio.h>
#include<stdlib.h>

struct Node
{
	struct Node* left;
	struct Node* mid;
	struct Node* right;
	int val[3], vnum, pnum;//vnum：值的数量，pnum：子节点的数量
	bool flag;//判断是不是叶子结点

};

struct BTree {
	struct Node* root;//根节点
	struct Node* firstleave;//第一个叶节点
};

Node* stack[10000];//记录插入操作的路径
Node** stackptr = stack - 1;
bool push(Node* p) {
	if (stackptr == stack + 10000) {
		return false;//堆栈已满
	}
	else {
		stackptr++;
		*stackptr = p;
		return true;
	}
	
}
Node* pop() {
	if (stackptr == stack - 1) {
		return NULL;//堆栈是空的
	}
	else {
		return *(stackptr--);
	}
}

Node* search(int x, BTree tree) {
	Node* p = tree.firstleave;
	while (p != NULL) {
		if (x != p->val[0] && x != p->val[1] && x != p->val[2]) {
			p = p->right;
		}
		else {
			return p;
		}
	}
	return NULL;
}

Node* findpos(int x, BTree tree) {
	Node* p = tree.root;
	while (p->flag==false) {//不是叶子节点
		push(p);
		if (p->pnum == 2) {
			if (x < p->val[1]) {
				
				p = p->left;
			}
			else {
				
				p = p->mid;
			}
		}
		else if (p->pnum == 3) {
			if (x < p->val[1]) {
				p = p->left;
			}else if (x >= p->val[1] && x < p->val[2]) {
				p = p->mid;
			}
			else {
				p = p->right;
			}
		}
	}
	return p;
}

int min(int a, int b) {
	return a < b ? a : b;
}

int min3(int a, int b, int c) {
	if (b >= a && c >= a ) {
		return a;
	}
	else if (a >= b && c >= b ) {
		return b;
	}
	else {
		return c;
	}
}

int max(int a, int b) {
	return a > b ? a : b;
}

int max3(int a, int b,int c) {
	if (b <= a && c <= a) {
		return a;
	}
	else if (a <= b && c <= b) {
		return b;
	}
	else {
		return c;
	}
}

int mid(int a, int b, int c) {
	if (b >= a && a >= c || c >= a && a >= b) {
		return a;
	}
	else if (a >= b && b >= c || c >= b && b >= a) {
		return b;
	}
	else {
		return c;
	}
}

void InnerSort3(Node* a, Node* b, Node* c, Node* root) {
	Node* t;
	if (a->val[0] < b->val[0]) { t = a; a = b; b = t; }
	if (a->val[0] < c->val[0]) { t = a; a = c; c = t; }
	if (b->val[0] < c->val[0]) { t = b; b = c; c = t; }
	root->left = c; root->mid = b; root->right = a;
}
void InnerSort4(Node* a, Node* b, Node* c, Node* d, Node* root2, Node* root1) {
	Node* t;
	if (a->val[0] < b->val[0]) { t = a; a = b; b = t; }
	if (a->val[0] < c->val[0]) { t = a; a = c; c = t; }
	if (a->val[0] < d->val[0]) { t = a; a = d; d = t; }
	if (b->val[0] < c->val[0]) { t = b; b = c; c = t; }
	if (b->val[0] < d->val[0]) { t = b; b = d; d = t; }
	if (c->val[0] < d->val[0]) { t = c; c = d; d = t; }
	root1->left = d; root1->mid = c; root2->left = b; root2->mid = a;
}

bool InnerInsert(Node* newroot, Node* curnode, BTree* tree);

bool insert(int x,BTree* tree) {//传入指针参数，以便在函数中修改B+树
	if ((*tree).root == NULL) {
		(*tree).root = (*tree).firstleave=(Node*)malloc(sizeof(Node));
		(*tree).root->flag = true;
		(*tree).root->left = (*tree).root->mid = (*tree).root->right = NULL;
		(*tree).root->pnum = 0;
		(*tree).root->val[0] = x;
		(*tree).root->val[1] = (*tree).root->val[2] = -1;//-1表示空
		(*tree).root->vnum = 1;
	}

	if (search(x, *tree)) {
		return false;
	}

	Node* p = findpos(x, *tree);
	if (p->vnum == 1) {
		int t = p->val[0];
		p->val[0] = min(t, x);
		p->val[1] = max(t, x);
		p->vnum = 2;
	}
	else if (p->vnum == 2) {
		int t1 = p->val[0];
		int t2 = p->val[1];
		p->val[0] = min3(t1,t2, x);
		p->val[1] = mid(t1, t2,x);
		p->val[2] = max3(t1,t2, x);
		p->vnum = 3;
	}
	else {//split
		Node* q = (Node*)malloc(sizeof(Node));
		q->flag = true;
		q->pnum = 0;
		q->left = q->mid = NULL;
		q->right = p->right;
		p->right = q;

		//对key值排序
		int t1 = p->val[0], t2 = p->val[1], t3 = p->val[2],t4=x;
		int t;
		if (t1 > t4) { t = t1; t1 = t4; t4 = t; }
		if (t1 > t2) { t = t1; t1 = t2; t2 = t; }
		if (t1 > t3) { t = t1; t1 = t3; t3 = t; }
		if (t2 > t4) { t = t2; t2 = t4; t4 = t; }
		if (t2 > t3) { t = t2; t2 = t3; t3 = t; }
		if (t3 > t4) { t = t3; t3 = t4; t4 = t; }
		p->val[0] = t1;
		p->val[1] = t2;
		p->val[2] = -1;
		q->val[0] = t3;
		q->val[1] = t4;
		q->val[2] = -1;
		p->vnum = q->vnum = 2;


		Node* parent = pop();
		if (parent == NULL) {
			Node* newnode = (Node*)malloc(sizeof(Node));
			newnode->val[0] = p->val[0];
			newnode->val[1] = q->val[0];
			newnode->val[2] = -1;
			newnode->flag = false;
			newnode->left = p;
			newnode->mid = q;
			newnode->right = NULL;
			newnode->pnum = 2;
			newnode->vnum = 2;
		}
		else {
			InnerInsert(q, parent, tree);//递归调用
		}
		

	}

	//更新路径上的节点信息
	Node* temp;
	while (temp = pop()) {
		if (temp->pnum >= 1) temp->val[0] = temp->left->val[0];
		if (temp->pnum >= 2) temp->val[1] = temp->left->val[0];
		if (temp->pnum >= 3) temp->val[2] = temp->left->val[0];
	}

	return true;

}
bool InnerInsert(Node* newroot, Node* curnode, BTree* tree) {
	if (curnode->pnum == 2) {
		InnerSort3(curnode->left, curnode->mid, newroot,curnode);
		curnode->val[0] = curnode->left->val[0];
		curnode->val[1] = curnode->mid->val[0];
		curnode->val[2] = curnode->right->val[0];
		curnode->pnum = 3;
	}
	else {
		Node* temp = (Node*)malloc(sizeof(Node));
		temp->flag = false;
		temp->right = NULL;
		InnerSort4(curnode->left, curnode->mid, curnode->right, newroot,temp, curnode);
		temp->pnum = curnode->pnum = 2;

		//更新父节点的索引值
		temp->val[0] = temp->left->val[0];
		temp->val[1] = temp->mid->val[0];
		temp->val[2] = -1;
		curnode->val[0] = curnode->left->val[0];
		curnode->val[1] = curnode->mid->val[0];
		curnode->val[2] = -1;


		Node* parent = pop();
		if (parent == NULL) {
			Node* newnode = (Node*)malloc(sizeof(Node));
			newnode->val[0] = curnode->val[0];
			newnode->val[1] = temp->val[0];
			newnode->val[2] = -1;
			newnode->flag = false;
			newnode->left = curnode;
			newnode->mid = temp;
			newnode->right = NULL;
			newnode->pnum = 2;
			newnode->vnum = 2;
		}
		else {
			InnerInsert(temp, parent, tree);//递归调用
		}

		
	}

	return true;
}

int main() {
	int n,i;
	BTree tree;
	tree.firstleave = tree.root = NULL;
	scanf_s("%d", &n);
	int val[10000] = { 0 };
	for (i = 0; i < n; i++) {
		scanf_s("%d", &val[i]);
	}

	for (i = 0; i < n; i++) {
		if (insert(val[i], &tree) == false) {
			printf_s("Key %d is duplicated\n", val[i]);
		}
	}

	Node* p = tree.root;
	while (!p) {
		for (int i = 0; i < p->pnum;i++) {
			printf_s("[");

		}
	}




}