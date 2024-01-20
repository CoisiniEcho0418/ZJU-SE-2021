#include <iostream>
#include<fstream>
#include<vector>
#include<queue>
#include<time.h>
#include<random>
using namespace std;
long queue_use;
long time_second;
const int INF = 0x3f3f3f3f;
// 2^30
const long CAPITAL = 1073741824;

// 点的定义，尽可能简洁，name是node的位置
// dis是距离源点的距离
struct node{
    int name;
    int dis;
    node(int n=-1,int d=INF){name=n;dis=d;}
    // 需要重载比较符号
    // 本来是最大堆，这样就是最小堆了
    bool operator <( const node &r )const{
        return  dis < r.dis ;
    }
    bool operator ==( const node &r )const{
        return dis == r.dis;
    }
    bool operator !=( const node &r )const{
        return dis != r.dis;
    }
};

// 点的定义，尽可能简洁，name是node的位置
// dis是距离源点的距离
// pri是专门改过大小的，把最大堆变成最小堆
struct node_pri{
    int name;
    int dis;
    node_pri(int n=-1,int d=INF){name=n;dis=d;}
    // 需要重载比较符号
    // 本来是最大堆，这样就是最小堆了
    bool operator <( const node_pri &r )const{
        return  dis > r.dis ;
    }
    bool operator ==( const node_pri &r )const{
        return dis == r.dis;
    }
    bool operator !=( const node_pri &r )const{
        return dis != r.dis;
    }
};

// 边的定义，尽可能简洁，仅有目的地和距离
struct edge{
    int mute;
    int distance;
    edge(int e,int d){mute=e;distance=d;}
};

/****************************************************斐波那契堆部分*****************************************************/
struct FibNode{
        // 内容是key，格式为node
        node key;
        // 左右兄的双向链表指针
        FibNode* rbro;
        FibNode* lbro;
        // 父子的指针
        FibNode* father;
        FibNode* child;
        // 节点的度
        int degree;
        // 是否失去过子
        bool mark;
        void Init();
};

// 对点进行初始化
void FibNode::Init(){
    // 左右兄都指向自己
    rbro = lbro = this;
    // 父子都为空
    father = child = NULL;
    // 节点的度为0
    degree = 0;
    // makr 也为0
    mark = false;
}

class FibHeap{
    public:
        FibHeap(){min=NULL;number=0;}
        FibNode* push(node a);
        node pop();
        bool empty();
        void decrease( FibNode* x, int k );
    private:
        // 指向最小的节点
        FibNode* min;
        // 树内的所有的点的个数
        int number;
        void cut( FibNode* x, FibNode* y );
        void cascading_cut( FibNode* y );
        void consolidate();
};

FibNode* cat_pointer( FibNode* a, FibNode* b){
    // 如果其中一个是空的
    // 直接返回
    if( a == NULL ) return b;
    if( b == NULL ) return a;
    // 定义一个暂时的指针
    FibNode* temp;
    // 将两个双向链表连接起来
    temp = a->rbro;
    a->rbro = b->rbro;
    b->rbro->lbro = a;
    b->rbro = temp;
    temp->lbro = b;
    return a;
}

// 插入操作
FibNode* FibHeap::push( node a ){
    // 新请求一个空间来存放
    FibNode* x = (FibNode*)malloc(sizeof(FibNode));
    // 初始化并赋值
    x->Init();
    x->key = a;
    // 讲x插入到森林中
    // 如果为空就直接插进去
    if( min == NULL )   min = x;
    // 否则就插入到链表中
    else{
        // 插入到root的双向链表中
        cat_pointer( min , x );
        // 更新min
        if( x->key < min->key ) min = x;
    }
    // 更新number
    number ++;
    // 返回指针方便查找
    return x;
}

// 把点从双向链表中脱除
void delete_pointer( FibNode* a ){
    // 左右子链互连
    a->lbro->rbro = a->rbro;
    a->rbro->lbro = a->lbro;
    // 左右兄连自己
    a->rbro = a->lbro = a;
    a->father = NULL;
}

// 将一个点链接到另一个的子链表中
void heap_link( FibNode* child, FibNode* father ){
    // child 脱离原来的链表
    delete_pointer( child );
    // 把child纳入farther的子链表
    father->child = cat_pointer( father->child, child );
    // 更新child的father和father的degree
    father->degree ++;
    child->father = father;
    return;
}

// 调整堆的性质
void FibHeap::consolidate(){
    // 如果min是null则不用调整
    if( min == NULL )   return ;
    // 创建新的堆来缓冲
    FibNode* A[number];
    // 清理内存
    for( int i=0; i<number; i++ )   A[i] = NULL;
    // 建立暂时的指针
    FibNode* now_pointer = min;
    // 遍历所有的root双向链表
    do{
        // 建立临时变量
        FibNode* x = now_pointer;
        int degree = x->degree;
        // 开始找A中合适的区域
        while( A[degree] != NULL ){
            // 建立临时变了
            FibNode* y = A[degree];
            // 判断谁的值更小做父
            if( y->key < x->key ){
                // 交换
                FibNode* temp = x;
                x = y;
                y = temp;
            }
            // 链接两个
            heap_link( y, x );
            // 原来的清理一下
            A[degree] = NULL;
            // 更新degree   
            degree++;
        }
        // 找到了放入
        A[degree] = x;
    }while( now_pointer != min );
    // 抹去原来的森林
    min = NULL;
    // 重新调整森林
    for( int i=0; i<number; i++ ){
        if( A[i] != NULL ){
            // 如果min还没有的话，就作为min
            if( min == NULL )   min = A[i];
            // 否则就加入min的双向链表
            else{
                cat_pointer( min, A[i] );
                // 更新min
                if( A[i]->key < min->key )  min = A[i];
            }
        }
    }
    return;
}

// 弹出最小的点
node FibHeap::pop(){
    // 先把min分离出来
    FibNode* z = min;
    // 如果堆不为空
    if( z != NULL ){
        // 把z的子都转移到root上
        while( z->degree != 0 ){
            // 标记要分离的子
            FibNode* child = z->child;
            // 子的指针指向null或右兄
            if( z->degree == 1 )    z->child = NULL;
            else    z->child = z->child->rbro;
            // 子脱离
            delete_pointer( child );
            // z的degree更新
            z->degree --;
            // 将子链接到主链上
            cat_pointer( min, child );
        }
        // 先判断min
        if( z->rbro == z )  min=NULL;
        else    min = z->rbro;
        // 把z移除
        delete_pointer( z );
        // 调整
        consolidate();
        // 更新number
        number --;
    }
    return z->key;
}

// 辅助函数，把x提取到最上面，调整最小堆性质
void FibHeap::cut( FibNode* x, FibNode* y ){
    // 判断一下y的子节点是只有一个x还是还有其他的
    if( y->degree == 1 )    y->child = NULL;
    else    y->child = x->rbro;
    // 更新y的degree
    y->degree --;
    // 把x从y中提取出来
    delete_pointer( x );
    // 把x加入到主链表中
    cat_pointer( min , x );
    x->mark = false;
}

// 辅助函数，调整最小堆性质
void FibHeap::cascading_cut( FibNode* y ){
    // 建立临时变量
    FibNode* z = y->father;
    // 如果y不在主链表里
    if( z != NULL ){
        // 如果y的mark是否
        if( y->mark == false )  y->mark = true;// 调整过来
        else{
            // 递归做cut
            cut( y , z );
            cascading_cut( z ); 
        }
    }
}

// 减少指定指针的值
void FibHeap::decrease( FibNode* x, int k ){
    // 只能减少
    if( k > x->key.dis )    return;
    // 更新
    x->key.dis = k;
    // 建立临时变量
    FibNode* y = x->father;
    // 如果x不是顶层,且x比y的值更小
    if( y!= NULL && x->key < y->key ){
        // cut和cascading-cut两个操作
        cut( x, y );
        cascading_cut( y );
    }
    // 如果x的值比min小，就代替min
    if( x->key < min->key ) min = x;
}

bool FibHeap::empty(){
    return number==0;
}
/****************************************************斐波那契堆部分结束***************************************************/

/******************************************************二项堆部分*******************************************************/
// binary heap的点
struct binonode{
    // 节点的key为node_pri,因为堆是最大堆
    node key;
    // 父节点，左右子节点
    binonode* nsibil;
    binonode* lchild;
};

// binary heap
class binoheap{
    public:
        binoheap(){number=0;for(int i=0;i<30;i++)   forest[i]=NULL;}
        node pop();
        bool empty();
        void push( node in );
        void combineForest( binoheap H2 );
        binonode* combineTree( binonode* T1, binonode* T2 );
    private:
        // 堆的个数
        int number;
        // 森林的数组
        binonode* forest[30];
};

// 合并两个树
binonode* binoheap::combineTree( binonode* T1, binonode* T2 ){
    // key小的做父
    if( T2->key < T1->key ) return combineTree( T2, T1 );
    // 把T2作为T1的子
    // T2变成T1的最左边的儿子
    T2->nsibil = T1->lchild;
    T1->lchild = T2;
    // 返回父
    return T1;
}

// 合并两个森林,其中一个是这个类森林
void binoheap::combineForest( binoheap H2 ){
    // 定义临时变量
    binonode* T1;
    binonode* T2;
    binonode* Carry=NULL;
    // 如果超出范围就要报错
    if( number + H2.number > CAPITAL )   exit(1);
    // 准备把所有都转移到T1上
    number += H2.number;
    // 最大的上限是lognumber
    int i,j;
    for( i=0,j=1; j<=number; i++,j*=2 ){
        // 截取T1和T2当前的tree
        T1 = forest[i];T2 = H2.forest[i];
        // 人造三位二进制判定是否为0
        switch ( 4*(!!Carry) + 2*(!!T2) + (!!T1) )
        {
        // 全0就不用任何操作，因为三个都没有任何东西
        case 0:break;
        // 001 只有T1不为NULL，直接跳过就行
        case 1:break;
        // 010 只有T2有，要转到T1去
        case 2:forest[i]=T2;H2.forest[i]=NULL;break;
        // 011 T1T2都有，需要融合,要到下一层
        case 3:Carry=combineTree( T1, T2 );forest[i]=H2.forest[i]=NULL;break;
        // 100 只有carry有，驾到这里
        case 4:forest[i]=Carry;Carry=NULL;break;
        // 101,只有Carry和T1有，融合到下一层
        case 5:Carry=combineTree(Carry,T1);forest[i]=NULL;break;
        // 110,只有Carry和T2有，融合到下一层
        case 6:Carry=combineTree(Carry,T2);H2.forest[i]=NULL;break;
        // 111 三个都有Carry给森林，T1T2融合下一层
        case 7:forest[i]=Carry;Carry=combineTree(T1,T2);H2.forest[i]=NULL;break;
        }
    }
    return;
}

// 插入一个节点
void binoheap::push( node in ){
    // 如果binoheap是空的，直接加到1的地方就行
    // 创建新的点
    binonode* newNode = (binonode*)malloc(sizeof(binonode));
    // 初始化
    newNode->lchild = NULL;newNode->nsibil = NULL;
    // 赋值
    newNode->key = in;
    // 如果森林是空的，可以直接加到0里去
    if( number == 0 ){
        forest[0] = newNode;
        number ++;
        return;
    }
    else{
        // 建立一个只有这个点的森林融合
        binoheap temp;
        temp.number=1;
        temp.forest[0] = newNode;
        combineForest( temp );
    }
    // 结束
    return;
}

// 推出最小点
node binoheap::pop(){
    // 新建一个承载子节点的堆
    binoheap Delete;
    // 建立临时变量
    binonode* DeleteTree;
    binonode* OldRoot;
    // 即将推出去的最小的值
    node MinItem;
    // 如果是空的直接报错
    if( number == 0 )   exit(1);
    // 定义临时变量
    int i,j,MinTree;
    // 遍历所有根找最小的值所在的树的根点
    for( int i=0; i<30; i++ ){
        // 这个点即不为NULL，又比MinItrm小
        if( forest[i] != NULL && forest[i]->key < MinItem ){
            // MinItem就是这个,更新
            MinItem = forest[i]->key;
            MinTree = i;
        }
    }
    // 确定删除的点
    DeleteTree = forest[MinTree];
    // 在森林中删除
    forest[MinTree] = NULL;
    // 准备转移
    OldRoot = DeleteTree;
    DeleteTree = DeleteTree->lchild;
    // 解放原来的节点
    free(OldRoot);
    // 点的数量就是2的幂次方减去删去的
    Delete.number =(1 << MinTree)-1;
    // 开始加值
    for( j=MinTree-1; j>=0; j-- ){
        Delete.forest[j] = DeleteTree;
        DeleteTree = DeleteTree->nsibil;
        Delete.forest[j]->nsibil = NULL;
    }
    // 融合
    // 先更新原来的值
    number -= ( Delete.number + 1 );
    // 再融合
    combineForest( Delete );
    // 返回最小值
    return MinItem;
}

// 测试是否还有内容
bool binoheap::empty(){
    return number==0;
}

/******************************************************二项堆部分结束****************************************************/

/******************************************************左倾斜堆部分******************************************************/
// Lefist heap node 的点结构
struct LefistNode{
    node key;
    // Npl属性，用来调整堆的性质
    int Npl;
    // 左右的孩子
    LefistNode* lchild;
    LefistNode* rchild;
};

// Leftist heap 
class LefistTree{
    public:
        LefistTree(){tree=NULL;number=0;}
        node pop();
        void push( node in );
        bool empty();
        LefistNode* Merge( LefistNode* H1, LefistNode* H2 );
    private:
        LefistNode* Merge_( LefistNode* H1, LefistNode* H2 );
        int number;
        LefistNode* tree;
};

// 辅助函数，融合两个树的实际操作
LefistNode* LefistTree::Merge_( LefistNode* H1, LefistNode* H2 ){
    // single Node,直接融合
    if( H1->lchild == NULL )    H1->lchild = H2;
    // 否则就要转化一下
    else{
        // 融合
        H1->rchild = Merge( H1->rchild, H2 );
        // 转化孩子
        if( H1->lchild->Npl < H1->rchild->Npl ){
            LefistNode* temp = H1->lchild;
            H1->lchild = H1->rchild;
            H1->rchild = temp;
        }
        // 更新Npl
        H1->Npl = H1->rchild->Npl + 1;
    }
    // 返回
    return H1;
}

// 融合两个树
LefistNode* LefistTree::Merge( LefistNode* H1, LefistNode* H2 ){
    // 判断一下需不需要融合，如果一方为null直接返回就OK
    if( H1 == NULL )    return H2;
    if( H2 == NULL )    return H1;
    // 判断怎么链接
    if( H1->key < H2->key ) return Merge_( H1, H2 );
    else    return Merge_( H2, H1 );
}

node LefistTree::pop(){
    // 找到最小的点
    LefistNode* Min = tree;
    // 建立临时变量
    LefistNode* Ltree = tree->lchild;
    LefistNode* Rtree = tree->rchild;
    // 删除tree建立新的tree
    tree = Merge( Ltree, Rtree );
    // 返回最小的
    return Min->key;
}

// 压入元素到堆里
void LefistTree::push( node in ){
    // 就是把新的作为新树压进去
    // 建立新的点
    LefistNode* newNode = (LefistNode*)malloc(sizeof(LefistNode));
    newNode->key = in;
    newNode->lchild = newNode->rchild = NULL;
    newNode->Npl = 1;
    // 把新的点压进去
    tree = Merge( tree, newNode );
    return;
}

// 判断是否为空
bool LefistTree::empty(){
    return tree==NULL;
}

/******************************************************左倾斜堆部分结束***************************************************/


// vis dis和 pre即是否被检测过，前一个点用全局来表示，否则用queue无法读取
int* vis;
int* pre;
int* dis;
// nodeLib 是用来存储不同点的指针的，便于在O（1）内找到
FibNode** nodeLib;

// 地图用vector来存储
vector<edge>* map;

// 初始化
void Init(int NodeNum){
    // 初始化vis和pre
    if( vis )   free(vis);
    if( pre )   free(pre);
    if( dis )   free(dis);
    // vis的初始化都是没vis过
    vis = (int*)malloc(sizeof(int)*NodeNum);
    // pre的初始化是-1.即没有
    pre = (int*)malloc(sizeof(int)*NodeNum);
    // dis的初始化是无穷大
    dis = (int*)malloc(sizeof(int)*NodeNum);
    for( int i=0; i<NodeNum; i++){
        vis[i]=0;
        pre[i]=-1;
        dis[i]=INF;
    } 
    return;
}

// Dijkstra算法实现,返回double形式的运行时间
double Dijkstra_fib(int source, FibHeap q ) {
    // 计时,计次数
    clock_t start, end;
    start = clock();

    // 函数实现部分
/*----------------------------------------------------------------------------------------*/
    // 起点为0
    // 压入第一个点
    q.push(node(source,0));
    queue_use++;
    // 第一个点的map定为0
    dis[source] = 0;
    node Temp;
    // 只要还没遍历完
    while(!q.empty()){
        // 压出距离最近的一个
        Temp = q.pop();
        queue_use += 2;
        // 查看是否遍历过  
        if( vis[Temp.name] ) continue;
        else    vis[Temp.name] = 1;
        // 开始逐个找该点的边
        int num = map[Temp.name].size();
        // 逐个找边
        for(int i=0; i<num; i++ ){
            // 这个边是当前操作的边
            edge tmp = map[Temp.name][i];
            // 边的连接的点
            int mute = tmp.mute;
            // 如果边也被遍历过，说明肯定无法再有优化，直接跳过
            if( vis[mute] ) continue;
            // 边的distance
            int distance = tmp.distance;
            // 如果从这个点走可以有优化
            if( dis[mute] > dis[Temp.name] + distance ){
                // 如果是不在堆里，即还是INF的
                if( dis[mute] == INF ){
                    // 更新距离
                    dis[mute] = dis[Temp.name] + distance;
                    // 加入堆
                    // 加入地图
                    nodeLib[mute] = q.push(node(mute,dis[mute]));
                }
                // 如果在堆里，就直接更新堆
                else{
                    // 更新距离
                    dis[mute] = dis[Temp.name] + distance;
                    // 在地图中找到指针，并更新
                    q.decrease( nodeLib[mute], dis[mute] );
                }
                
                queue_use++;
            }
        }
    }

/*----------------------------------------------------------------------------------------*/
    end = clock();
    // cout << "begin " << start << " end " << end << endl;
    return (double) (end - start);
}

// Dijkstra算法实现,返回double形式的运行时间
// T作为一个heap。有几个基础的功能
double Dijkstra(int source, priority_queue<node_pri> q ) {
    // 计时,计次数
    clock_t start, end;
    start = clock();

    // 函数实现部分
/*----------------------------------------------------------------------------------------*/
    // 起点为0
    // 压入第一个点
    q.push(node_pri(source,0));
    queue_use++;
    // 第一个点的map定为0
    dis[source] = 0;
    node_pri Temp;
    // 只要还没遍历完
    while(!q.empty()){
        // 压出距离最近的一个
        Temp = q.top();
        q.pop();
        queue_use += 2;
        // 查看是否遍历过  
        if( vis[Temp.name] ) continue;
        else    vis[Temp.name] = 1;
        // 开始逐个找该点的边
        int num = map[Temp.name].size();
        // 逐个找边
        for(int i=0; i<num; i++ ){
            // 这个边是当前操作的边
            edge tmp = map[Temp.name][i];
            // 边的连接的点
            int mute = tmp.mute;
            // 如果边也被遍历过，说明肯定无法再有优化，直接跳过
            if( vis[mute] ) continue;
            // 边的distance
            int distance = tmp.distance;
            // 如果从这个点走可以有优化
            if( dis[mute] > dis[Temp.name] + distance ){
                dis[mute] = dis[Temp.name] + distance;
                q.push(node_pri(mute,dis[mute]));
                queue_use++;
            }
        }
    }

/*----------------------------------------------------------------------------------------*/
    end = clock();
    // cout << "begin " << start << " end " << end << endl;
    return (double) (end - start);
}

// Dijkstra算法实现,返回double形式的运行时间
// T作为一个heap。有几个基础的功能
template<class T>
double Dijkstra_bino(int source, T q ) {
    // 计时,计次数
    clock_t start, end;
    start = clock();

    // 函数实现部分
/*----------------------------------------------------------------------------------------*/
    // 起点为0
    // 压入第一个点
    q.push(node(source,0));
    queue_use++;
    // 第一个点的map定为0
    dis[source] = 0;
    node Temp;
    // 只要还没遍历完
    while(!q.empty()){
        // 压出距离最近的一个
        Temp = q.pop();
        queue_use += 2;
        // 查看是否遍历过  
        if( vis[Temp.name] ) continue;
        else    vis[Temp.name] = 1;
        // 开始逐个找该点的边
        int num = map[Temp.name].size();
        // 逐个找边
        for(int i=0; i<num; i++ ){
            // 这个边是当前操作的边
            edge tmp = map[Temp.name][i];
            // 边的连接的点
            int mute = tmp.mute;
            // 如果边也被遍历过，说明肯定无法再有优化，直接跳过
            if( vis[mute] ) continue;
            // 边的distance
            int distance = tmp.distance;
            // 如果从这个点走可以有优化
            if( dis[mute] > dis[Temp.name] + distance ){
                dis[mute] = dis[Temp.name] + distance;
                q.push(node(mute,dis[mute]));
                queue_use++;
            }
        }
    }

/*----------------------------------------------------------------------------------------*/
    end = clock();
    // cout << "begin " << start << " end " << end << endl;
    return (double) (end - start);
}


// 读取地图文件
int readFile( string filePath ){
    // 读取数据阶段
    ifstream mapFile;
    // cout << "begin" << endl;
    // if(argv[1][0] == 'a' )  mapFile.open("./USA-road-d.E.gr",ios::in);
    // else    mapFile.open("./USA-road-d.NY.gr",ios::in);
    mapFile.open(filePath,ios::in);
    // 把前面几行注释读取掉
    char l[100];
    for( int i=0; i<4; i++ ){
        mapFile.getline(l,100);
    }
    // 读取关键信息 
    char type;char sign[3];int num_1,num_2;
    // 读取文件最开始
    mapFile >> type >> sign >>num_1 >> num_2;
    // 再读无用的注视
    mapFile.getline(l,100);
    mapFile.getline(l,100);
    mapFile.getline(l,100);
    // 构建数据结构
    // 构建地图
    // cout << sizeof(vector<edge>)*num_1 << endl;
    map = (vector<edge>*)std::malloc(sizeof(vector<edge>)*num_1);

    // 一共有num_2个线
    char type_2;
    int node_1,node_2,length;
    for( int i=0; i<num_2; i++ ){
        mapFile >> type_2 >> node_1 >> node_2 >> length;
        if( type_2 != 'a') return 1;
        map[node_1].push_back(edge(node_2,length));
    }
    cout << num_2 << endl;
    // cout << "end" << endl;
    mapFile.close();
    // 读取数据结束
    // 数据以edge的形式存储在map里
    return num_1;
}

int main(){

    // 读取文件内的路
    int node_number;
    // 读取路径的相对路径
    string filePath = "./USA-road-d.USA.gr";
    node_number = readFile(filePath);
    
    // 跑几个随机点
    int test_number = 1;

// 测试斐波那契堆
// 测试数据 USA地图，随机找1000个点，并找出其所有的通路及最短路径
// 测试输出 queue的用的次数，还有时间
/*----------------------------------------------------------------------------------------*/

    time_second = 0;
    queue_use = 0;
    for( int i=0; i<test_number; i++ ){
        // 开始测试
        Init(node_number);
        nodeLib = (FibNode**)malloc(sizeof(FibNode*)*node_number);
        // 先用prior_queue试一试
        FibHeap Fib;
        time_second += Dijkstra_fib(i*100+2301,Fib);
    }
    cout << "The queue is fibonacci_queue" << endl;
    cout << "time is : " << time_second << endl;
    cout << "queue use : " << queue_use << endl;
    cout << "\n" << endl;

/*----------------------------------------------------------------------------------------*/

// 测试std::prior_queue
// 测试数据 USA地图，随机找1000个点，并找出其所有的通路及最短路径
// 测试输出 queue的用的次数，还有时间
/*----------------------------------------------------------------------------------------*/

    time_second = 0;
    queue_use = 0;
    for( int i=0; i<test_number; i++ ){
        // 开始测试
        Init(node_number);
        // 先用prior_queue试一试
        priority_queue<node_pri> prior;
        time_second += Dijkstra(i*100+2301,prior);
    }
    cout << "The queue is prior_queue" << endl;
    cout << "time is : " << time_second << endl;
    cout << "queue use : " << queue_use << endl;
    cout << "\n" << endl;

/*----------------------------------------------------------------------------------------*/


// 测试binomal heap
// 测试数据 USA地图，随机找1000个点，并找出其所有的通路及最短路径
// 测试输出 queue的用的次数，还有时间
/*----------------------------------------------------------------------------------------*/

    time_second = 0;
    queue_use = 0;
    for( int i=0; i<test_number; i++ ){
        // 开始测试
        Init(node_number);
        // 先用prior_queue试一试
        binoheap bino;
        time_second += Dijkstra_bino(i*100+2301,bino);
    }
    cout << "The queue is binomial_queue" << endl;
    cout << "time is : " << time_second << endl;
    cout << "queue use : " << queue_use << endl;
    cout << "\n" << endl;

/*----------------------------------------------------------------------------------------*/

// 测试leftist heap
// 测试数据 USA地图，随机找1000个点，并找出其所有的通路及最短路径
// 测试输出 queue的用的次数，还有时间
/*----------------------------------------------------------------------------------------*/

    time_second = 0;
    queue_use = 0;
    for( int i=0; i<test_number; i++ ){
        // 开始测试
        Init(node_number);
        // 先用prior_queue试一试
        LefistTree leftist;
        time_second += Dijkstra_bino(i*100+2301,leftist);
    }
    cout << "The queue is leftist_queue" << endl;
    cout << "time is : " << time_second << endl;
    cout << "queue use : " << queue_use << endl;
    cout << "\n" << endl;

/*----------------------------------------------------------------------------------------*/
    return 0;
}