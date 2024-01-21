import hashlib
from flask import Flask, request, make_response, send_from_directory, url_for, flash, redirect
from flask_cors import CORS
from werkzeug.utils import secure_filename

from Classes import Base, Engine, select, PUser, Teacher, Student, Course, Manage, Homework, HandInHomework, Reference, \
    HandInHomework, session, TA, MyJSONEncoder, courseDescriptor2Name
import json
import os
from flask import render_template

app = Flask(__name__)
CORS(app)
filePath = './static'


# app.debug = True


@app.route('/', methods=['GET'])
def welcome():
    return render_template('hehe.html')


# 登陆验证
@app.route('/loginValidness', methods=['GET'])
def loginValidness():
    userName = request.args.get('userName')
    passWD = request.args.get('passWD')
    type = request.args.get('type')
    stmt = f'select * from puser where userName = "{userName}" and passWD = "{passWD}"'
    resultSet = session.execute(stmt)
    match = 1 if resultSet.rowcount else 0
    identity = 0
    if (match == 1):
        if type == 'stu':
            stmt = f'select * from student where userName = "{userName}"'
            resultSet = session.execute(stmt)
            identity = 1 if resultSet.rowcount else 0
        elif type == 'ins':
            stmt = f'select * from teacher where userName = "{userName}"'
            resultSet = session.execute(stmt)
            identity = 1 if resultSet.rowcount else 0
        elif type == 'ta':
            stmt = f'select * from ta where userName = "{userName}"'
            resultSet = session.execute(stmt)
            identity = 1 if resultSet.rowcount else 0
        else:
            pass
    return json.dumps({'match': match, 'identity': identity}, indent=2, ensure_ascii=False)


'''
after login :
'''


# 获取某个用户信息
@app.route('/userInfo', methods=['GET'])
def userInfo():
    userName = request.args.get('userName')
    type = request.args.get('type')
    if type == 'stu':
        res = session.query(Student).filter(Student.userName == userName).all()
        stu = res[0]
        return json.dumps(stu, cls=MyJSONEncoder, indent=2, ensure_ascii=False)
    elif type == 'ins':
        res = session.query(Teacher).filter(Teacher.userName == userName).all()
        ins = res[0]
        return json.dumps(ins, cls=MyJSONEncoder, indent=2, ensure_ascii=False)
    elif type == 'ta':
        res = session.query(TA).filter(TA.userName == userName).all()
        ta = res[0]
        return json.dumps(ta, cls=MyJSONEncoder, indent=2, ensure_ascii=False)
    else:
        return json.dumps({'state': 404}, indent=2, ensure_ascii=False)


@app.route('userPortrait', methods=['GET'])
def userPortrait():
    userName = request.args.get('userName')
    url = userName + '.' + session.query(PUser.portrait).filter(PUser.userName == userName).all()[0][0]
    return json.dumps({'url': url})


# 修改某个用户个人信息
@app.route('/modifyInfo', methods=['POST'])
def modifyInfo():
    userName = request.form['userName']
    nickName = request.form['nickName']
    passWD = request.form['passWD']
    try:
        stmt = f'update puser set puser.nickName = "{nickName}" where puser.userName = "{userName}"'
        # session.query(PUser).filter(PUser.userName == userName).update({'nickName':nickName})
        session.execute(stmt)
        session.commit()
        if passWD != '':
            stmt = f'update puser set puser.passWD = "{passWD}" where puser.userName = "{userName}"'
            session.execute(stmt)
            session.commit()
        return json.dumps({'state': 200}, indent=2, ensure_ascii=False)
    except:
        return json.dumps({'state': 404}, indent=2, ensure_ascii=False)


# 获取某人的待办列表
@app.route('/todolist', methods=['GET'])
def todolist():
    userName = request.args.get('userName')
    type = request.args.get('type')
    if type == 'stu':
        # 学生只回传作业列表
        stmt = f'select homeworkTitle,homework.startTime,homework.endTime,courseName from homework,participation,course where participation.studentUsername = "{userName}"'
        res = session.execute(stmt)
        todols = [{'作业名称': list(i)[0], '开始时间': list(i)[1], '结束时间': list(i)[2], '课程名称': list(i)[3]} for i in res]
        return json.dumps(todols, cls=MyJSONEncoder, indent=2, ensure_ascii=False)

    elif type == 'ta':
        stmt = f'SELECT submitUserName, handInTime, homeworkTitle,manage.courseDescriptor FROM handinhomework JOIN manage ON (handinhomework.courseDescriptor = manage.courseDescriptor)  WHERE manage.gradeHomework=1 and manage.userName = "{userName}"  and manage.courseDescriptor = (SELECT manage.courseDescriptor from manage NATURAL JOIN course WHERE manage.userName = "{userName}")'
        # similar to ins but ta requires gradeHomework privilege to be set to 1
        res = session.execute(stmt)
        todols = [{'提交者': list(i)[0], '提交时间': list(i)[1], '作业名称': list(i)[2], '课程名称': courseDescriptor2Name(list(i)[3])}
                  for i in res]
        return json.dumps(todols, cls=MyJSONEncoder, indent=2, ensure_ascii=False)

    elif type == 'ins':
        stmt = f'SELECT submitUserName, handInTime, homeworkTitle,manage.courseDescriptor FROM handinhomework JOIN manage ON (handinhomework.courseDescriptor = manage.courseDescriptor)  WHERE manage.userName = "{userName}"  and manage.courseDescriptor = (SELECT manage.courseDescriptor from manage NATURAL JOIN course WHERE manage.userName = "{userName}")'
        res = session.execute(stmt)
        todols = [{'提交者': list(i)[0], '提交时间': list(i)[1], '作业名称': list(i)[2], '课程名称': courseDescriptor2Name(list(i)[3])}
                  for i in res]
        return json.dumps(todols, cls=MyJSONEncoder, indent=2, ensure_ascii=False)
    else:
        return json.dumps({'state': 404}, indent=2, ensure_ascii=False)


# 老师/助教查看管理的课程
@app.route('/manageCourse', methods=['GET'])
def manageCourse():
    userName = request.args.get('userName')
    stmt = f'SELECT courseDescriptor,courseName FROM course NATURAL JOIN manage WHERE manage.userName = "{userName}"'
    res = session.execute(stmt)
    course_list = [
        {'课程标识符': i[0], '课程名称': i[1]} for i in
        res]
    return json.dumps(course_list, cls=MyJSONEncoder, indent=2, ensure_ascii=False)


# 学生查看学习的课程
@app.route('/studyCourse', methods=['GET'])
def studyCourse():
    userName = request.args.get('userName')
    stmt = f'SELECT courseDescriptor,courseName FROM course NATURAL JOIN participation WHERE participation.studentUserName = "{userName}"'
    res = session.execute(stmt)
    course_list = [
        {'课程标识符': i[0], '课程名称': i[1]} for i in
        res]
    return json.dumps(course_list, cls=MyJSONEncoder, indent=2, ensure_ascii=False)


# 获取文件的url
@app.route('/fetchFile', methods=['GET'])
def fetchFile():
    type = request.args.get('type')
    if type == '1':
        userName = request.args.get('userName')
        append = session.query(PUser.portrait).filter(PUser.userName == userName).all()[0][0]
        return json.dumps({'url': filePath + '/' + userName + '.' + append}, indent=2, ensure_ascii=False)
    elif type == '2':
        courseDescriptor = request.args.get('courseDescriptor')
        append = session.query(Course.Image).filter(Course.courseDescriptor == courseDescriptor).all()[0][0]
        return json.dumps({'url': filePath + '/' + courseDescriptor + '.' + append}, indent=2,
                          ensure_ascii=False)
    elif type == '3':
        file = request.args.get('file')
        append = session.query(HandInHomework.fileName).filter(HandInHomework.file == file).all()[0][0]
        return json.dumps({'url': filePath + r'/' + file + '.' + append.split('.')[1]}, indent=2, ensure_ascii=False)
    elif type == '4':
        file = request.args.get('file')
        append = session.query(Reference.referenceName).filter(Reference.file == file).all()[0][0]
        return json.dumps({'url': filePath + r'/' + file + '.' + append.split('.')[1]}, indent=2, ensure_ascii=False)
    else:
        # unexpected type
        pass
    return json.dumps({'state': 404})


# 获取某门课程的布置过的所有作业列表
@app.route('/homeworkList', methods=['GET'])
def homeworkList():
    courseDescriptor = request.args.get('courseDescriptor')
    res = session.query(Homework.homeworkTitle, Homework.homeworkContent, Homework.startTime, Homework.endTime).filter(
        Homework.courseDescriptor == courseDescriptor).all()
    res_list = [{'homeworkTitle': i[0], 'homeworkContent': i[1], 'startTime': i[2], 'endTime': i[3]} for i in res]
    return json.dumps(res_list, cls=MyJSONEncoder, indent=2, ensure_ascii=False)


# 获取某门课程某个作业的学生提交文件列表
@app.route('/handinList')
def handinList():
    courseDescriptor = request.args.get('courseDescriptor')
    hwName = request.args.get('homeworkName')
    res = session.query(HandInHomework.file, HandInHomework.fileName, HandInHomework.handInTime,
                        HandInHomework.submitUserName).filter(
        HandInHomework.courseDescriptor == courseDescriptor and HandInHomework.homeworkTitle == hwName).all()
    res_list = [{'file': i[0], 'fileName': i[1], 'handInTime': i[2], 'submitUserName': i[3]} for i in res]
    return json.dumps(res_list, cls=MyJSONEncoder, indent=2, ensure_ascii=False)


# 获取某课程课件列表
@app.route('/courseReference', methods=['GET'])
def courseReference():
    courseDescriptor = request.args.get('courseDescriptor')
    res = session.query(Reference.referenceName, Reference.downloadable, Reference.upLoadTime).filter(
        Reference.courseDescriptor == courseDescriptor).all()
    res_list = [{'referenceName': i[0], 'downloadable': i[1], 'upLoadTime': i[2]} for i in res]
    return json.dumps(res_list, cls=MyJSONEncoder, indent=2, ensure_ascii=False)


# 获取热门课程
@app.route('/hotCourse', methods=['GET'])
def hotCourse():
    page = int(request.args.get('page'))
    # 从0开始编号
    num = int(request.args.get('num'))
    stmt = 'SELECT distinct  course.courseDescriptor,course.credit, course.Image,course.courseName,course.semester,course.courseStart,course.courseEnd from course WHERE course.hotIndex > 4'
    res = session.execute(stmt)
    hotCourse = []
    for i, each in enumerate(res):
        if (page + 1) * num > i:
            hotCourse.append(
                {'courseDescriptor': each[0], 'credit': float(each[1]),
                 'Image': filePath + '/' + each[0] + '.' + each[2],
                 'courseName': each[3], 'semester': each[4], 'courseStart': each[5], 'courseEnd': each[6]})
        elif (page + 1) * num == i:
            return json.dumps(hotCourse, cls=MyJSONEncoder, indent=2, ensure_ascii=False)
    return json.dumps(hotCourse, cls=MyJSONEncoder, indent=2, ensure_ascii=False)


# 获取课程详情 tested, pass!
@app.route('/courseInfo', methods=['POST'])
def courseInfo():
    courseDes = request.form['courseDes']
    stmt = f'select courseId, courseName, credit, semester, startTime, endTime, courseStart, courseEnd from course where course.courseDescriptor = "{courseDes}"'
    res = session.execute(stmt)
    courseinfo_list = [
        {'课程号': i[0], '课程名称': i[1], '课程学分': float(i[2]), '课程学期': i[3], '课程开始时间': i[4], '课程结束时间': i[5], '上课时间': i[6],
         '下课时间': i[7]} for i in
        res]
    return json.dumps(courseinfo_list, cls=MyJSONEncoder, indent=2, ensure_ascii=False)


# 上传文件(学生上传作业,老师助教上传资料,上传课程头像,上传用户头像)
@app.route('/uploadfile', methods=['POST'])
def uploadfile():
    type = request.form['type']
    saveFlag = False
    if request.method == 'POST':
        f = request.files['file']

        if f:
            filename = f.filename
            types = ['jpg', 'png', 'pdf', 'doc']
            if filename.split('.')[-1] in types:
                uploadpath = os.path.join(app.root_path, 'static', filename)
                f.save(uploadpath)
                saveFlag = True
            else:
                saveFlag = False
    else:
        saveFlag = False

        # 课件资料 tested, pass!
    if type == 'ins' or type == 'ta':
        refname = request.form['refname']
        userName = request.form['userName']
        courseDescriptor = request.form['courseDescriptor']
        s = hashlib.sha256()
        str = refname + userName + courseDescriptor
        s.update(str.encode("utf8"))
        shafile = s.hexdigest()
        datetime = request.form['datetime']
        downloadable = request.form['downloadable']
        stmt = f'insert into Reference values("{refname}", "{shafile}", "{datetime}", "{downloadable}", "{courseDescriptor}")'
        res = session.execute(stmt)
        session.commit()
        if res and saveFlag:
            return json.dumps({'state': 200}, indent=2, ensure_ascii=False)
        else:
            return json.dumps({'state': 404}, indent=2, ensure_ascii=False)
    # 学生作业 tested, pass!
    elif type == 'stu':
        userName = request.form['userName']
        gradeuname = request.form['gradeuname']
        handintime = request.form['handintime']
        hwname = request.form['hwname']
        title = request.form['title']
        courseDescriptor = request.form['courseDescriptor']
        s = hashlib.sha256()
        str = (hwname + userName + title + courseDescriptor)
        s.update(str.encode("utf8"))
        shafile = s.hexdigest()
        # 作业得分先设为0，批改后直接update上去
        stmt = f'insert into handinhomework values("{userName}", "{gradeuname}", 0, "{handintime}", "{hwname}", "{shafile}", "{courseDescriptor}", "{title}")'
        res = session.execute(stmt)
        session.commit()
        if res and saveFlag:
            return json.dumps({'state': 200}, indent=2, ensure_ascii=False)
        else:
            return json.dumps({'state': 404}, indent=2, ensure_ascii=False)

    # 课程头像 tested, pass!
    elif type == 'course':
        courseDescriptor = request.form['courseDescriptor']
        image = filename.split('.')[-1]
        stmt = f'update course set Image = "{image}" where course.courseDescriptor = "{courseDescriptor}"'
        res = session.execute(stmt)
        session.commit()
        if res and saveFlag:
            return json.dumps({'state': 200}, indent=2, ensure_ascii=False)
        else:
            return json.dumps({'state': 404}, indent=2, ensure_ascii=False)

    # 用户头像 tested, pass!
    elif type == 'user':
        userName = request.form['userName']
        ptrait = filename.split('.')[-1]
        stmt = f'update puser set portrait = "{ptrait}" where userName = "{userName}"'
        res = session.execute(stmt)
        session.commit()
        if res and saveFlag:
            return json.dumps({'state': 200})
        else:
            return json.dumps({'state': 404})
    return json.dumps({'state': 404}, indent=2, ensure_ascii=False)


# 老师布置作业 tested, pass!
@app.route('/assign', methods=['POST'])
def assign():
    courseDes = request.form['courseDes']
    hwtitle = request.form['hwtitle']
    starttime = request.form['starttime']
    endtime = request.form['endtime']
    taskDes = request.form['taskDes']
    creatorUname = request.form['creatorUname']
    stmt = f'insert into Homework values ("{courseDes}", "{hwtitle}", "{taskDes}", "{starttime}", "{creatorUname}", "{endtime}")'
    res = session.execute(stmt)
    session.commit()
    if res:
        return json.dumps({'state': 200})
    else:
        return json.dumps({'state': 404})


# 老师批改作业 tested, pass!
@app.route('/rating', methods=['POST'])
def rating():
    uname = request.form['uname']
    grade = request.form['grade']
    filename = request.form['filename']
    stmt = f'update HandInHomework set gradeUserName = "{uname}", grades = "{grade}" where HandInHomework.fileName = "{filename}"'
    res = session.execute(stmt)
    session.commit()
    if res:
        return json.dumps({'state': 200})
    else:
        return json.dumps({'state': 404})


if __name__ == '__main__':
    app.run(debug=True)
