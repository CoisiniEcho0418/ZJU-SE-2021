import React from 'react';
import TA from '../../assets/images/user/TA.jpg';

class TaHome extends React.Component{
    constructor(props) {
        super(props);
        this.state = {
            user_type: "student",
            user_id: "u123",
        };
    }
    get_avatar(){
        return TA;
    }
    get_name(){
        //@TODO
        let name = localStorage.getItem('username');
        return "TA";
    }
    get_notices(){
        return (
            <div class={"notices"}>
                <div class={"notice-item"}>notice</div>
                <div class={"notice-item"}>notice</div>
                <div class={"notice-item"}>notice</div>
                <div class={"notice-item"}>notice</div>
            </div>
        );
    }
    get_courses(){
        return (
            <div class={"courses-list"}>
                <div class={"course-item"}>courses</div>
                <div class={"course-item"}>courses</div>
                <div class={"course-item"}>courses</div>
                <div class={"course-item"}>courses</div>
            </div>
        );
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
                        <div class={"item"}>学习笔记</div>
                        <div class={"item"}>公告</div>
                    </div>
                </div>

                <div class="uhp-center">
                    <div class={"notices-title-bar"}>notice</div>
                    {this.get_notices()}
                </div>

                <div class="uhp-right">
                    <div class={"courses-title-bar"}>courses</div>
                    {this.get_courses()}
                </div>
            </div>
        )
    }
}


export default TaHome;