import React from 'react';
import StuCourse from "./stu-course";
import TchCourse from "./tch-course";

class CoursePage extends React.Component{
    constructor(props) {
        super(props);

        this.state = {
            utype: localStorage.getItem("type"),
        }
    }

    render(){
        return (
            <div>
                {this.state.utype == 'stu' && <StuCourse />}
                {this.state.utype == 'tch' && <TchCourse />}
                {this.state.utype == 'ta'  && <TchCourse />}
            </div>
        )
    }
}

export default CoursePage;
