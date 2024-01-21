import React from 'react';

import Login from '../login/index.jsx'

import logo from "../../assets/images/header/logo.png"

/**
 * logo + 导航栏
 */

class WebHeader extends React.Component {

    state = {
        isLogin: false,
        username: ""
    }

    componentWillMount() {
        // 从local中取得登陆状态，然后对登陆状态判断，如果是true，就更改header组件的状态
        // 因为localStorage只能用（string，string）键值对方式存储，所以这里判断是对"true"
        let isLogin = localStorage.getItem("isLogin")
        if(isLogin=="true"){
            this.setState({
                isLogin: true,
                username: localStorage.getItem("username")
            })
        }
    }

    navigateToHot = () => {
        window.location.href = '/home';
    }

    navigateToUserhome = () => {
        window.location.href = '/user/home';
    }

    navigateToUserInfo = () => {
        window.location.href = '/user/setting';
    }

    cancelState = () => {
        // 注销数据，消除登陆状态和用户信息
        localStorage.removeItem("isLogin")
        localStorage.removeItem("username")
        localStorage.removeItem("password")
        localStorage.removeItem("type")
        this.navigateToHot()
    }

    render() {

        return (
            <div className="header-container">
                <div className="header-logo">
                    <img src={logo}/>
                </div>
                <div className="header-ul">
                    <li onClick={this.navigateToHot}>热门课程</li>
                    {this.state.isLogin==true&&
                    <div>
                        <li onClick={this.navigateToUserhome}>我的课程</li>
                    </div>}
                    {this.state.isLogin==true&&
                    <div>
                        <li onClick={this.navigateToUserInfo}>个人信息</li>
                    </div>}
                    <li>文章</li>
                    <li>手记</li>
                </div>

                <div className="header-input">
                    <input type="text"
                    />
                    <div className={"input-search"}>
                        <svg className='icon-svg'>
                            <use xlinkHref='#iconsousuo'></use>
                        </svg>
                    </div>
                </div>

                {this.state.isLogin==false&&
                <div className="header-right">
                    <Login ref={node => this.login = node}/>
                    <div className="header-btn login"
                         onClick={() => {
                        this.login.showModal()
                        this.login.changeTab('login')
                    }}>登录
                    </div>
                    <div className='btn-line'>/</div>
                    <div className="header-btn register" onClick={() => {

                    }}>注册
                    </div>
                </div>}
                {this.state.isLogin==true&&
                <div className="header-right">
                    <Login ref={node => this.login = node}/>
                    <div className="header-btn login" >
                        欢迎，{this.state.username}
                    </div>
                    <div className='btn-line'>/</div>
                    <div className="header-btn register" onClick={
                        this.cancelState
                    }>注销
                    </div>
                </div>}

            </div>
        )

    }
}

export default WebHeader