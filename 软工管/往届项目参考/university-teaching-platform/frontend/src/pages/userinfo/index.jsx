import React from 'react';
import ReactDOM from 'react-dom';
import { Card, Row, Col, Divider, Avatar, Upload, Button, Tabs, Input} from "antd";
import { UserOutlined } from '@ant-design/icons';
import { UploadOutlined, InboxOutlined } from '@ant-design/icons';

import Login from '../../components/login/index.jsx'

const { TabPane } = Tabs;

function callback(key) {
  console.log(key);
}

class UserInfoPage extends React.Component {

    state = {
        isLogin: false,
        username: "",
        type:"",
        major:"",
        id:"",
        email:"",
        course:"",
        url:"",
        nickname:""
    }

    componentWillMount() {
        let isLogin = localStorage.getItem("isLogin")
        if(isLogin=="true"){
            this.state.isLogin = true;
            this.state.username = localStorage.getItem("username")
            this.state.type = localStorage.getItem("type")
        }
        this.attemptFetch()
        console.log(this.state.username)
        console.log(this.state.type)
    }

    attemptFetch = () =>
    {
        let url = "http://localhost:5000/userInfo?" + "userName=" + this.state.username + "&" +
            "type=" + this.state.type
        let fileurl="http://localhost:5000/fetchFile?" + "userName=" + this.state.username + "&" +
            "type=1"
        // 从外部取数据
        fetch(url, {
                method: "GET",
                mode: "cors",
            }
        )
        .then(response => response.json())
            .then(data => {
                console.log(data)
                if(this.state.type=="stu")
                {
                    this.setState({
                        id: data["id"],
                        major: data["major"],
                        email: data["email"],

                    })
                }
                else if(this.state.type=="ins")
                {
                    this.setState({
                        id: data["id"],
                        email: data["email"],
                        major:data["department"],

                    })
                }
                else if(this.state.type=="ta")
                {
                    this.setState({
                        id: data["teacherId"],
                        course: data["courseName"],

                    })
                }

                console.log(this.state.major)
            })

        fetch(fileurl, {
                method: "GET",
                mode: "cors",
            }
        )
        .then(response => response.json())
            .then(data => {
            console.log(data)
                if(this.state.type!="ta")
                {
                    this.setState({
                        url:data["url"]
                    })
                }
            })
    }

    attemptPost=()=>
    {
        let url = "http://localhost:5000/modifyInfo"
        fetch(url, {
                method: "POST",
                mode: "cors",
                body:'userName=${this.state.username}&passWD=""&nickName=${this.state.nickname}'
            }
        ).then((response)=>
        {
            return response.json()
        }).then((data)=>
        {
            console.log(data)
        })
    }

    render() {

        return (

            <>
                <br/>
                <br/>
                <Row>
                    <Col span={4}>
                    </Col>
                    <Col span={16}>
                        <Tabs defaultActiveKey="1" onChange={callback}>
                            <TabPane tab="信息查看" key="1" size="large">
                                <Divider plain >基本信息</Divider>
                                <Row>
                                    <Col span={2}></Col>
                                    <Col span={8}>
                                        姓名
                                    </Col>
                                    <Col>
                                        {this.state.username}
                                    </Col>
                                </Row>
                                <br/>
                                <Row>
                                    <Col span={2}></Col>
                                    <Col span={8}>
                                        头像
                                    </Col>
                                    <Col>
                                        <div>
                                              <el-avatar src={this.state.url}></el-avatar>
                                        </div>
                                    </Col>
                                </Row>
                                <br/>
                                <Row>
                                    <Col span={2}></Col>
                                    <Col span={8}>
                                        平台角色
                                    </Col>
                                    <Col>
                                        {this.state.type}
                                    </Col>
                                </Row>
                                <br/>
                                <Row>
                                    <Col span={2}></Col>
                                    <Col span={8}>
                                        人员编号
                                    </Col>
                                    <Col>
                                        {this.state.id}
                                    </Col>
                                </Row>
                                <br/>
                                <Row>
                                    <Col span={2}></Col>
                                    {this.state.type=="ins"&&
                                    <Col span={8}>
                                        系级
                                    </Col>
                                    }
                                    {this.state.type=="stu"&&
                                    <Col span={8}>
                                        系级
                                    </Col>
                                    }
                                    {this.state.type!="ta"&&
                                    <Col>
                                        {this.state.major}
                                    </Col>
                                    }
                                </Row>
                                <br/>
                                {this.state.type!="ta"&&
                                <Divider plain>账号绑定</Divider>
                                }
                                {this.state.type!="ta"&&
                                <Row>
                                    <Col span={2}></Col>
                                    <Col span={8}>
                                        Email
                                    </Col>
                                    <Col>
                                        {this.state.email}
                                    </Col>
                                </Row>
                                }
                                <br/>
                                <Row>
                                    <Col span={2}></Col>
                                    <Col span={8}>
                                        手机号
                                    </Col>
                                    <Col>
                                        {this.state.nickname}
                                    </Col>
                                </Row>
                            </TabPane>
                            <TabPane tab="信息修改" key="2" size="large">
                                {this.state.type!="ta"&&
                                <Divider plain>账号绑定</Divider>
                                }
                                {this.state.type!="ta"&&
                                <Row>
                                    <Col span={2}></Col>
                                    <Col span={8}>
                                        手机号
                                    </Col>
                                    <Col>
                                        <Input placeholder={this.state.nickname}/>
                                    </Col>
                                </Row>
                                }
                                <br/>
                                <div style={{textAlign:'center'}}>
                                    <Button onClick={()=>this.attemptPost()} >确定修改</Button>
                                </div>
                            </TabPane>
                        </Tabs>
                    </Col>
                    <Col span={4}>
                    </Col>
                </Row>


            </>


        );
    }
}

export default UserInfoPage;

