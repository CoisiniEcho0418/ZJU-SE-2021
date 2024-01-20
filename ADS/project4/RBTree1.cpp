/*
Algorithm idea: Assuming that the root node of the red-black tree can be either red or black, then:
1. A red-black tree with a black root node, its left and right subtrees may be: two black-root red-black trees with a height minus one (relative to the parent node),a red-root red-black tree with the same height as its parent node and a black-root red-black tree with a height minus one (relative to the parent node), and two red-root red-black trees with the same height as its parent node
2. A red-black tree with a red root node, and its left and right sub-trees may be: two black-rooted red-black trees with a height minus one (relative to the parent node).

If numB[i][j] is used to represent the number of black-root Red-black trees whose height is i and number of internal nodes is j, numR[i][j] represents the number of red-root Red-black trees whose height is i and number of internal nodes is j
Then there is the following recursive relationship:
numR[i][j]=SUM(numB[i][j-k-1]*numB[i][k]) (k=1,2,... j-2)
numB[i][j]=SUM((numB[i-1][j-k-1]+numR[i][j-k-1])*(numB[i-1][k]+numR[i][k])) (k=1,2,... j-2)
*/

#include<iostream>
#include<cmath>
#define mod 1000000007
using namespace std;

long long RBTree(int nodenum);//The return type is set to long long (when N is large, the int and long types will overflow)

int main(void) {
	int n;
	cin >> n;
	cout << RBTree(n);
}

long long RBTree(int nodenum) {
	int maxH = floor(log2(nodenum + 1));//Calculate the maximum height of the red-black tree when the internal node is nodenum
	//Define two two-dimensional arrays, numB[i][j] represents the number of black-root Red-Black trees with height i and number of internal nodes j, 
	// and numR[i][j] represents the number of red-root Red-Black tree with height i and internal nodes j
    long long numB[maxH+1][nodenum+1];//The storage type is also set to long long (int and long types will overflow)
    long long numR[maxH+1][nodenum+1];

	//Once the array is defined, initialize it
	for (int i = 0; i < maxH + 1; i++) {
		for (int j = 0; j < nodenum + 1; j++) {
			numB[i][j] = numR[i][j] = 0;
		}
	}
	//Initial conditions (assign initial values to numB and numR with a height of 1)
	numB[1][1] = 1; numB[1][2] = 2; numB[1][3] = 1;
	numR[1][1] = 1;

	//Filling: For any i and j, there is the following recursive relation: numR[i][j]=SUM(numB[i][j-k-1]*numB[i][k]) (k=1,2,... j-2),
	//numB[i][j]=SUM((numB[i-1][j-k-1]+numR[i][j-k-1])*(numB[i-1][k]+numR[i][k])) (k=1,2,...j-2)
	//Explanation: For a red-root red-black tree, its two child nodes must be two black-root red-black trees of the same height (relative to the height of the parent node minus one); 
	//For a black-root red-black tree, its two child nodes can be composed of two black-root red-black trees with a height minus one (relative to the height of the parent node minus one), 
	//two red-root red-black trees with the same height as the parent node, 
	//a black-root red-black tree with a height minus one (relative to the height of the parent node minus one), and a red-root red-black tree with the same height as the parent node
	for (int i = 2; i <= maxH; i++) {
		//For a red-black tree with a height of i, the minimum number of internal nodes is 2^i-1 and the maximum is 2^(2*i)-1 (the black root red-black tree is 2^(2*i)-1,
		//and the red-root red-black tree is (2^(2*i)-1)/2, whichever is greater)
		int min = int(pow(2.0, double(i))) - 1;//Minimum number of internal nodes
		int max = int(pow(2.0, double(2 * i))) - 1;//Maximum number of internal nodes
		if (max > nodenum) {//Consider the case where the maximum number of nodes overflows
			max = nodenum;
		}
		for (int j = min; j <= max; j++) {//Define min and max to reduce the number of loops
			for (int k = 1; k < j - 1; k++) {//Calculate numR[i][j] first, because numB[i][j] is calculated using numR[i][j]
				numR[i][j] += (numB[i - 1][j - k - 1] % mod) * (numB[i - 1][k] % mod);
				numR[i][j] %= mod;
			}
			for (int k = 1; k < j - 1; k++) {
				numB[i][j] += ((numB[i - 1][j - k - 1] + numR[i][j - k - 1]) % mod) * ((numB[i - 1][k] + numR[i][k]) % mod);
				numB[i][j] %= mod;
			}
		}
	}

	//Calculate results
	long long result = 0;
	for (int i = 1; i <= maxH; i++) {
		result += numB[i][nodenum] % mod;
	}
	result = result % mod;
    
	return result;
}
