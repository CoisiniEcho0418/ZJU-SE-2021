#include <iostream>
#include <vector>
#define MAXN 105
#define MAXT 62
#define INF (1<<30)
using namespace std;
bool flag = false;  /* indicates whether we have found a answer. */
int N, ans, min_extra = INF, min_left = INF;   
vector<int>a[MAXN]; 
int Hash[MAXN][MAXT], target_beads[MAXT];  /* target_beads, Hash[k] are used to record amounts of beads with the same color in the string. */
/*
Here we transfer char to int so that we can use it as the index of array.
(Obviously we can use the container map, but it will spend much time so we give up it.)
*/
inline int CharToInt(char ch) 
{
    if (ch >= '0' && ch <= '9') return ch - '0';    /* 0~9 */
    if (ch >= 'a' && ch <= 'z') return ch - 'a' + 10;   /* 10~35 */
    if (ch >= 'A' && ch <= 'Z') return ch - 'A' + 36;   /* 36~61*/
//     return -1;
}
/*
k - the k-th string
extra - The extra strings that we need to buy to provide the beads that Eva needs. We need to find the least number of extra beads Eva has to buy when answer is YES.
left - How many beads that Eva still need to buy more strings to obtain them. We need to find the least number of beads missing from all the strings when answer is NO.
*/
void DFS(int k, int extra, int left) 
{
    if (extra >= min_extra) return;  /* Pruning 1: The "extra" must be nondecresing. So if the current "extra" has been bigger than the existing answer, then there is no need to search this branch further. */

    if (!left)      /* Pruning 2: left=0 indicates that we have gotten all beads she needs in the previous strings. Then there is no need to go continue. */
    {   
        flag = true;
        min_extra = extra;
        return;
    }

    if (k == N)     /* We have reached the Boundary. */
    {
        if (min_left > left)    /* We want the left beads as small as possible. */
            min_left = left;
        return;
    }
    int save_extra = extra, save_left = left;
    /* To buy */
    bool bj = false;
    int i, delta[MAXT] = {0};   /* To record the changed amounts of the beads, so that we can restore them when backtracking. */
    for (auto i : a[k]) {
        if (target_beads[i]) {
            if (Hash[k][i] >= target_beads[i]) {    /* If for this color, the string have more beads than Eva needs, then the more beads will be extra beads. */
                delta[i] = target_beads[i];
                left -= delta[i];
                extra += Hash[k][i] - target_beads[i];
            }
            else {      /* If for this color, the string have less beads than Eva needs, then we just need to use up all beads. */
                delta[i] = Hash[k][i];
                left -= delta[i];
            }
            bj = true;      /* bj is used to indicate whether this string can cut down the amount that we still need to buy. Designed for Pruning 3.*/
        }
        else {
            extra += Hash[k][i];
        }
    }

    /* Pruning 3: If buying this string will have no benefit on the beads that Eva want to buy, then we will not search further again. Since the effect to buy is the same as not to buy. */
    if (bj) {
        /* Suppose we choose this string, then we can modify the beads that we still need to buy. */
        for (i = 0; i < MAXT; i++) {
            target_beads[i] -= delta[i];
        }

        DFS(k+1, extra, left);

        /* Backtracking, restoring to the state before we modify. */
        for (i = 0; i < MAXT; i++) {
            target_beads[i] += delta[i];
        }
    }

    /* Pruning 4: Modify the searching order: first we suppose to buy this string, then we search for the situation that we don't buy it. The advantage of the modified order is that if the answer is in the shallow layer of searching tree, we needn't spend much time useless branches. */

    /* Not to buy */
    DFS(k+1, save_extra, save_left);

    return;
}
int main()
{
    string target, s;
    cin >> target >> N;
    int i, j, len;  
    len = target.length();
    for (i = 0; i < len; i++) 
        target_beads[CharToInt(target[i])]++;   /* record amounts of beads with the same color in the Eva's string. */
    
    for (i = 0; i < N; i++) {
        cin >> s;
        len = s.length();
        for (j = 0; j < len; j++) {
            Hash[i][CharToInt(s[j])]++; /* record amounts of beads with the same color in one string. */
        }
        for (j = 0; j < MAXT; j++)
            if (Hash[i][j]) a[i].push_back(j);
    }
    double st = clock();    /* Record the start time. */
    DFS(0, 0, target.length());
    if (flag) cout << "Yes " << min_extra << endl;
    else cout << "No " << min_left << endl;
    double ed = clock();    /* Record the end time. */ 
    cout << "TIME: " << (ed - st) / CLOCKS_PER_SEC << endl;
    return 0;
}