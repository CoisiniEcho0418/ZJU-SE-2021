# 区块链与数字货币

## 考试

教4 301

星期天 10:30->12:30 

![](https://raw.githubusercontent.com/workflowBot/image_bed/main/uPic/3aoQiy.png)



开卷考，带一张a4纸

概念，原理，技术

问答题，阐述题









## 1. Intro

### 1.1 简介

- 教材
  - 区块链教程 2021
  - 区块链技术 2019
- 货币是一般等价物
  - 回溯：金银可交换性强，易衡量
  - 金银跟不上发展速度
- 货币
  - 纸币的本质是信用
  - 可广泛获取的：货币，黄金等实物
  - 数字形式：受限，需要设备
  - 中央银行发行
  - 民间发行代币
  
- hash算法
  - 不定输入->固定长度输出自由市场、自由经营、自由竞争、自动调节、自动均衡
  - 碰撞：不同输入得到相同输出
  - 逆向困难：输出不能够逆向到输入
  - 抗碰撞：MD5已经被攻破
  - 常见算法：md4,md5,sha1,sha2
- 非对称加密
  - RSA算法：大素数分解
  - 椭圆曲线加密：离散对数难解






## 2. 区块链技术原理

### 2.1 区块链概念及核心技术介绍

- 中本聪提出了比特币和区块链的概念
- 解决的问题：
  - 虚假货币：
    - 解决方案：数字签名（非对称加密）
  - 多重支付
    - 解决方案：分布式账本，每一个节点存储自己的账本副本和前一个区块的hash值，如果要修改一个账本，就要修改一整个链上的所有账本，技术上不可行，而且即使篡改了本机的账本，本机和网上大部分账本对不上的时候，会自动下载一份可信的账本。
    - 核心技术
      - 数据不可篡改：区块链机制
        - 每一个block存储自己爹所有交易，然后还要存储前一个区块的hash值，如果被篡改，那么区块的hash就会发生变化，那么后一个区块的hash也会变化。所以篡改成功的唯一条件是该区块往后的所有区块都被篡改，这是不可能的。
        - 分布式账本保证修改一个电脑的账本是无效的。bitcoin软件会将本机的账本和网上大部分人的账本进行比较，如果不一致，会将标准的账本拷贝到本地。
      - 分布式的可信记账机制

### 2.2 不可篡改性

- 区块数据结构

  - ![image-20221024185343192](../../../../../Library/Application Support/typora-user-images/image-20221024185343192.png)
  - 区块头，存储了（80bit）
    - 版本信息
    - 随机数
    - 前一个区块的hash
    - 时间戳
    - **merkel树**
    - ![image-20221024185350343](../../../../../Library/Application Support/typora-user-images/image-20221024185350343.png)
  - 交易数据列表（可变长度）
    - 列表中存储的是发生的交易
    - ![image-20221024185156722](../../../../../Library/Application Support/typora-user-images/image-20221024185156722.png)
  - 区块区分方式：
    - 高度：不唯一，可能有兄弟节点
    - ahsh值：唯一，但是只存储在下一个节点

  - Merkel树

    - 叶子结点存储的事交易的hash值

    - 非叶子节点存储的事子节点的hash值

    - merkel书中使用的hash是两次sha256算法，为了提高安全性

    - 对于一个交易，最多$log_2(n)$次计算就能判断交易是否存在

    - 作用

      - 交易锁定

      - 快速比较大量数据：对于有不同交易的两个区块，只需要比较根就知道区块的交易信息是否一致。

      - 快速定位修改：从根节点向下可以快速找到被篡改的数据

      - 简单交易验证：比如这里，要验证绿色交易是否存在，那么只需要给出所有的蓝色节点即可，那么节点不需要存储完整的merkel树，只需要下载一个80bit的区块头，之后从一个端节点获取所需要的merkel路径即可，路径的长度为$log_2(n)$。

        ![image-20221024191740506](../../../../../Library/Application Support/typora-user-images/image-20221024191740506.png)

        ![image-20221024191922451](../../../../../Library/Application Support/typora-user-images/image-20221024191922451.png)

      - 并不是所有的节点都会存储完整的merkel树，互联网中存储完整账本的节点叫做全节点，验证的时候向全节点发起请求，全节点响应merkel路径。将计算得到的merkel根值和发送交易请求的节点所发送的merkel根hash值做比较即可实现交易验证。

    - 树的节点需要是偶数，如果是奇数，那么将最后一个交易重复一次

- 节点分类：

  - 全节点：存储了所有的区块链，分为矿工节点和非矿工节点
  - 轻节点：
    - 简单支付验证节点：只存储了区块头，能对到来的交易请求进行验证
    - 钱包：存储了所有者信息：地址，私钥、余额、UTXO，不存储账本。

- UTXO：两个节点之间的交易，A->B，如果B是全节点，那么可以直接使用区块头中的信息找到merkel树的对应节点，那么就验证了A的支付；如果B是一个SPV（简单支付节点），不保存交易数据，那么像一个full client询问对应的信息（区块头找到的merkel树根），如果全节点返回正确信息，那么交易成立，否则不成立。

  ![image-20220920162858086](../../../../../Library/Application Support/typora-user-images/image-20220920162858086.png)

  全节点先查询对应merkel节点是否在，如果不在就false；不然将对应路径上的伙伴merkel节点返回，B检查计算结果merkel根和A发送的merkel根是否一致，一致就是对的，否则是错误的。

- spv验证过程

  - ![image-20221024194209297](../../../../../Library/Application Support/typora-user-images/image-20221024194209297.png)

- 区块数据结构

  - ![image-20221024194616956](../../../../../Library/Application Support/typora-user-images/image-20221024194616956.png)
  - vtx事实上存储的事交易的hash值

- 交易的数据结构

  - ![image-20221024194452928](../../../../../Library/Application Support/typora-user-images/image-20221024194452928.png)

    

### 2.2 可信记账机制

- 谁来记账？
- 分布式一致性：拜占庭将军问题
- 重要假设：
  1. 网络包是可信的（TCP？）
  2. 每一个节点是独立运行的，相互之间通过网络通信
  3. 可能有恶意节点
  4. 信道总是可靠的
- 目标
  - 一致性（所有**正常**节点行动一致）
  - 正确性（所有正常节点的行为不会受到恶意节点的干扰）
- 可行的分布式一致性算法
  - PBFT
  - RAFT
- 分布式系统模型
  - 时序模型
    - 同步：分布式节点的进程必须在规定时间内完成
    - 异步：无规定时间
  - 故障模型（信道可信）
    - 崩溃故障：节点崩溃或通信中断
    - 拜占庭故障（同步）：节点崩溃或通信中断或恶意节点（PBFT）
  - 容错模型
    - 崩溃容错：CFT（RAFT，不存在恶意节点）
    - 拜占庭容错：BFT（PBFT）
- PBFT要求节点个数有限，不适用比特币（比特币的节点数量是动态增减的）
- 容错模型

  ![](https://raw.githubusercontent.com/workflowBot/image_bed/main/uPic/uNHRv8.png)
- **比特币的共识机制**：pow
  - 固定时间段（10min）（同步模型）
  - 相同或相似输入数据（10min内所有的交易打包转发，或者将优先级最高的，最近的交易打包）
  - 算力竞争选出获胜节点，其他节点确认后不再发送消息
  - 短期共识扩展到长期共识
- 工作机制：高强度hash计算进行竞争。
- 计算方式：对本区块的头计算sha256，直到达到对应的难度，将得到的区块头和区块体组装之后进行广播；如果没有达到难度，那么将nonce++，重新尝试计算sha256。
- 分叉解决方案
  - 几乎同时找到nonce：不会总是存在两个一样长的分支，一定会存在一个主链。
  - 网络中断：孤立区块：随着时间推移，最终会被合并到主链上
- 激励机制：
  - 挖矿：挖矿节点有自己的160位密码和私钥
  - 打包的时候，在交易列表中加上一个coinbase交易奖励给自己
  - 生成一个UTXO，包含奖励数量的比特币，招领地址为自己的地址
  - 如果达成共识，那么就拥有了这么多的UTXO

### 2.3 交易模型

- 每一个比特币用户都有一个160位的地址
  - 计算过程：产生一对密钥，将公钥经过sha160计算得到160地址作为钱包地址，私钥自己保存。
- 交易方式
  - 比特币本身不存储余额，需要根据UTXO进行计算，比如A持有3个UTXO，分别是2、2.5、0.3比特币
  - 那么A需要将两个UTXO凑成3个比特币
  - 交易的输入是A的2、2.5比特币的UTXO，输出是B的3个比特币，A的1.5个比特币
  - 现在A持有1.5和0.3个比特币
  - 所以每一个比特币都是可追溯来源的
  - 招领脚本是UTXO目标地址
  - ![image-20220922083409442](../../../../../Library/Application Support/typora-user-images/image-20220922083409442.png)
- 两种交易（两种UTXO）
  - 常规交易
    - 输入：支付者地址和金额，输出（收入者地址和金额）
  - 挖矿交易
    - 只有交易输出（挖矿者地址和金额）
- 交易数据结构
  - ![image-20221024205628289](../../../../../Library/Application Support/typora-user-images/image-20221024205628289.png)
  - utxo: 区块ID + 交易id + ctxout
  - ctxout
    - nvalue utxo价值
    - scriptPubKey 招领脚本
  - ctxin
    - prevout 资金来源
      - hash 交易的hash值
      - n 是上述交易的第几个输出
    - scriptSig 认领脚本
    - nSequence 特殊作用
    - scriptWindow 脚本数据
- 支付通道
  - 建立支付通道 funding transaction	
    - 由参加交易的AB双方建立一个多签名的联合地址，付款方将一笔钱打到这个地址上，只有双方都签名之后，这笔钱才能花出去（上链）
  - 链下交易 commitment trasnsaction 
    - 不上链，每一个交易的资金都来自一个UTXO，输出一个是给付款方的UTXO找零，一个是给收款方的付款，但是不生效
  - 决断交易 settlement transaction
    - 上链，收款方将付款方的请求签名，发送到比特币公网上，将最初注资生成的输出UTXO中的余额转给自己，将剩下的资金转给收款方；该交易也可以由付款方发起。
  - 闪电交易

### 2.4 通信方式

- 通信方式: p2p
- 存在种子节点，新节点先和和种子节点通信，得到伙伴列表
- 新节点和上述伙伴通信，对有反应的请求新的伙伴列表，最终获得最新的伙伴列表
- 





## 3 以太坊

1. 智能合约运行在EVM上，由应用开发者编写，而不是以太网标准系统开发者实现。

2. ![image-20221008081946160](../../../../../Library/Application Support/typora-user-images/image-20221008081946160.png)

3. ![image-20221008082435481](../../../../../Library/Application Support/typora-user-images/image-20221008082435481.png)

4. 合约交易
   1. 发布代码，在区块链上创建一个合约账户，地址是代码的hash值
   2. 外部账户的nonce，表示该账户发起的交易数
   3. 合约账户的nonce，表示该账户创建的合约的数量（合约也可以通过发起合约交易来创建合约账户）
   4. balance在外部和合约账户下都有，因为发起交易需要gas，需要一部分余额发起交易。

5. 两种账户的区别
   1. ![image-20221008083922235](../../../../../Library/Application Support/typora-user-images/image-20221008083922235.png)

6. 一个gas等于多少以太币是自己定义的

7. 支付类型

  - ![image-20221025140307291](../../../../../Library/Application Support/typora-user-images/image-20221025140307291.png)

8. 交易过程

   >![image-20221011164151745](../../../../../Library/Application Support/typora-user-images/image-20221011164151745.png)
   >
   >1. 首先计算发起交易所需要的最少的wei个数
   >
   >   ![image-20221011164209218](../../../../../Library/Application Support/typora-user-images/image-20221011164209218.png)
   >
   >2. 然后发送者减掉费用 + gas含有的wei的个数，基本的gas完全注销，多出来的小费（老的以太坊会将所有的gas给miner，但是新版的gas只会把小费会给miner）

9. 交易数据结构

   1. ![image-20221025140343454](../../../../../Library/Application Support/typora-user-images/image-20221025140343454.png)

10. 交易中的data字段

   1. ![image-20221025140515143](../../../../../Library/Application Support/typora-user-images/image-20221025140515143.png)
   2. 如果是合约部署交易，那么storageroot存储部署的合约的地址,codehash存储代码的hash值

11. 记账节点会将gas拿走

12. 交易数据结构（最新）

    1. ![image-20221025145545251](../../../../../Library/Application Support/typora-user-images/image-20221025145545251.png)

    2. base fee使用上一个区块的所有gas费用计算当前区块的最小gas单价

       ![image-20221025151718223](../../../../../Library/Application Support/typora-user-images/image-20221025151718223.png)

       priority fee是交易发起者愿意支付的小费单价

       max fee是愿意支付的最大gas单价

       max fee >= priority fee + base fee

    3. fee相关的计算

       ![image-20221025151943255](../../../../../Library/Application Support/typora-user-images/image-20221025151943255.png)

       基本gas被注销，小费给miner（旧版以太坊是都给miner）

13. 区块链结构

    >![image-20221011164441437](../../../../../Library/Application Support/typora-user-images/image-20221011164441437.png)
    >
    >1. unclesList包含上一个区块的所有分支
    >2. coinbase是miner对自己的奖励
    >
    >![image-20221011164813764](../../../../../Library/Application Support/typora-user-images/image-20221011164813764.png)
    >
    >1. stateroot是世界状态的根节点，包含有所有账户的状态hash
    >2. txTrieRoot是所有交易的根记录的hash
    >3. number用来解决分叉

14. 分叉消除方法

    1. 每个区块的上限是30m，下限是15m
    2. pow的出块时间平均是15s
    3. 方法：挑选计算量最大的路径（使用高度判断，也就是上述的number），前面的所有分叉作废，在支链上的交易需要重新发起才可能被执行

15. 区块中的重要数据结构

   1. transactionsRoot，所有交易的树

   2. trceiptsRoot，收据树，不可篡改

   3. stateRoot，保存所有账户的余额。如何处理大部分不变，只有少量变化？

      >如果用常规方法，将数亿账户的信息全部存储，代价太高。
      >
      >使用前缀树，但是一条边不止一个字母，降低了存储代价。
      >
      >可以实现快速定位，之后通过merkel进行锁定。
      >
      >查找自顶向下，然后自底向上计算merkel hash值
      >
      >实际存储方式
      >
      >![image-20221011172300867](../../../../../Library/Application Support/typora-user-images/image-20221011172300867.png)
      >
      >最终的版本
      >
      >![image-20221011172554648](../../../../../Library/Application Support/typora-user-images/image-20221011172554648.png)

11. pow算法：ehash，使用keccak256算法

12. 信标链

    1. 12秒作为一个slot

    2. 32个slot形成一个纪元epoch

    3. 在每一个slot形成一个区块

13. 将所有的验证这分配到一个epoch中的所有slot中，每一个slot至少有一个委员会，这个委员会至少有128个验证者，这个委员会中会随机选出一个proposer进行区块的打包，委员会会进行投票，如果2/3成员approve，那么区块会被打包到主链上。



## 4. 超级账本

1. fabric 联盟链

      1. 主要设计特性
            1. 交易资产多样，只要资产经过了数字化（比如古董车），那么都可以在fabric上交易，而不是类似比特币和以太坊一样只能交易特定的货币

            2. 链码，类似以太坊的智能合约，但是将执行逻辑和事务的排序分开

            3. 账本

            4. 隐私保护，数据并不是类似以太坊一样全部公开的

            5. 安全和会员服务，并不是所有的节点都可以随意加入fabric，必须经过认证

            6. 共识，实现了不同的共识机制，不是选票制

      2. fabric架构
            1. ![image-20221028111648782](../../../../../Library/Application Support/typora-user-images/image-20221028111648782.png)

            2. 中间的区块链服务和以太坊类似

            3. 成员服务：需要注册才能够进入fabric，同时还有身份管理

2. 成员服务

      1. PKI生成和组织，网络组建和终端用户或者客户端程序相关联的加密证书
         1. fabirc 将所有的参与者称作 principal，本质上是一个封装在X.509中的一个数字身份和相关属性，就是fabric上的一个主体
         2. fabric 中的ca
            1. ![image-20221028112650961](../../../../../Library/Application Support/typora-user-images/image-20221028112650961.png)
            2. 申请不是线上进行的，而是需要到线下，比如柜台中进行申请。（这也比较好理解，不然私钥直接通过网络发放是比较危险的。）
            3. principal 验证方式：证书中实际包含有ca的public key和principal的public key，以及ca使用自己的private key进行签名的一段文字，验证的时候检查这段文字即可
            4. ca 的验证：物理世界中的证明
            5. ca 的继承机制
               1. ![image-20221028113553529](../../../../../Library/Application Support/typora-user-images/image-20221028113553529.png)
               2. ![image-20221028114100589](../../../../../Library/Application Support/typora-user-images/image-20221028114100589.png)
                  1. 证书列表包含有从根节点开始的一个证书授权列表
                  2. TLS证书列表包含有用来传输的证书授权列表
            6. 可以不使用fabric提供的基础ca机制，而是使用自己实现的或者是第三方ca机构踢踢哦给你ca服务
            7. fabric建议中间ca使用集群方式实现
      2. MSP分发证书，验证证书和用户授权背后的所有加密机制和协议抽象出来

3. 区块链服务

      1. p2p协议
            1. fabric中，使用grpc对外提供远程调用服务，节点之间使用gossip协议进行状态同步和分发

      2. 共识机制
            1. fabric中可以选择多种共识机制，目前使用的是solo，kafka和raft三种共识机制

      3. 分布式账本
            1. 包含两个组件：
                  1. 世界状态
                        1. 记录当前最新的分布式账本状态

                  2. 交易日志
                        1. 记录了世界状态的更新历史

      4. 账本存储
            1. 你用leveldb和couchdb实现，都是key-value类型的数据库

4. fabric中的节点分类

      1. client：最终用户，必须链接一个peer节点或者是orderer节点，一般只保存自己的账户数据

      2. orderer：编排节点，接受包含签名的交易，对没有打包的交易进行排序，组成区块，广播给peer节点

      3. peer节点：对等节点，负责执行链码实现对账本的读写操作，所有的peer节点都是提交节点，负责维护状态数据和账本的副本

      4. endorser节点：背书节点，部分peer节点根据背书策略的不同设定会执行交易并对结果进行签名背书，充当了背书节点的作用，背书节点是动态的角色，每一个链码实例化的时候都会设置背书策略，制定哪些节点对交易背书后才是有效的，只有在应用程序相节点发起交易背书请求的时候，peer节点才会变成背书节点，否则peer节点就是普通的记账节点。

      5. 对提交节点和背书节点的进一步说明

            ![image-20221028120757683](../../../../../Library/Application Support/typora-user-images/image-20221028120757683.png)

5. 典型的fabric网络拓扑图

      1. ![image-20221028120916098](../../../../../Library/Application Support/typora-user-images/image-20221028120916098.png)

            在这里，cc1中就是最初创建这个fabric网络的三个组织，O表示一个编排节点，P1,P2是两个peer节点，这里的L1,L2表示peer节点对账本复制之后保存的账本的副本，只有channel中的节点才能够看到对应的账本，A1，A2是链接这个channel的两个终端app

      2. ![image-20221028121329318](../../../../../Library/Application Support/typora-user-images/image-20221028121329318.png)在这里，有4个编排节点，他们需要达成共识，有3个commiter，负责提交对应的事务，有5个endoser，负责对交易进行背书，这里可以看出左边的一个commiter需要左边的三个endoser对交易进行背书

6. fabric中的通道和多链

      1. ![image-20221028121540633](../../../../../Library/Application Support/typora-user-images/image-20221028121540633.png)

      2. 多通道fabric网络拓扑图

            ![image-20221028121643687](../../../../../Library/Application Support/typora-user-images/image-20221028121643687.png)

7. peer节点分类

   1. 主节点：
      1. 如果一个组织在一个channel中有多个peer节点，那么其中会有一个主节点，负责将从编排节点获取到的交易分发给组织中的其他**提交节点**
   2. 锚节点：进行跨链交易，一个组织可以有0个或者多个锚节点，一个锚节点可以进行多个不同的跨组织间的通信，类似上图中的P2

8. 账本

   1. ![image-20221028122801676](../../../../../Library/Application Support/typora-user-images/image-20221028122801676.png)

   2. 世界状态

      1. 一个key-value数据库，key、value是可变的，视应用而定。

      2. 比如一个二手车交易平台，key就是车名，value就是车的相关信息

         ![image-20221027081653458](../../../../../Library/Application Support/typora-user-images/image-20221027081653458.png)

   3. 区块链

      1. fabric中，只有合约交易

      2. 区块结构

      3. ![image-20221027082222991](../../../../../Library/Application Support/typora-user-images/image-20221027082222991.png)

      4. 每一个区块都存储前一个区块头部的hash值

      5. 区块头结构

         ![image-20221027082604711](../../../../../Library/Application Support/typora-user-images/image-20221027082604711.png)

         CH2是当前区块的交易的hash

         PH1是前一个区块头的hash

      6. 这个结构只是一个逻辑结构，真正的存储结构不是这样的，比如区块交易数据库可以存储在外部存储中

      7. ![image-20221027082820571](../../../../../Library/Application Support/typora-user-images/image-20221027082820571.png)

      8. 即使是没有通过审核的交易，也需要打包到交易列表中

   4. 交易结构

      1. ![image-20221027083201601](../../../../../Library/Application Support/typora-user-images/image-20221027083201601.png)
      2. 对于应用程序来说，其在发出交易请求的时候只能够填写前三个字段，之后将这个交易请求转发给和自己链接的一个peer节点
      3. 这个peer节点会执行chaincode，填写交易中的读写集
      4. 之后需要进行签名背书，这是在部署合约代码的时候就商议好的，即调用这个chaincode需要经过哪些背书节点的签名。比如这里需要两个机构的审核，那么之类两个origination对这个交易进行审核，如果没有问题的话，那么进行签名，也就是在e4字段中加上自己的数字签名
      5. 一些交易无效的例子
         1. 比如提交给peer节点的时候，参数是无效的
         2. 比如组织不同意签名
      6. 需要注意的是，即使交易没有通过，peer节点也需要广播，编排节点也会将交易打包到区块中

9. 账本例子

   1. ![image-20221028124410937](../../../../../Library/Application Support/typora-user-images/image-20221028124410937.png)
   2. 区块结构
      1. ![image-20221028124525619](../../../../../Library/Application Support/typora-user-images/image-20221028124525619.png)

10. 部署链码
      		1. 要打包成一个tar文件，
      		1. fabric的代码是运行在docker上的，可以是宿主机上的各种语言编译出来的代码
      		1. 代码是图灵完备的，为了防止陷入死循环，代码有一个计时器，如果运行时间超过预定的时间，就会杀掉进程
      		1. 合约示例![image-20221028133458927](../../../../../Library/Application Support/typora-user-images/image-20221028133458927.png)
      		1. 背书
      		1. ![image-20221028133753334](../../../../../Library/Application Support/typora-user-images/image-20221028133753334.png)

11. ![image-20221028133849336](../../../../../Library/Application Support/typora-user-images/image-20221028133849336.png)

12. fabric上代码的部署

  1. 打包成一个tar文件
   2. 在peer节点上安装chaincode
   3. 批准，每一个要使用这个合约的peer节点都同意后，将chaincode提交给ordering节点。批准的数量要达到一个最低限度，来满足生命周期终止函数，然后才能启动这个chaincode
   4. 提交，需要足够的组织背书

13. fabric中的共识

  1. fabric中不会产生分叉

  2. fabric允许进行非确定性运算，这和以太坊不同

  3. 和bitcoin不同，共识在提交交易的时候就开始达成，但是前者只有在打包的时候达成共识

  4. 交易流程

   1. 提案和背书：找到一个相近的peer节点（commiter），使用fabric gateway提案发送给这个节点，这个节点自己执行或者转发给别的节点，收到的时候头和签名，提案三个部分都有了。节点先进行检查，检查状态是否一致，之后在容器中调用对应的chaincode，将结果写入response（读写集），将这个交易转发给背书节点，背书节点检查无误之后，在最后一个字段加上自己的签名。所有背书节点背书完毕之后，将响应发还给客户端，客户端确认交易有效之后，将交易发送给排序节点。

   2. 交易排序和打包：order节点不对交易的执行进行检查，只是检查字段和签名是否有效，之后按照时间先后进行打包。order节点将区块发送给（最近的）peer节点，这个节点通过gossip协议传播区块。

    ![](https://raw.githubusercontent.com/workflowBot/image_bed/main/uPic/AuezCn.png)

   3. 验证和提交：收到区块的节点，会检查区块是否有效，将区块合并到自己维护的区块链中，根据读写集合修改世界状态，这时候交易才真正提交成功

    ![](https://raw.githubusercontent.com/workflowBot/image_bed/main/uPic/ULOjxz.png)

14. fabric交易流程，这里缺少了背书节点的签名过程，应该发生在步骤3之前

  ![](https://raw.githubusercontent.com/workflowBot/image_bed/main/uPic/QhtdNN.png)

15. 性能方面：比特币和以太坊的性能依赖于miner，但是fabric的性能不仅仅依赖于order节点，也以来peer节点，效率高：打包的时候不需要检查；共识在此前已经形成；chaincode的执行可以并行化

16. 排序服务

  1. 目的：希望有多个排序节点
  2. 实现模式：
   - solo，只支持单个order节点
   - kafka，支持cft，不容忍恶意节点
   - raft，2n+1中最多n个崩溃节点，不容人额以及诶到哪
  3. raft协议介绍
  4. fabric中的raft工作
   1. ![](https://raw.githubusercontent.com/workflowBot/image_bed/main/uPic/gvxkFL.png)

  5. pbft算法介绍
   1. 






## 5. 区块链发展和应用

- 





































































































