#include <iostream>
#include <cstdio>
using namespace std;

struct AVLTreeNode
{
    int val;             //值
    int height;         //高度
    AVLTreeNode* left = NULL;  //左节点
    AVLTreeNode* right = NULL; //右节点
    AVLTreeNode(int v) :val(v), height(1) {}
};

int max(int a, int b) {
    if (a >= b) {
        return a;
    }
    else {
        return b;
    }
}

int get_height(AVLTreeNode* t) {
    if (t == NULL) {
        return 0;
    }
    else {
        return max(get_height(t->left), get_height(t->right)) + 1;
    }
}

AVLTreeNode* LL_Rotation(AVLTreeNode* t) {
    AVLTreeNode* temp = t->left;
    t->left = (t->left)->right;
    temp->right = t;
    t->height = max(get_height(t->left), get_height(t->right)) + 1;
    temp->height = max(get_height(temp->left), get_height(temp->right)) + 1;
    return temp;
}

AVLTreeNode* RR_Rotation(AVLTreeNode* t) {
    AVLTreeNode* temp = t->right;
    t->right = (t->right)->left;
    temp->left = t;
    t->height = max(get_height(t->left), get_height(t->right)) + 1;
    temp->height = max(get_height(temp->left), get_height(temp->right)) + 1;
    return temp;
}

AVLTreeNode* LR_Rotation(AVLTreeNode* t) {
    AVLTreeNode* temp = t->left->right;
    t->left->right = temp->left;
    temp->left = t->left;
    t->left->height = get_height(t->left);
    temp->height = get_height(temp);
    t->left = temp->right;
    temp->right = t;
    t->height = get_height(t);
    temp->height = get_height(temp);
    return temp;
}

AVLTreeNode* RL_Rotation(AVLTreeNode* t) {
    AVLTreeNode* temp = t->right->left;
    t->right->left = temp->right;
    temp->right = t->right;
    t->right->height = get_height(t->right);
    temp->height = get_height(temp);
    t->right = temp->left;
    temp->left = t;
    t->height = get_height(t);
    temp->height = get_height(temp);
    return temp;
}

//递归实现AVL树的插入
AVLTreeNode* insert(AVLTreeNode* t, int v) {
    if (t == NULL) {
        t = new AVLTreeNode(v);
        return t;
    }
    else if (v < t->val) {
        t->left = insert(t->left, v);//递归
        //判断是否要修正
        if (get_height(t->left) - get_height(t->right) == 2) {
            if (v < (t->left)->val) {
                t = LL_Rotation(t);
            }
            else {
                t = LR_Rotation(t);
            }
        }
    }
    else {
        t->right = insert(t->right, v);
        if (get_height(t->right) - get_height(t->left) == 2) {
            if (v > (t->right)->val) {
                t = RR_Rotation(t);
            }
            else {
                t = RL_Rotation(t);
            }
        }
    }

    t->height = max(get_height(t->left), get_height(t->right)) + 1;
    return t;
}

int main() {
    int n, val, i;
    cin >> n;
    AVLTreeNode* root = NULL;
    for (i = 1; i <= n; i++) {
        cin >> val;
        root = insert(root, val);
    }
    cout << (root->val);
}