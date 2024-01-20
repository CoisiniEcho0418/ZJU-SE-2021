#include <stdio.h>
#include <stdlib.h>

// Define colors for the Red-Black Tree
#define RED 0
#define BLACK 1

// Structure for a Red-Black Tree node
typedef struct RBTreeNode {
    int value;              // Node's key
    int color;            // Node's color, can be red (RED) or black (BLACK)
    struct RBTreeNode* left;    // Left child
    struct RBTreeNode* right;   // Right child
} Node;

// Build Red-Black Tree
Node* buildRBTree(int *node, int size);
// Create a new node
Node* createNode(int key, int color);
// Insert a node into a RBTree and return the root of the RBTree
Node* insertNode(Node* root, Node* node);
// Check if a Binary-Tree is RBTree (1:true 0:false)
int checkRBTree(Node* root, int* blackHeight);
// Free the memory allocated for Red-Black tree nodes
void freeNodeSpace(Node* root);

int main(void){
	int k,n; // k:total number of cases; n: the total number of nodes in the binary tree
	int i,j; 
	printf("Input k: ");
	scanf("%d",&k);
	for(i=0;i<k;i++){
		// Input n
		printf("Input n: ");
		scanf("%d",&n);
		// Allocate a dynamic array of integers using malloc
		int* nodeArray = (int*)malloc(n * sizeof(int));
		if (nodeArray == NULL) {
			printf("Memory allocation failed.\n");
			return 1;
		}
		// Define the root of a RBTree
		Node* root = NULL;
		// Accept user input to initialize the array.
		printf("Input n integers: ");
		for(j=0;j<n;j++){
			scanf("%d",&nodeArray[j]);
		}
		root=buildRBTree(nodeArray,n);
		int blackHeight=0;
		// First check if the root is RED 
		if(root!=NULL&&root->color==RED){
			printf("Results: \n");
			printf("No\n");
			printf("\n");
		}else if(checkRBTree(root,&blackHeight)){
			printf("Results: \n");
			printf("Yes\n");
			printf("\n");
		}else{
			printf("Results: \n");
			printf("No\n");
			printf("\n");
		}

		// Free the allocated memory 
		freeNodeSpace(root);
		free(nodeArray);
	}
}

// Build Red-Black Tree
Node* buildRBTree(int *node, int size){
	int color = 0;
	int value = 0;
	int i;
	Node* root=NULL;
	for(i=0;i<size;i++){
		// Determine the color of the node based on its sign form.
		if(node[i]<0){
			color = RED;
			value=-node[i];
		}else{
			color=BLACK;
			value=node[i];
		}
		// Call functions to create nodes and insert nodes to build a Red-Black tree.
		Node* node = createNode(value,color);
		root=insertNode(root,node);
	}
	return root;
}

// Create a new node
Node* createNode(int value, int color) {
    Node* newNode = (Node*)malloc(sizeof(struct RBTreeNode));
    newNode->value = value;
    newNode->color = color;
    newNode->left = NULL;
    newNode->right = NULL;
    return newNode;
}

// Insert node into a RBTree and return the root of the RBTree
Node* insertNode(Node* root, Node* node){
	if(root==NULL){
		return node;
	}
	if((node->value<root->value)&&(root->left==NULL)){
		root->left=node;
		return root;
	}
	if((node->value>root->value)&&(root->right==NULL)){
		root->right=node;
		return root;
	}
	// recursive insertion
	if(node->value<root->value){
		root->left=insertNode(root->left,node);
		return root;
	}
	if(node->value>root->value){
		root->right=insertNode(root->right,node);
		return root;
	}
}

// Check if a Binary-Tree is RBTree (1:true 0:false)
/* Tips:
The root node here is not the actual root node of the Red-Black tree; 
the root node for any subtree can be the parameter 'root' for this function.
*/
int checkRBTree(Node* root, int* blackHeight){
	// 1. First, check if the node is empty.
	if(root==NULL){
		*blackHeight=0;
		return 1;
	}
	// 2. Second, Second, if the current root node's color is red at this point, 
	// then check if the colors of its two child nodes are also red.
	if(root->color==RED){
		if((root->left!=NULL)&&((root->left)->color==RED)){
			return 0;
		}
		if((root->right!=NULL)&&((root->right)->color==RED)){
			return 0;
		}
	}
	// 3. Third, recursively check whether the left and right subtrees also satisfy 
	// the properties of a Red-Black tree and pass the black height of the left and 
	// right subtrees to the calling function using pointer parameters.
	int leftBlackHeight=0;
	int rightBlackHeight=0;
	if(!checkRBTree(root->left,&leftBlackHeight)){
		return 0;
	}
	if(!checkRBTree(root->right,&rightBlackHeight)){
		return 0;
	}
	// Check if the black heights of the left and right subtrees are equal.
	if(leftBlackHeight!=rightBlackHeight){
		return 0;
	}
	// 4. Pass the black height of the current node to the parent node using a pointer.
	if(root->color==BLACK){
		*blackHeight+=leftBlackHeight+1;
	}else{
		*blackHeight=leftBlackHeight;
	}
	return 1;
}


// Free the memory allocated for Red-Black tree nodes
void freeNodeSpace(Node* root){
	if(root==NULL){
		return;
	}
	// Add conditional checks, reduce additional stack overhead, and save memory space
	if(root->left==NULL){
		freeNodeSpace(root->right);
		free(root);
		return;
	}
	// Add conditional checks, reduce additional stack overhead, and save memory space
	if(root->right==NULL){
		freeNodeSpace(root->left);
		free(root);
		return;
	}
	// Recursively release the memory allocated to nodes 
	// (first left subtree, then right subtree, and finally the root node).
	freeNodeSpace(root->left);
	freeNodeSpace(root->right);
	free(root);
	return;
}

