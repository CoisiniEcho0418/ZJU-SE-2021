import React, {Component} from 'react';
import {Modal, Select, Tag} from 'antd'

const { Option } = Select;

class Login extends Component {
    state = {
        visible: false,
        tabStatus:'login',
        username: "",
        password: "",
        isWrongIdentity: false,
        isLogin: false,
        type: ""
    };

    showModal = () => {
        this.setState({
            visible: true,
        });
    };

    navigateToUserhome = () => {
        window.location.href = '/user/home';
    }

    handleCancel = e => {
        this.setState({
            visible: false,
            isWrongIdentity: false
        });
    };

    handleUsernameChange = e => {
        this.setState({
            username: e.target.value
        })
    }

    handlePasswordChange = e => {
        this.setState({
            password: e.target.value
        })
    }

    handleTypeChange = e => {
        this.setState({
            type: e
        })
    }

    attemptLogin = () => {

        let url = "http://localhost:5000/loginValidness?" + "userName=" + this.state.username + "&" +
            "passWD=" + this.state.password + "&" + "type=" + this.state.type;
        let form = {
            'userName': this.state.username,
            'passWD': this.state.password,
            'type': this.state.type
        }
        // 从外部取数据
        fetch(url, {
                method: "GET",
                mode: "cors",
                //body: JSON.stringify(form),
            }
        )
        .then(response => response.json())
            .then(data => {

            if(data["identity"] == true && data["match"] == true) {
                this.setState({
                    isLogin: true,
                    isWrongIdentity: false,
                    visible: false // 模态窗消失
                })
                // 获取用户信息并存到local中
                localStorage.setItem("isLogin", "true")
                localStorage.setItem("username", this.state.username)
                localStorage.setItem("password", this.state.password)
                localStorage.setItem("type", this.state.type)
                this.navigateToUserhome()
            }
            else {
                this.setState({
                    isLogin: false,
                    isWrongIdentity: true
                })
                console.log(this.state.isLogin)
            }
        }).catch(function (e) {
            console.log(e);
        });
    }

    render() {
        let {tabStatus, isWrongIdentity}=this.state
        return (
            <div className='login-container'>
                <Modal
                    visible={this.state.visible}
                    onCancel={this.handleCancel}
                    footer={null}
                    className='login-modal'
                    centered={true}
                    width={384}
                    closable={false}
                >
                    <div className="modal-content">
                        <div className="modal-header">
                            <div
                                className={tabStatus=='login'?'text active':'text'}
                                onClick={()=>this.changeTab('login')}>登陆
                                <span></span>
                            </div>
                            <div
                                className={tabStatus=='register'?'text active':'text'}
                                onClick={()=>this.changeTab('register')}>注册
                                <span></span>
                            </div>
                        </div>

                        {tabStatus=='login'&&
                        <div className="login-box">
                            <div className="modal-input">
                                <div className="input-box">
                                    <input onChange={this.handleUsernameChange.bind(this)} type="text" placeholder='请输入用户名' />
                                </div>
                                <div className="input-box">
                                    <input onChange={this.handlePasswordChange.bind(this)} type="password" placeholder='请输入密码'/>
                                </div>

                                <div style={{ marginTop:16 }}>
                                    <Select
                                        showSearch
                                        style={{ width: 200 }}
                                        placeholder="选择登录身份"
                                        optionFilterProp="children"
                                        onChange={this.handleTypeChange.bind(this)}
                                        filterOption={(input, option) =>
                                            option.children.toLowerCase().indexOf(input.toLowerCase()) >= 0
                                        }
                                    >
                                        <Option value="ins">教师</Option>
                                        <Option value="stu">学生</Option>
                                        <Option value="ta">助教</Option>
                                    </Select>,
                                </div>

                                {isWrongIdentity==true&&
                                <div style={{ marginTop:16 }}>
                                    <Tag color="#f50">账号或密码错误</Tag>
                                </div>}

                                <div className="input-bottom">
                                    <div className="autoLogin"><input type="checkbox"/>7天内自动登录</div>
                                    <div className="searchSecret"><span>找回密码</span><div className='line'>|</div><span>无法登录</span></div>
                                </div>

                            </div>
                            <div className="loginBtn" onClick={()=>this.attemptLogin()}>登录</div>
                            <div className="login-bottom">
                                <div className="text">手机短信登陆</div>
                                <div className="line"></div>
                                <svg className='icon-svg'>
                                    <use xlinkHref='#iconxinlangweibo'></use>
                                </svg>
                                <svg className='icon-svg1'>
                                    <use xlinkHref='#iconweixin'></use>
                                </svg>
                                <svg className='icon-svg2'>
                                    <use xlinkHref='#iconQQ'></use>
                                </svg>
                            </div>
                            <div className="rightBottom">
                                <div className="caret"></div>
                                <svg className='icon-svg'>
                                    <use xlinkHref='#iconerweima'></use>
                                </svg>
                            </div>
                        </div>}
                        {tabStatus=='register'&&<div className="register-box">
                            <div className="modal-input">
                                <div className="input-box">
                                    <input type="text" placeholder='请输入用户名'/>
                                </div>
                                <div className="input-box">
                                    <input type="password" placeholder='请输入密码'/>
                                </div>
                                <div className="input-bottom">
                                    <div className="autoLogin"><input type="checkbox"/>同意  </div>
                                    <span>《高校教学平台注册协议》</span>
                                </div>

                            </div>
                            <div className="loginBtn">注册</div>
                            <div className="login-bottom">
                                <div className="text">其他方式登录</div>
                                <div className="line"></div>
                                <svg className='icon-svg2'>
                                    <use xlinkHref='#iconQQ'></use>
                                </svg>
                                <svg className='icon-svg1'>
                                    <use xlinkHref='#iconweixin'></use>
                                </svg>
                                <svg className='icon-svg'>
                                    <use xlinkHref='#iconxinlangweibo'></use>
                                </svg>
                            </div>
                        </div>}

                    </div>
                </Modal>
            </div>
        );
    }

    changeTab=(value)=>{
        this.setState({
            tabStatus:value
        })
    }

}

export default Login;