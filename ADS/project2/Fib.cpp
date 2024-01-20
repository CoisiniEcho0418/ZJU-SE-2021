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

// 读取地图文件
int readFile(){
    // 读取数据阶段
    ifstream mapFile;
    // cout << "begin" << endl;
    // if(argv[1][0] == 'a' )  mapFile.open("./USA-road-d.E.gr",ios::in);
    // else    mapFile.open("./USA-road-d.NY.gr",ios::in);
    mapFile.open("./USA-road-d.E.gr",ios::in);
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
    // cout << "end" << endl;
    mapFile.close();
    // 读取数据结束
    // 数据以edge的形式存储在map里
    return num_1;
}

// 爆破小分队
void test(){
    FibHeap a;
    for( int i=0 ; i<100000; i++ ){
        int j=(i*312678+1237897534)%123145;
        a.push(node(j,j));
    }
    for( int i=0; i<100000; i++ ){
        cout << a.pop().dis << endl;
    }
}
int main(){
    // 读取文件内的路
    int node_number;
    node_number = readFile();


// 测试斐波那契堆
// 测试数据 USA地图，随机找1000个点，并找出其所有的通路及最短路径
// 测试输出 queue的用的次数，还有时间
/*----------------------------------------------------------------------------------------*/
    time_second = 0;
    queue_use = 0;
    for( int i=0; i<10; i++ ){
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

/*----------------------------------------------------------------------------------------*/

// 测试std::prior_queue
// 测试数据 USA地图，随机找1000个点，并找出其所有的通路及最短路径
// 测试输出 queue的用的次数，还有时间
/*----------------------------------------------------------------------------------------*/
    time_second = 0;
    queue_use = 0;
    for( int i=0; i<10; i++ ){
        // 开始测试
        Init(node_number);
        // 先用prior_queue试一试
        priority_queue<node_pri> prior;
        time_second += Dijkstra(i*100+2301,prior);
    }
    cout << "The queue is prior_queue" << endl;
    cout << "time is : " << time_second << endl;
    cout << "queue use : " << queue_use << endl;

/*----------------------------------------------------------------------------------------*/


}