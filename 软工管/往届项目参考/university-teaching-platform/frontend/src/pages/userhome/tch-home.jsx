import React from 'react';
import Notes from './notes';
import Lou from '../../assets/images/user/lou.jpg';

class TchHome extends React.Component{
    constructor(props) {
        super(props);
        let type = localStorage.getItem("type") || 'tch';
        let id = localStorage.getItem("username") || 'Lou';
        this.state = {
            get_info_url: "http://localhost:5000/userinfo",
            course_url: "http://localhost:5000/manageCourse",
            user_type: type,
            user_id: id,
            chosen_item: "notice",
            courses: [],
            notices: [{
                title: "软件需求规格说明书（重点）作业发布",
                time: "2020-12-11 17:21 p.m.",
                due: "已过期",
                text: "请大家注意截止日期，及时提交",
            },{
                title: "软件需求工程组会纪要提交提醒",
                time: "2020-12-07 19:21 p.m.",
                due: "已过期",
                text: "还没有交组会纪要的小组请赶快提交",
            },{
                title: "软件需求工程开课公告",
                time: "2020-09-13 09:19 a.m.",
                due: "已过期",
                text: "软件需求工程课程即将于9月16日（星期三）开课，请大家提前做好准备",
            }]
        }
    }
    
    componentWillMount() {
        fetch(this.state.course_url, {
                method: "GET",
                mode: "cors",
            }
        )
        .then(response => response.json())
        .then(data => {
            this.setState({courses: data.length? data: [{'课程标识符': 1, '课程名称': '软件需求工程'}, 
            {'课程标识符': 2, '课程名称': '软件工程管理'}, 
            {'课程标识符': 3, '课程名称': '软件质量保证与测试'}, 
            {'课程标识符': 4, '课程名称': '服务科学导论'}, 
            {'课程标识符': 5, '课程名称': '软件工程基础'}]})
        }).catch(function (e) {
            console.log(e);
        });
    }
    
    
    get_avatar(){
        return Lou;
    }
    
    get_name(){
        return this.state.user_id
    }
    
    get_notices(){
        let notices = this.state.notices
        return (
            <div class={"notices-list"}>
                {notices.map(item=>(
                    <div class={'notice-item'} key={item}>
                        <div class={'notice-header'}>
                            <div class={'notice-header-left'}>
                                <div class={'notice-logo'}></div>
                            </div>
                            <div class={'notice-header-right'}>
                                <div class={'notice-header-right-top'}>
                                    <div class={'notice-title'}>{item.title}</div>
                                    <div class={'notice-due'}>{item.due}</div>
                                </div>
                                <div class={'notice-header-right-bot'}>
                                    <div class={'notice-time'}>{item.time}</div>
                                    <div class={'notice-detail'}>查看详情</div>
                                </div>
                            </div>
                        </div>
                        <div class={'notice-text'}>{item.text}</div>
                    </div>
                ))}
            </div>
        );
    }
    
    get_courses(){
        let courses = this.state.courses
        return (
            <div class={"courses-list"}>
                {courses.map(item=>(
                    <div class={'course-item'} key={item} onClick={()=>{window.location.href = '/user/course?course='+item['课程标识符']}}>
                        <div class='course-title'>
                            <div class='course-title-text'>{item['课程名称']}</div>
                        </div>
                    </div>
                ))}
            </div>
        );
    }
    
    show_center_title(){
        if(this.state.chosen_item == "notes")
            return <div class={'center-title-bar'}>工作笔记 Notes</div>
        else
            return <div class={'center-title-bar'}>公告通知 Notices</div>
    }
    
    show_center_content(){
        if(this.state.chosen_item == "notes")
            return <Notes></Notes>
        else
            return this.get_notices()
    }
    
    check_item(item){
        return this.state.chosen_item == item? "item": "otherItem"
    }
    
    render(){
        return (
            <div class="uhp">
                <div class="uhp-left">
                    <img class="avatar" src={this.get_avatar()}/>
                    <div class="name">
                        <div>{this.get_name()}</div>
                    </div>
                    <div class={"menu"}>
                        <div className={this.check_item("notes")} onClick={()=>{this.setState({chosen_item: "notes", })}}>学习笔记</div>
                            <div className={this.check_item("notice")} onClick={()=>{this.setState({chosen_item: "notice", })}}>公告</div>
                            <div className={this.check_item("setting")} onClick={()=>{this.setState({chosen_item: "setting", });window.location.href = '/user/setting'}}>设置</div>
                        </div>
                </div>

                <div class="uhp-center">
                    {this.show_center_title()}
                    {this.show_center_content()}
                </div>

                <div class="uhp-right">
                    <div class={"courses-title-bar"}>所管课程 COURSES</div>
                    {this.get_courses()}
                </div>
            </div>
        )
    }
}


export default TchHome;
