import React from 'react';
import download_icon from '../../assets/images/CoursePage/download.png';

class StuCourse extends React.Component{
    constructor(props) {
        super(props);

        this.INFO = 0;
        this.MATERIAL = 1;
        this.NOTICE = 2;
        this.ASSIGNMENT = 3;

        this.state = {
            header: "http://localhost:5000",
            contentFlag: this.INFO,
            name: "",
            time: "",
            credit: "",
            info: "暂无",
            mtrl: [],
            ntic: ["暂无公告"],
            asgn: [],
            courses: [],
            use_default_courses: true,
            user_id: localStorage.getItem("username")
        }
    }
    
    async componentWillMount(){
        let flag = true
        fetch(this.state.header+'/studyCourse?userName=' + this.state.user_id, {
                method: "GET",
                mode: "cors",
            }
        )
        .then(response => response.json())
        .then(data => {
            //console.log(data)
            flag = data.length === 0
            this.setState({
                use_default_courses: flag,
                courses: !flag? data: [
                    {'课程标识符': 1, '课程名称': '软件需求工程'}, 
                    {'课程标识符': 2, '课程名称': '软件工程管理'}, 
                    {'课程标识符': 3, '课程名称': '软件质量保证与测试'}, 
                    {'课程标识符': 4, '课程名称': '服务科学导论'}, 
                    {'课程标识符': 5, '课程名称': '软件工程基础'}]})
            if(!flag){
                //console.log('here!')
                fetch(this.state.header+'/courseInfo', {
                        method: 'POST',
                        mode: 'cors',
                        headers: new Headers({
                            'Content-Type': 'application/x-www-form-urlencoded'
                        }),
                        body: 'courseDes='+this.get_course_id()
                    }
                )
                .then(response => response.json())
                .then(data => {
                    //console.log(data)
                    this.setState({
                        name: data[0]['课程名称'],
                        time: data[0]['课程学期'] + ' ' + data[0]['课程开始时间'] + ' ~ ' + data[0]['课程结束时间'],
                        credit: data[0]['课程学分']
                    })
                    fetch(this.state.header+'/courseReference' + '?courseDescriptor=' + this.get_course_id(), {
                            method: "GET",
                            mode: "cors",
                        }
                    )
                    .then(response => response.json())
                    .then(data => {
                        console.log(data)
                        this.setState({
                            mtrl: JSON.parse(JSON.stringify(data))
                        })
                        fetch(this.state.header+'/homeworkList' + '?courseDescriptor=' + this.get_course_id(), {
                                method: "GET",
                                mode: "cors",
                            }
                        )
                        .then(response => response.json())
                        .then(data => {
                            console.log(data)
                            this.setState({
                                asgn: JSON.parse(JSON.stringify(data))
                            })
                        }).catch(function (e) {
                            console.log(e);
                        });
                    }).catch(function (e) {
                        console.log(e);
                    });
                }).catch(function (e) {
                    console.log(e);
                });
               
            }
        }).catch(function (e) {
            console.log(e);
        });
    }
    
    
    set_flag(flag){
        this.setState({
            contentFlag: flag
        })
    }
    
    get_url_param(p){
        let url = window.location.href;
        if(url.split('?').length < 1)
            return '';
        let params = url.split('?')[1].split('&');
        for(let i=0; i<params.length; i++){
            let param = params[i].split('=');
            if(param != null && param[0] === p){
                return param[1];
            }
        }
        return '';
    }
    
    get_course_id(){
        let c_id = this.get_url_param('course');
        console.log(c_id);
        return c_id;
    }
    
    get_course(){
        let courses = {
            1: {
                name: "软件需求工程",
                time: "2020-2021",
                credit:"3.5",
                // eslint-disable-next-line no-multi-str
                info: "本课程的主要任务是在软件工程整体知识的基础上，深入学习并实践软件需求获取与管理的原理、方法和过程，\
        学习并掌握使用UML工具对软件需求进行分析、表达与系统设计。课程内容包括两部分：一是需求获取和维护的过程和方法，\
        包括需求提取、需求分析和建模、需求表达、需求确认、需求变更控制，以及相应的工具；二是UML概念、方法和工具。\
        课程配合案例性实践环节进行教学。通过本课程的学习，应使学生掌握如何在软件工程的实践中完成复杂软件需求的获取、\
        表达和维护能力，学会应用UML进行软件需求分析与设计的技术和方法，为掌握软件工程的系统全面的知识和技能打下坚实基础。",
                mtrl: [{name: "课件1", isdownable: true, uploadTime: "2020-12-09"}],
                ntic: [
                    "暂无通知"
                ],
                asgn: [
                    {'homeworkTitle': '作业1', 'homeworkContent': '报告1', 'startTime': '2020-12-10', 'endTime': '2020-12-12'}
                ]
            },
            2: {
                name: "软件工程管理",
                time: "2020-2021",
                credit:"3.5",
                // eslint-disable-next-line no-multi-str
                info: "暂无简介",
                mtrl: [{name: "课件1", isdownable: true, uploadTime: "2020-12-09"}],
                ntic: [
                    "暂无通知"
                ],
                asgn: [
                    {'homeworkTitle': '作业1', 'homeworkContent': '报告1', 'startTime': '2020-12-10', 'endTime': '2020-12-12'}
                ]
            },
            3: {
                name: "软件质量测试与保证",
                time: "2020-2021",
                count: "2.5",
                // eslint-disable-next-line no-multi-str
                info: "暂无简介",
                mtrl: [{name: "课件1", isdownable: true, uploadTime: "2020-12-09"}],
                ntic: [
                    "暂无通知"
                ],
                asgn: [
                    {'homeworkTitle': '作业1', 'homeworkContent': '报告1', 'startTime': '2020-12-10', 'endTime': '2020-12-12'}
                ]
            },
            4: {
                name: "服务科学导论",
                time: "2020-2021",
                count: "2.0",
                // eslint-disable-next-line no-multi-str
                info: "暂无简介",
                mtrl: [{name: "课件1", isdownable: true, uploadTime: "2020-12-09"}],
                ntic: [
                    "暂无通知"
                ],
                asgn: [
                    {'homeworkTitle': '作业1', 'homeworkContent': '报告1', 'startTime': '2020-12-10', 'endTime': '2020-12-12'}
                ]
            },
            5: {
                    name: "软件工程基础",
                    time: "2020-2021",
                    credit:"2.5",
                    // eslint-disable-next-line no-multi-str
                    info: "暂无简介",
                    mtrl: [{name: "课件1", isdownable: true, uploadTime: "2020-12-09"}],
                    ntic: [
                        "暂无通知"
                    ],
                    asgn: [
                    {'homeworkTitle': '作业1', 'homeworkContent': '报告1', 'startTime': '2020-12-10', 'endTime': '2020-12-12'}
                ]
                },
        }
        
        let course = this.state.use_default_courses? courses[1]: {
            name: this.state.name,
            time: this.state.time,
            credit: this.state.credit,
            info: this.state.info,
            mtrl: this.state.mtrl,
            ntic: this.state.ntic,
            asgn: this.state.asgn,
        }
        console.log(course)
        return course
    }
    
    render(){
        const style = {
            textAlign: "center",
            align: "center"
        }
        let course = this.get_course();

        // let contentFlag = 0;

        let info = () => {
            return (
                <div>
                    <div className="cp-content-title">课程简介</div>
                    <div className="cp-content-text">{course.info}</div>
                </div>
            )
        }

        let material = () => {
            let elems = course.mtrl.map(
                (e) =>
                    <div class="cp-content-material">
                        <div class="material-title">{e['referenceName']}</div>
                        <div class="btn-download"
                             onClick={
                                 () => {
                                     alert("downloading...");
                                 }
                             }>
                            <img class="download-icon" src={download_icon}/>
                        </div>
                    </div>
            )
            return (
                <div>
                    <div className="cp-content-title">Material</div>
                    <div>{elems}</div>
                </div>
            )
        }

        let notice = () => {
            let elems = course.ntic.map(
                (e) => <div className="cp-content-text">{e}</div>
            )
            return (
                <div>
                    <div className="cp-content-title">Notice</div>
                    <div>{elems}</div>
                </div>
            )
        }

        let assignment = () => {
            let elems = course.asgn.map(
                (e) => <div
                    key={e}
                    className="cp-content-text"
                >
                    {e['homeworkTitle']}
                    <button onClick='alert("downloading")'>download</button>
                    <button onClick='alert("Submission success")'>submit</button>
                    <button onClick='alert("uploading")'>upload</button>
                </div>
            )
            return (
                <div>
                    <div className="cp-content-title">Assignment</div>
                    <div>{elems}</div>
                </div>
            )
        }
        
        let checkFlag = (flag) => {
            if(flag === this.INFO)
                return info()
            else if(flag === this.MATERIAL)
                return material()
            else if(flag === this.NOTICE)
                return notice()
            else if(flag === this.ASSIGNMENT)
                return assignment()
        }
        let getStyleByFlag = (flag) => {
            if(flag === this.state.contentFlag)
                return {
                    color: "#000000"
                }
            else
                return {}
        }
        return (
            <div class="coursePage" style={style}>
                <div class="cp-header">
                    <div class="cp-header-info">
                        <div class="cp-header-title">
                            {course['name']}
                        </div>
                        <div class="cp-header-time">
                            {course['time']}
                        </div>
                        <div class="cp-header-instructor">
                            {course.instructor}
                        </div>
                    </div>
                </div>
                <div class="cp-navigation">
                    <div class="cp-navigation-list">
                        <li class="cp-navigation-information"
                            style={getStyleByFlag(this.INFO)}
                            onClick={()=>{
                                this.setState({
                                    contentFlag: this.INFO,
                                })
                            }}>
                            课程信息
                        </li>
                        <li class="cp-navigation-material"
                            style={getStyleByFlag(this.MATERIAL)}
                            onClick={()=>{
                                // alert("hello");
                                this.setState({
                                    contentFlag: this.MATERIAL,
                                })
                            }}>
                            课件
                        </li>
                        <li class="cp-navigation-notice"
                            style={getStyleByFlag(this.NOTICE)}
                            onClick={()=>{
                                this.setState({
                                    contentFlag: this.NOTICE,
                                })
                            }}>
                            公告
                        </li>
                        <li class="cp-navigation-assignment"
                            style={getStyleByFlag(this.ASSIGNMENT)}
                            onClick={()=>{
                                this.setState({
                                    contentFlag: this.ASSIGNMENT,
                                })
                            }}>
                            作业
                        </li>
                    </div>
                </div>
                <div className="cp-content">
                    <div className="cp-content-info">
                        {this.state.contentFlag==this.INFO && info()}
                        {this.state.contentFlag==this.MATERIAL && material()}
                        {this.state.contentFlag==this.ASSIGNMENT && assignment()}
                        {this.state.contentFlag==this.NOTICE && notice()}
                    </div>
                </div>
            </div>
        )
    }
}
export default StuCourse;
