#pragma once
#include <iostream>
#include <stdlib.h>

//Define the maximum level of the skip list to avoid wasting space
#define MAXLEVEL 16

using namespace std;

//Node structure
typedef struct node {
	int val;
	struct node* next[1];//Multi-layer linked list nodes
} Node;

//skip list struct
typedef struct skiplist {
	int level;//Maximum number of layers
	Node* head;//Head node
}Skiplist;

//skip list node constructor
Node* createnode(int nodelevel, int nodeval) {
	//Dynamically allocate linked list nodes with a nodelevel number of layers
	Node* p = (Node*)malloc(sizeof(Node) + nodelevel * sizeof(Node*));
	//Determine whether the dynamic allocation is successful
	if (p == NULL) {
		return NULL;
	}
	//initialize
	p->val = nodeval;
	for (int i = 0; i < nodelevel; i++) {
		p->next[i] = NULL;
	}
	return p;
}

//The skip list constructor
Skiplist* createlist() {
	Skiplist* sl = (Skiplist*)malloc(sizeof(Skiplist));
	//Determine whether the dynamic allocation is successful
	if (sl == NULL) {
		return NULL;
	}
	sl->level = 1;//The initialization level is 0
	//Create a head node
	Node* header = createnode(MAXLEVEL, 0);
	//Determine whether the head node is created successfully
	if (header == NULL) {
		free(sl);
		return NULL;
	}
	//Assign the created head node to the skip list
	sl->head = header;
	return sl;
}

//Generate a random number of layers
/* If the generated random number is even, let level be incremented by one until the generated random number is odd */
int randlevel() {
	int level = 1;
	//Use whether the generated random number is even to determine the size of the level
	while (rand() % 2 == 0) {
		level++;
	}
	if (level > MAXLEVEL) {
		level = MAXLEVEL;
	}
	return level;
}

//insert operation
/*
1: Find the position to be inserted, each layer followed by the new insert array;
2: Need to randomly generate a number of layers;
3: Insert from high level to bottom, exactly the same as the insertion of ordinary linked list;
*/
bool Insert(Skiplist* sl, int val) {

	Node* insert[MAXLEVEL];	//Record where each layer might insert new nodes
	for (int i = 0; i < MAXLEVEL; i++) {
		insert[i] = NULL;
	}
	Node* front = sl->head;
	Node* tail = NULL;
	for (int i = sl->level - 1; i >= 0; i--) {
		tail = front->next[i];
		while (tail != NULL && val > tail->val) {
			front = tail;
			tail = tail->next[i];
		}
		//Determine whether a node with the same value already exists
		if (tail != NULL && val == tail->val) {
			cout << "不能插入相同的结点" << endl;
			return false;
		}
		//Mark the nodes that each layer traverses down
		insert[i] = front;
	}
	//Generate a random number of layers
	int nodelevel = randlevel();
	//Use the generated random number of layers to create a new node
	Node* p = createnode(nodelevel, val);
	if (p == NULL) {
		cout << "新节点生成失败！" << endl;
		return false;
	}
	/* If the number of layers generated is greater than the number of layers of the skip list,
	the skip list must be updated */
	if (nodelevel > sl->level) {
		/* The index value of the insert array higher than the original number of layers
		should be set to sl->head */
		for (int i = sl->level; i < nodelevel; i++) {
			insert[i] = sl->head;
		}
		//Update the top level of the skip list
		sl->level = nodelevel;
	}
	//Inserts are made from highest to lowest in terms of the number of layers generated
	for (int i = nodelevel - 1; i >= 0; i--) {
		if (insert[i] != NULL) {
			p->next[i] = insert[i]->next[i];
			insert[i]->next[i] = p;
		}
	}
	return true;
}

//delete operation
/*
1. Find the position of this element in the skip list, and if not, exit
2. Remove the entire column containing the element from the table
3. Remove the extra "empty chain"
*/
bool Delete(Skiplist* sl, int val) {
	Node* mydelete[MAXLEVEL]; //Record where each layer might delete nodes
	Node* front = sl->head;
	Node* tail = NULL;
	for (int i = sl->level - 1; i >= 0; i--) {
		tail = front->next[i];
		while (tail != NULL && val > tail->val) {
			front = tail;
			tail = tail->next[i];
		}
		//Mark the nodes that each layer traverses down
		mydelete[i] = front;
	}
	if (tail == NULL || (tail != NULL && tail->val != val)) {
		cout << "要删除的结点不存在！" << endl;
		return false;
	}
	//The node to be deleted is tail
	for (int i = sl->level - 1; i >= 0; i--) {
		if (mydelete[i]->next[i] == tail) {
			mydelete[i]->next[i] = tail->next[i];
			//Determine whether the top-level node has been deleted
			if (sl->head->next[i] == NULL) {
				sl->level--;
			}
		}
	}
	//Free up space for deleted nodes
	free(tail);
	return true;
}

//search operation
/*
1. Start at the beginning of the topmost chain.

2. Suppose the current position is p, the node it points to the right is q (p and q are not necessarily adjacent),
   and the value of q is y. Compare y to x

(1) x=y outputs the success of the query and related information
(2) x>y moves from p to the right to the q position
(3) x<y moves down one block from p

3. If the current position is in the bottom chain and it has to be moved down, the output query fails

*/
Node* search(Skiplist* sl, int val) {
	Node* front = sl->head;
	Node* tail;
	for (int i = sl->level - 1; i >= 0; i--) {
		tail = front->next[i];
		while (tail != NULL && val > tail->val) {
			front = tail;
			tail = tail->next[i];
		}
		//Check whether the queried node has been found
		if (tail!=NULL && tail->val == val) {
			return tail;
		}
	}
	//In the end, it did not quit, indicating that the node was not found
	return NULL;
}

//Destroy the generated skip list
/* Starting at the bottom of the skip list, ism releases the nodes in it */
void freesl(Skiplist* sl) {
	//First determine whether sl is already empty
	if (sl == NULL) {
		return;
	}
	Node* front = sl->head;
	Node* tail;
	while (front != NULL) {
		tail = front->next[0];
		free(front);
		front = tail;
	}
	//After releasing all nodes, release the skip list itself
	free(sl);
}
