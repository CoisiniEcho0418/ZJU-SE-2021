import React from 'react';
import StuHome from "./stu-home";
import TchHome from "./tch-home";

class UserHomePage extends React.Component{
    constructor(props) {
        super(props);
        this.state = {
            utype: localStorage.getItem("type") || "stu",
            uid: localStorage.getItem("userName") || "u123",
        };
    }
    render(){
        return (
            <div>
                {this.state.utype == 'stu' && <StuHome />}
                {this.state.utype == 'tch' && <TchHome />}
                {this.state.utype == 'ta'  && <TchHome />}
            </div>
        )
    }
}


export default UserHomePage
