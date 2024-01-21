import React,{Component} from 'react'
import Slider from "../../components/swiper/slider";
import imgHot from "../../assets/images/banner-bottom/new-path.png";
import img from "../../assets/images/zhanwei.png";
import img1 from "../../assets/images/banner/1.jpg";
import img2 from "../../assets/images/banner/2.jpg";

class Item1 extends Component{
    constructor(props){
        super(props)
        this.state={
            tabStatus:''
        }
    }
    changeStatus=(status)=>{
        this.setState({tabStatus:status})
    }
    render(){
        const list=[
            {
                bannerId:1,
                bannerImage:img1
            },
            {
                bannerId:2,
                bannerImage:img2
            }
        ]
        const color='rgba(0,98,225,0.1)'
        const { tabStatus } =this.state
        return (
            <div className="item1-box" style={{background: `linear-gradient(${color}, white)`}}>
                <div className="navbar-container" onMouseLeave={()=>this.setState({tabStatus:''})}>
                    <div className="menubar" >
                        <div className="menuContent"  >
                            <div className="item" onMouseOver={()=>this.changeStatus('a')}>
                                <a href="javascript:void(0)">
                                    <span className="group">前沿 / 计算机 / 软件工程</span>
                                    <i className="arrow"></i>
                                </a>
                                {tabStatus=='a'&&<div className="menu-list" >
                                    <div className="title"><p>前沿技术</p><span></span></div>
                                    <ul className='list'>
                                        <a target="_blank" href="">操作系统</a>
                                        <a target="_blank" href="">区块链与数字货币</a>
                                        <a target="_blank" href="">软件工程基础</a>
                                        <a target="_blank" href="">软件需求工程</a>
                                        <a target="_blank" href="">软件质量测试</a>
                                        <a target="_blank" href="">计算机网络</a>
                                        <a target="_blank" href="">B/S体系设计</a>
                                        <a target="_blank" href="">高级数据结构与算法分析</a>
                                        <a target="_blank" href="">计算机科学思想史</a>
                                    </ul>
                                </div>}
                            </div>
                            <div className="item" onMouseOver={()=>this.setState({tabStatus:'b'})}>
                                <a href="javascript:void(0)">
                                    <span className="group">外语 / 听力 / 翻译</span>
                                    <i className="arrow"></i>
                                </a>
                                {tabStatus=='b'&&<div className="menu-list" >
                                    <div className="title"><p>外语学习</p><span></span></div>
                                    <ul className='list'>
                                        <a target="_blank" href="">托福听力</a>
                                        <a target="_blank" href="">托福阅读</a>
                                        <a target="_blank" href="">托福写作</a>
                                        <a target="_blank" href="">托福口语</a>
                                        <a target="_blank" href="">英语小说鉴赏</a>
                                        <a target="_blank" href="">大学英语Ⅳ</a>
                                        <a target="_blank" href="">大学英语Ⅲ</a>
                                        <a target="_blank" href="">韩语1</a>
                                        <a target="_blank" href="">法语2</a>
                                        <a target="_blank" href="">俄语3</a>
                                        <a target="_blank" href="">英语视听说</a>
                                    </ul>
                                </div>}
                            </div>
                            <div className="item">
                                <a href="javascript:void(0)">
                                    <span className="group">理学 / 数学 / 物理</span>
                                    <i className="arrow"></i>
                                </a>
                            </div>
                            <div className="item">
                                <a href="javascript:void(0)">
                                    <span className="group">工学 / 力学 / 材料</span>
                                    <i className="arrow"></i>
                                </a>
                            </div>
                            <div className="item">
                                <a href="javascript:void(0)">
                                    <span className="group">文史哲 / 文学 / 政治</span>
                                    <i className="arrow"></i>
                                </a>
                            </div>
                            <div className="item">
                                <a href="javascript:void(0)">
                                    <span className="group">新闻 / 传媒 / 广告</span>
                                    <i className="arrow"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                    <div className="slider-box">
                        <Slider
                            items={list}
                            speed={1}
                            delay={3}
                            pause={true}
                            autoplay={true}
                            dots={true}
                        />
                        <div className="slider-bottom">
                            <div className="item">
                                <i className='i-icon icon1'></i>
                                <div className="tit">浙江大学</div>
                                <div className="desc">QS亚洲排名第二的内陆名校</div>
                            </div>
                            <div className="item">
                                <i className='i-icon icon2'></i>
                                <div className="tit">北京大学</div>
                                <div className="desc">世界闻名的高等学府</div>
                            </div>
                            <div className="item">
                                <i className='i-icon icon3'></i>
                                <div className="tit">清华大学</div>
                                <div className="desc">与北大齐名的高等学府</div>
                            </div>
                            <div className="item">
                                <i className='i-icon icon4'></i>
                                <div className="tit">复旦大学</div>
                                <div className="desc">被誉为上海之光的高等学府</div>
                            </div>
                            <div className="item">
                                <i className='i-icon icon5'></i>
                                <div className="tit">中南大学</div>
                                <div className="desc">医学研究驰名中外</div>
                            </div>
                        </div>
                    </div>

                </div>
                <div className="item1-2">
                    <h3 className="types-title">
                        <span className="tit-icon icon-shizhan-l tit-icon-l"></span>
                        <em>热</em>／<em>门</em>／<em>课</em>／<em>程</em>
                        <span className="tit-icon icon-shizhan-r tit-icon-r"></span>
                    </h3>
                    <div className="types-content">
                        <div className="item">
                            <div className="course-card-top">
                                <img src={img} alt=""/>
                                <div className="course-label">
                                    <label>计算机</label>
                                    <label>管理</label>
                                </div>
                            </div>
                            <div className="course-card-content">
                                <div className="course-card-name">
                                    四大名师助阵，让你从零到一学会项目管理和实践
                                </div>
                                <div className="course-card-bottom">
                                    <div className="course-card-info">
                                        <span>计算机</span>
                                        <span>高级</span>
                                        <span>
                                                <svg className='icon-svg'>
                                                    <use xlinkHref='#iconyonghuming'></use>
                                                </svg>
                                                8439
                                            </span>
                                        <span className="course-star-box">
                                                <svg className='icon-svg'><use xlinkHref='#icongongneng_xingxing-'></use></svg>
                                                <svg className='icon-svg'><use xlinkHref='#icongongneng_xingxing-'></use></svg>
                                                <svg className='icon-svg'><use xlinkHref='#icongongneng_xingxing-'></use></svg>
                                                <svg className='icon-svg'><use xlinkHref='#icongongneng_xingxing-'></use></svg>
                                                <svg className='icon-svg'><use xlinkHref='#icongongneng_xingxing-'></use></svg>
                                            </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div className="item">
                            <div className="course-card-top">
                                <img src={img} alt=""/>
                                <div className="course-label">
                                    <label>计算机</label>
                                    <label>管理</label>
                                </div>
                            </div>
                            <div className="course-card-content">
                                <div className="course-card-name">
                                    四大名师助阵，让你从零到一学会项目管理和实践
                                </div>
                                <div className="course-card-bottom">
                                    <div className="course-card-info">
                                        <span>计算机</span>
                                        <span>高级</span>
                                        <span>
                                                <svg className='icon-svg'>
                                                    <use xlinkHref='#iconyonghuming'></use>
                                                </svg>
                                                8439
                                            </span>
                                        <span className="course-star-box">
                                                <svg className='icon-svg'><use xlinkHref='#icongongneng_xingxing-'></use></svg>
                                                <svg className='icon-svg'><use xlinkHref='#icongongneng_xingxing-'></use></svg>
                                                <svg className='icon-svg'><use xlinkHref='#icongongneng_xingxing-'></use></svg>
                                                <svg className='icon-svg'><use xlinkHref='#icongongneng_xingxing-'></use></svg>
                                                <svg className='icon-svg'><use xlinkHref='#icongongneng_xingxing-'></use></svg>
                                            </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div className="item">
                            <div className="course-card-top">
                                <img src={img} alt=""/>
                                <div className="course-label">
                                    <label>计算机</label>
                                    <label>管理</label>
                                </div>
                            </div>
                            <div className="course-card-content">
                                <div className="course-card-name">
                                    四大名师助阵，让你从零到一学会项目管理和实践
                                </div>
                                <div className="course-card-bottom">
                                    <div className="course-card-info">
                                        <span>计算机</span>
                                        <span>高级</span>
                                        <span>
                                                <svg className='icon-svg'>
                                                    <use xlinkHref='#iconyonghuming'></use>
                                                </svg>
                                                8439
                                            </span>
                                        <span className="course-star-box">
                                                <svg className='icon-svg'><use xlinkHref='#icongongneng_xingxing-'></use></svg>
                                                <svg className='icon-svg'><use xlinkHref='#icongongneng_xingxing-'></use></svg>
                                                <svg className='icon-svg'><use xlinkHref='#icongongneng_xingxing-'></use></svg>
                                                <svg className='icon-svg'><use xlinkHref='#icongongneng_xingxing-'></use></svg>
                                                <svg className='icon-svg'><use xlinkHref='#icongongneng_xingxing-'></use></svg>
                                            </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div className="item">
                            <div className="course-card-top">
                                <img src={img} alt=""/>
                                <div className="course-label">
                                    <label>计算机</label>
                                    <label>管理</label>
                                </div>
                            </div>
                            <div className="course-card-content">
                                <div className="course-card-name">
                                    四大名师助阵，让你从零到一学会项目管理和实践
                                </div>
                                <div className="course-card-bottom">
                                    <div className="course-card-info">
                                        <span>计算机</span>
                                        <span>高级</span>
                                        <span>
                                                <svg className='icon-svg'>
                                                    <use xlinkHref='#iconyonghuming'></use>
                                                </svg>
                                                8439
                                            </span>
                                        <span className="course-star-box">
                                                <svg className='icon-svg'><use xlinkHref='#icongongneng_xingxing-'></use></svg>
                                                <svg className='icon-svg'><use xlinkHref='#icongongneng_xingxing-'></use></svg>
                                                <svg className='icon-svg'><use xlinkHref='#icongongneng_xingxing-'></use></svg>
                                                <svg className='icon-svg'><use xlinkHref='#icongongneng_xingxing-'></use></svg>
                                                <svg className='icon-svg'><use xlinkHref='#icongongneng_xingxing-'></use></svg>
                                            </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div className="item">
                            <div className="course-card-top">
                                <img src={img} alt=""/>
                                <div className="course-label">
                                    <label>计算机</label>
                                    <label>管理</label>
                                </div>
                            </div>
                            <div className="course-card-content">
                                <div className="course-card-name">
                                    四大名师助阵，让你从零到一学会项目管理和实践
                                </div>
                                <div className="course-card-bottom">
                                    <div className="course-card-info">
                                        <span>计算机</span>
                                        <span>高级</span>
                                        <span>
                                                <svg className='icon-svg'>
                                                    <use xlinkHref='#iconyonghuming'></use>
                                                </svg>
                                                8439
                                            </span>
                                        <span className="course-star-box">
                                                <svg className='icon-svg'><use xlinkHref='#icongongneng_xingxing-'></use></svg>
                                                <svg className='icon-svg'><use xlinkHref='#icongongneng_xingxing-'></use></svg>
                                                <svg className='icon-svg'><use xlinkHref='#icongongneng_xingxing-'></use></svg>
                                                <svg className='icon-svg'><use xlinkHref='#icongongneng_xingxing-'></use></svg>
                                                <svg className='icon-svg'><use xlinkHref='#icongongneng_xingxing-'></use></svg>
                                            </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div className="item">
                            <div className="course-card-top">
                                <img src={img} alt=""/>
                                <div className="course-label">
                                    <label>计算机</label>
                                    <label>管理</label>
                                </div>
                            </div>
                            <div className="course-card-content">
                                <div className="course-card-name">
                                    四大名师助阵，让你从零到一学会项目管理和实践
                                </div>
                                <div className="course-card-bottom">
                                    <div className="course-card-info">
                                        <span>计算机</span>
                                        <span>高级</span>
                                        <span>
                                                <svg className='icon-svg'>
                                                    <use xlinkHref='#iconyonghuming'></use>
                                                </svg>
                                                8439
                                            </span>
                                        <span className="course-star-box">
                                                <svg className='icon-svg'><use xlinkHref='#icongongneng_xingxing-'></use></svg>
                                                <svg className='icon-svg'><use xlinkHref='#icongongneng_xingxing-'></use></svg>
                                                <svg className='icon-svg'><use xlinkHref='#icongongneng_xingxing-'></use></svg>
                                                <svg className='icon-svg'><use xlinkHref='#icongongneng_xingxing-'></use></svg>
                                                <svg className='icon-svg'><use xlinkHref='#icongongneng_xingxing-'></use></svg>
                                            </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div className="item">
                            <div className="course-card-top">
                                <img src={img} alt=""/>
                                <div className="course-label">
                                    <label>计算机</label>
                                    <label>管理</label>
                                </div>
                            </div>
                            <div className="course-card-content">
                                <div className="course-card-name">
                                    四大名师助阵，让你从零到一学会项目管理和实践
                                </div>
                                <div className="course-card-bottom">
                                    <div className="course-card-info">
                                        <span>计算机</span>
                                        <span>高级</span>
                                        <span>
                                                <svg className='icon-svg'>
                                                    <use xlinkHref='#iconyonghuming'></use>
                                                </svg>
                                                8439
                                            </span>
                                        <span className="course-star-box">
                                                <svg className='icon-svg'><use xlinkHref='#icongongneng_xingxing-'></use></svg>
                                                <svg className='icon-svg'><use xlinkHref='#icongongneng_xingxing-'></use></svg>
                                                <svg className='icon-svg'><use xlinkHref='#icongongneng_xingxing-'></use></svg>
                                                <svg className='icon-svg'><use xlinkHref='#icongongneng_xingxing-'></use></svg>
                                                <svg className='icon-svg'><use xlinkHref='#icongongneng_xingxing-'></use></svg>
                                            </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div className="item">
                            <div className="course-card-top">
                                <img src={img} alt=""/>
                                <div className="course-label">
                                    <label>计算机</label>
                                    <label>管理</label>
                                </div>
                            </div>
                            <div className="course-card-content">
                                <div className="course-card-name">
                                    四大名师助阵，让你从零到一学会项目管理和实践
                                </div>
                                <div className="course-card-bottom">
                                    <div className="course-card-info">
                                        <span>计算机</span>
                                        <span>高级</span>
                                        <span>
                                                <svg className='icon-svg'>
                                                    <use xlinkHref='#iconyonghuming'></use>
                                                </svg>
                                                8439
                                            </span>
                                        <span className="course-star-box">
                                                <svg className='icon-svg'><use xlinkHref='#icongongneng_xingxing-'></use></svg>
                                                <svg className='icon-svg'><use xlinkHref='#icongongneng_xingxing-'></use></svg>
                                                <svg className='icon-svg'><use xlinkHref='#icongongneng_xingxing-'></use></svg>
                                                <svg className='icon-svg'><use xlinkHref='#icongongneng_xingxing-'></use></svg>
                                                <svg className='icon-svg'><use xlinkHref='#icongongneng_xingxing-'></use></svg>
                                            </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div className="item">
                            <div className="course-card-top">
                                <img src={img} alt=""/>
                                <div className="course-label">
                                    <label>计算机</label>
                                    <label>管理</label>
                                </div>
                            </div>
                            <div className="course-card-content">
                                <div className="course-card-name">
                                    四大名师助阵，让你从零到一学会项目管理和实践
                                </div>
                                <div className="course-card-bottom">
                                    <div className="course-card-info">
                                        <span>计算机</span>
                                        <span>高级</span>
                                        <span>
                                                <svg className='icon-svg'>
                                                    <use xlinkHref='#iconyonghuming'></use>
                                                </svg>
                                                8439
                                            </span>
                                        <span className="course-star-box">
                                                <svg className='icon-svg'><use xlinkHref='#icongongneng_xingxing-'></use></svg>
                                                <svg className='icon-svg'><use xlinkHref='#icongongneng_xingxing-'></use></svg>
                                                <svg className='icon-svg'><use xlinkHref='#icongongneng_xingxing-'></use></svg>
                                                <svg className='icon-svg'><use xlinkHref='#icongongneng_xingxing-'></use></svg>
                                                <svg className='icon-svg'><use xlinkHref='#icongongneng_xingxing-'></use></svg>
                                            </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div className="item">
                            <div className="course-card-top">
                                <img src={img} alt=""/>
                                <div className="course-label">
                                    <label>计算机</label>
                                    <label>管理</label>
                                </div>
                            </div>
                            <div className="course-card-content">
                                <div className="course-card-name">
                                    四大名师助阵，让你从零到一学会项目管理和实践
                                </div>
                                <div className="course-card-bottom">
                                    <div className="course-card-info">
                                        <span>计算机</span>
                                        <span>高级</span>
                                        <span>
                                                <svg className='icon-svg'>
                                                    <use xlinkHref='#iconyonghuming'></use>
                                                </svg>
                                                8439
                                            </span>
                                        <span className="course-star-box">
                                                <svg className='icon-svg'><use xlinkHref='#icongongneng_xingxing-'></use></svg>
                                                <svg className='icon-svg'><use xlinkHref='#icongongneng_xingxing-'></use></svg>
                                                <svg className='icon-svg'><use xlinkHref='#icongongneng_xingxing-'></use></svg>
                                                <svg className='icon-svg'><use xlinkHref='#icongongneng_xingxing-'></use></svg>
                                                <svg className='icon-svg'><use xlinkHref='#icongongneng_xingxing-'></use></svg>
                                            </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div className="item">
                            <div className="course-card-top">
                                <img src={img} alt=""/>
                                <div className="course-label">
                                    <label>计算机</label>
                                    <label>管理</label>
                                </div>
                            </div>
                            <div className="course-card-content">
                                <div className="course-card-name">
                                    四大名师助阵，让你从零到一学会项目管理和实践
                                </div>
                                <div className="course-card-bottom">
                                    <div className="course-card-info">
                                        <span>计算机</span>
                                        <span>高级</span>
                                        <span>
                                                <svg className='icon-svg'>
                                                    <use xlinkHref='#iconyonghuming'></use>
                                                </svg>
                                                8439
                                            </span>
                                        <span className="course-star-box">
                                                <svg className='icon-svg'><use xlinkHref='#icongongneng_xingxing-'></use></svg>
                                                <svg className='icon-svg'><use xlinkHref='#icongongneng_xingxing-'></use></svg>
                                                <svg className='icon-svg'><use xlinkHref='#icongongneng_xingxing-'></use></svg>
                                                <svg className='icon-svg'><use xlinkHref='#icongongneng_xingxing-'></use></svg>
                                                <svg className='icon-svg'><use xlinkHref='#icongongneng_xingxing-'></use></svg>
                                            </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div className="item">
                            <div className="course-card-top">
                                <img src={img} alt=""/>
                                <div className="course-label">
                                    <label>计算机</label>
                                    <label>管理</label>
                                </div>
                            </div>
                            <div className="course-card-content">
                                <div className="course-card-name">
                                    四大名师助阵，让你从零到一学会项目管理和实践
                                </div>
                                <div className="course-card-bottom">
                                    <div className="course-card-info">
                                        <span>计算机</span>
                                        <span>高级</span>
                                        <span>
                                                <svg className='icon-svg'>
                                                    <use xlinkHref='#iconyonghuming'></use>
                                                </svg>
                                                8439
                                            </span>
                                        <span className="course-star-box">
                                                <svg className='icon-svg'><use xlinkHref='#icongongneng_xingxing-'></use></svg>
                                                <svg className='icon-svg'><use xlinkHref='#icongongneng_xingxing-'></use></svg>
                                                <svg className='icon-svg'><use xlinkHref='#icongongneng_xingxing-'></use></svg>
                                                <svg className='icon-svg'><use xlinkHref='#icongongneng_xingxing-'></use></svg>
                                                <svg className='icon-svg'><use xlinkHref='#icongongneng_xingxing-'></use></svg>
                                            </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div className="item">
                            <div className="course-card-top">
                                <img src={img} alt=""/>
                                <div className="course-label">
                                    <label>计算机</label>
                                    <label>管理</label>
                                </div>
                            </div>
                            <div className="course-card-content">
                                <div className="course-card-name">
                                    四大名师助阵，让你从零到一学会项目管理和实践
                                </div>
                                <div className="course-card-bottom">
                                    <div className="course-card-info">
                                        <span>计算机</span>
                                        <span>高级</span>
                                        <span>
                                                <svg className='icon-svg'>
                                                    <use xlinkHref='#iconyonghuming'></use>
                                                </svg>
                                                8439
                                            </span>
                                        <span className="course-star-box">
                                                <svg className='icon-svg'><use xlinkHref='#icongongneng_xingxing-'></use></svg>
                                                <svg className='icon-svg'><use xlinkHref='#icongongneng_xingxing-'></use></svg>
                                                <svg className='icon-svg'><use xlinkHref='#icongongneng_xingxing-'></use></svg>
                                                <svg className='icon-svg'><use xlinkHref='#icongongneng_xingxing-'></use></svg>
                                                <svg className='icon-svg'><use xlinkHref='#icongongneng_xingxing-'></use></svg>
                                            </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div className="item">
                            <div className="course-card-top">
                                <img src={img} alt=""/>
                                <div className="course-label">
                                    <label>计算机</label>
                                    <label>管理</label>
                                </div>
                            </div>
                            <div className="course-card-content">
                                <div className="course-card-name">
                                    四大名师助阵，让你从零到一学会项目管理和实践
                                </div>
                                <div className="course-card-bottom">
                                    <div className="course-card-info">
                                        <span>计算机</span>
                                        <span>高级</span>
                                        <span>
                                                <svg className='icon-svg'>
                                                    <use xlinkHref='#iconyonghuming'></use>
                                                </svg>
                                                8439
                                            </span>
                                        <span className="course-star-box">
                                                <svg className='icon-svg'><use xlinkHref='#icongongneng_xingxing-'></use></svg>
                                                <svg className='icon-svg'><use xlinkHref='#icongongneng_xingxing-'></use></svg>
                                                <svg className='icon-svg'><use xlinkHref='#icongongneng_xingxing-'></use></svg>
                                                <svg className='icon-svg'><use xlinkHref='#icongongneng_xingxing-'></use></svg>
                                                <svg className='icon-svg'><use xlinkHref='#icongongneng_xingxing-'></use></svg>
                                            </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div className="item">
                            <div className="course-card-top">
                                <img src={img} alt=""/>
                                <div className="course-label">
                                    <label>计算机</label>
                                    <label>管理</label>
                                </div>
                            </div>
                            <div className="course-card-content">
                                <div className="course-card-name">
                                    四大名师助阵，让你从零到一学会项目管理和实践
                                </div>
                                <div className="course-card-bottom">
                                    <div className="course-card-info">
                                        <span>计算机</span>
                                        <span>高级</span>
                                        <span>
                                                <svg className='icon-svg'>
                                                    <use xlinkHref='#iconyonghuming'></use>
                                                </svg>
                                                8439
                                        </span>
                                        <span className="course-star-box">
                                                <svg className='icon-svg'><use xlinkHref='#icongongneng_xingxing-'></use></svg>
                                                <svg className='icon-svg'><use xlinkHref='#icongongneng_xingxing-'></use></svg>
                                                <svg className='icon-svg'><use xlinkHref='#icongongneng_xingxing-'></use></svg>
                                                <svg className='icon-svg'><use xlinkHref='#icongongneng_xingxing-'></use></svg>
                                                <svg className='icon-svg'><use xlinkHref='#icongongneng_xingxing-'></use></svg>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        )
    }
}
export default Item1