import React, {Component} from 'react';
import img from '../../assets/images/kongwei.png'
class Item2 extends Component {
    render() {
        return (
            <div className='item4-box'>
                <div className="item4-pos">
                    <h3 className="types-title">
                        <span className="tit-icon icon-art-l tit-icon-l"></span>
                        <em>精</em>／<em>彩</em>／<em>手</em>／<em>记</em>／<em>及</em>／<em>讨</em>／<em>论</em>
                        <span className="tit-icon icon-art-r tit-icon-r"></span>
                    </h3>
                    <dl className='wonderful-list'>
                        <dd className='item box1'>
                            <label className="topic-label">热门话题</label>
                            <div className="topic-period green">
                                <a href="">
                                    #【内推第2波】#
                                    <br/>
                                    打工奋斗7万落京户VS自主创业牧马城市，如何抉择？
                                </a>
                                <img src={img} alt=""/>
                            </div>
                            <div className="topic-content">
                                毕业求职？跳槽加薪？纠结滋润加班还是苦练x年自主创业？速速提问互撩，你在撩的极有可能就是你的Boss！激不激动？惊不惊喜？Offer已在这里！你的简历在哪里？
                            </div>
                            <div className="bottom-info green">
                                <a href="">
                                    <p>了解详情</p>
                                    <svg className="icon-svg">
                                        <use xlinkHref='#iconyoujiantou'></use>
                                    </svg>
                                </a>
                            </div>
                            <div className="tit-line">
                                <span>往期回顾</span>
                                <div className="line"></div>
                            </div>
                            <div className="review-topic">
                                <div className="topic-period green">
                                    <a href="">
                                        #【获奖名单戳查看更多】#
                                        <br/>
                                        当我们谈论高校教学平台时，我们都谈些什么？
                                    </a>
                                    <img src={img} alt=""/>
                                </div>
                                <div className="topic-period green">
                                    <a href="">
                                        #【获奖名单戳查看更多】#
                                        <br/>
                                        当我们谈论高校教学平台时，我们都谈些什么？
                                    </a>
                                    <img src={img} alt=""/>
                                </div>
                                <div className="topic-period green">
                                    <a href="">
                                        #【获奖名单戳查看更多】#
                                        <br/>
                                        当我们谈论高校教学平台时，我们都谈些什么？
                                    </a>
                                    <img src={img} alt=""/>
                                </div>
                            </div>
                            <div className="bottom-info green">
                                <a href="">
                                    <p>更多往期话题</p>
                                    <svg className="icon-svg">
                                        <use xlinkHref='#iconyoujiantou'></use>
                                    </svg>
                                </a>
                            </div>
                        </dd>
                        <dd className='item box2'>
                            <label className='article-label blue'>
                                <svg className="icon-svg">
                                    <use xlinkHref='#iconwenzhangguanli'></use>
                                </svg>
                                "手记文章"
                            </label>
                            <div className="article-tit  blue">
                                <a href="">【前端学习路线升级版】看新手如何系统掌握前端技能</a>
                                <img src={img} alt=""/>
                            </div>
                            <p className='article-content'>
                                前端怎样入门？ 这一波良心推荐的【前端学习路线】干货，不谈虚的，直接来谈每个阶段要学习的内容 想入门前端的小伙伴们，那就放马过来吧！ 首先，给大家分享一张最新的以 企业岗位需求为导向前端技能点图，如下 根据前端工程师技能点图，我们分为四个阶段： 第一阶段：前端基础 （HTML / CSS / HTML5 / CSS3 / JavaScript ） 干货文章： 初识HTML+CSS 【学...
                            </p>
                            <div className="bottom-info blue">
                                <span>浏览 14010</span>
                                <span>推荐 163</span>
                                <a href="">
                                    <p>阅读全文</p>
                                    <svg className="icon-svg">
                                        <use xlinkHref='#iconyoujiantou'></use>
                                    </svg>
                                </a>
                            </div>
                        </dd>
                        <dd className='item box3'>
                            <label className='article-label blue'>
                                <svg className="icon-svg">
                                    <use xlinkHref='#iconwenzhangguanli'></use>
                                </svg>
                                "手记文章"
                            </label>
                            <div className="article-tit blue">
                                <a href="">我是怎么在高校教学平台学习并入职阿里Java工程师</a>
                                <img src={img} alt=""/>
                            </div>
                            <p className='article-content'>
                                经验多却面临上升瓶颈期？ 想成为工程师还差点火候？ 今天这波最实用的Java实战之路 以战养兵 为你打通职业发展脉络 沿着Java大牛们的思路， 逐步成长为一名业务与思想同样优秀的Java开发者。 就业、晋升、管理均游刃有余！ 不多说了，上干货！ 阅读指南：本文专为Java开发行业人员设计，分为四个阶段，循序渐进的带你进行SSM框架、SpringBoot框架、微服务...
                            </p>
                            <div className="bottom-info blue">
                                <span>浏览 14010</span>
                                <span>推荐 163</span>
                                <a href="">
                                    <p>阅读全文</p>
                                    <svg className="icon-svg">
                                        <use xlinkHref='#iconyoujiantou'></use>
                                    </svg>
                                </a>
                            </div>
                        </dd>
                        <dd className='item box4'>
                            <label className='wenda-label green'>
                                <svg className="icon-svg">
                                    <use xlinkHref="#iconwentiguanli"></use>
                                </svg>
                                "相关讨论"
                            </label>
                            <a className="wenda-tit">
                                计算机专业哪门专业课最难，哪门语言最难
                            </a>
                            <div>
                                <p className='best-label'>最赞回答</p>
                                <p className="wenda-content">我觉得不管学习哪门语言，到后面总还是要学习一下规范，程序员的素养必不可少啊！！</p>
                            </div>

                            <div className="bottom-info green" >
                                <a href="">
                                    <p>共154个回答</p>
                                    <svg className="icon-svg">
                                        <use xlinkHref='#iconyoujiantou'></use>
                                    </svg>
                                </a>
                            </div>
                        </dd>
                        <dd className='item box5'>
                            <label className='wenda-label green'>
                                <svg className="icon-svg">
                                    <use xlinkHref="#iconwentiguanli"></use>
                                </svg>
                                "相关讨论"
                            </label>
                            <a className="wenda-tit">
                                哪个老师是你们遇到过的最好的老师？
                            </a>
                            <div>
                                <p className='best-label'>最赞回答</p>
                                <p className="wenda-content">我觉得软件需求的邢卫和林海真的不错啊，一文一武，卧龙凤雏！</p>
                            </div>

                            <div className="bottom-info green" >
                                <a href="">
                                    <p>共154个回答</p>
                                    <svg className="icon-svg">
                                        <use xlinkHref='#iconyoujiantou'></use>
                                    </svg>
                                </a>
                            </div>
                        </dd>
                    </dl>

                </div>
            </div>
        );
    }
}

export default Item2;