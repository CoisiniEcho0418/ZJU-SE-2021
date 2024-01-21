import React,{Component} from 'react'
import footer from '../../assets/images/footer/a9.png'

/**
 * footer
 */
class WebFooter extends Component {

    render() {

        return (
            <div className='footer-container'>
                <div className="container">
                    <div className="footer-sns">
                        <div className="sns-box">
                            <svg className='icon-svg'>
                                <use xlinkHref='#iconweixin-copy'></use>
                            </svg>
                            <p>官方公众号</p>
                        </div>
                        <a href='https://weibo.com/u/6774617268' className="sns-box">
                            <svg className='icon-svg'>
                                <use xlinkHref='#iconweibo-copy'></use>
                            </svg>
                            <p>官方微博</p>
                        </a>

                    </div>
                    <div className="footer-link">
                        <a href="">企业合作</a>
                        <a href="">人才招聘</a>
                        <a href="">联系我们</a>
                        <a href="">讲师招募</a>
                        <a href="">帮助中心</a>
                        <a href="">意见反馈</a>
                        <a href="">代码托管</a>
                        <a href="">友情链接</a>
                    </div>
                    <div className="footer-copyright">
                        <img src={footer} alt=""/>
                        <div className="text">
                            2020 COPYRIGHT@SEM G24
                        </div>
                    </div>
                </div>
            </div>
        )
    }
}

export default WebFooter