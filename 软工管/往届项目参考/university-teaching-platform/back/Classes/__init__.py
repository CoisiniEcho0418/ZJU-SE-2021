from datetime import datetime
from datetime import timedelta
from datetime import date
from sqlalchemy.dialects.mysql import INTEGER, VARCHAR,  DATETIME, TIME, DATE, CHAR, NUMERIC, BIT
from sqlalchemy import Column, ForeignKey
from sqlalchemy import create_engine, select
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.declarative import declarative_base
from json import JSONEncoder
import copy

Base = declarative_base()


class PUser(Base):
    __tablename__ = 'puser'
    userName = Column(VARCHAR(100), primary_key=True)
    nickName = Column(VARCHAR(100), nullable=False)
    passWD = Column(VARCHAR(256), nullable=False)
    portrait = Column(VARCHAR(256), nullable=False)

    def __init__(self, username, nickname, passwd, portrait):
        self.userName = username
        self.nickName = nickname
        self.passWD = passwd
        self.portrait = portrait


class Teacher(Base):
    __tablename__ = 'teacher'
    id = Column(CHAR(10), primary_key=True)
    userName = Column(VARCHAR(100), ForeignKey("puser.userName"), nullable=False)
    firstName = Column(VARCHAR(50), nullable=False)
    lastName = Column(VARCHAR(50), nullable=False)
    department = Column(VARCHAR(100), nullable=False)
    email = Column(VARCHAR(100), nullable=False)

    def __init__(self, id, username, firstname, lastname, department, em):
        self.id = id
        self.userName = username
        self.firstName = firstname
        self.lastName = lastname
        self.department = department
        self.email = em


class Student(Base):
    __tablename__ = "student"
    id = Column(CHAR(10), primary_key=True)
    userName = Column(VARCHAR(100), ForeignKey('puser.userName'), nullable=False)
    major = Column(VARCHAR(100), nullable=False)
    email = Column(VARCHAR(100), nullable=False)

    def __init__(self, id, username, major, email):
        self.id = str(id).encode()
        self.userName = username
        self.major = major
        self.email = email


class TA(Base):
    __tablename__ = 'ta'
    userName = Column(VARCHAR(100), ForeignKey('puser.userName'), primary_key=True, nullable=False)
    teacherId = Column(CHAR(10), ForeignKey('teacher.id'))
    courseDescriptor = Column(VARCHAR(256), ForeignKey('course.courseDescriptor'),
                              primary_key=True, nullable=False)

    def __init__(self, uname, i, ins, cdes):
        self.userName = uname
        self.id = i
        self.teacherId = ins
        self.courseDescriptor = cdes


class Course(Base):
    __tablename__ = "course"
    courseDescriptor = Column(VARCHAR(256), primary_key=True)
    courseName = Column(VARCHAR(200), nullable=False)
    courseId = Column(CHAR(20), nullable=False)
    credit = Column(NUMERIC(3, 1), nullable=False)
    semester = Column(CHAR(10), nullable=False)
    startTime = Column(DATE, nullable=False)
    endTime = Column(DATE, nullable=False)
    courseStart = Column(TIME)
    courseEnd = Column(TIME)
    hotIndex = Column(INTEGER, nullable=False)
    Image = Column(VARCHAR(256), nullable=False)
    description = Column(VARCHAR(1000), nullable=False)

    def __init__(self, course_descriptor, course_id, credit, semester, start_time, end_time, course_start, course_end,
                 hot_index, image, description, cname):
        self.courseDescriptor = course_descriptor
        self.courseId = course_id
        self.credit = credit
        self.semester = semester
        self.startTime = start_time
        self.endTime = end_time
        self.courseStart = course_start
        self.courseEnd = course_end
        self.hotIndex = hot_index
        self.Image = image
        self.description = description
        self.courseName = cname


class Manage(Base):
    __tablename__ = "manage"
    userName = Column(VARCHAR(100), ForeignKey('puser.userName'), primary_key=True, nullable=False)
    courseDescriptor = Column(VARCHAR(256), ForeignKey('course.courseDescriptor'), primary_key=True, nullable=False)
    type = Column(BIT(1), nullable=False)
    newNotice = Column(BIT(1), nullable=False)
    editNotice = Column(BIT(1), nullable=False)
    deleteNotice = Column(BIT(1), nullable=False)
    newHomework = Column(BIT(1), nullable=False)
    editHomework = Column(BIT(1), nullable=False)
    deleteHomework = Column(BIT(1), nullable=False)
    gradeHomework = Column(BIT(1), nullable=False)

    def __init__(self, username, descriptor, type, newnotice, editnotice, deletenotice, newhw, edithw, delhw, grahw):
        self.userName = username
        self.courseDescriptor = descriptor
        self.type = type
        self.newNotice = newnotice
        self.editNotice = editnotice
        self.deleteNotice = deletenotice
        self.newHomework = newhw
        self.editHomework = edithw
        self.deleteHomework = delhw
        self.gradeHomework = grahw


class Homework(Base):
    __tablename__ = "homework"
    courseDescriptor = Column(VARCHAR(256), ForeignKey('course.courseDescriptor'), index=True)
    homeworkTitle = Column(VARCHAR(100), primary_key=True)
    homeworkContent = Column(VARCHAR(5000), nullable=False)
    startTime = Column(DATETIME, primary_key=True)
    creatorUsername = Column(VARCHAR(100), ForeignKey('puser.userName'), primary_key=True, nullable=False)
    endTime = Column(DATETIME)

    def __init__(self, descriptor, hktitle, stime, etime, cusername, hwkcontent):
        self.courseDescriptor = descriptor
        self.homeworkTitle = hktitle
        self.startTime = stime
        self.endTime = etime
        self.creatorUsername = cusername
        self.homeworkContent = hwkcontent


class Participation(Base):
    __tablename__ = 'participation'
    studentUsername = Column(VARCHAR(100), ForeignKey('puser.userName'), primary_key=True)
    courseDescriptor = Column(VARCHAR(256), ForeignKey('course.courseDescriptor'), primary_key=True)
    finalGrade = Column(NUMERIC(5, 2))
    signInTime = Column(DATETIME)

    def __init__(self, sname, cd, fg, sit):
        self.studentUsername = sname
        self.courseDescriptor = cd
        self.finalGrade = fg
        self.signInTime = sit


class HandInHomework(Base):
    __tablename__ = "handInHomework"
    submitUserName = Column(VARCHAR(100), ForeignKey('puser.userName'), primary_key=True, nullable=False)
    gradeUserName = Column(VARCHAR(100), ForeignKey('puser.userName'), nullable=True)
    grades = Column(NUMERIC(5, 2))
    handInTime = Column(DATETIME, primary_key=True)
    fileName = Column(VARCHAR(256), nullable=False)
    file = Column(VARCHAR(256), nullable=False)
    courseDescriptor = Column(VARCHAR(256), ForeignKey('course.courseDescriptor'), nullable=False)
    homeworkTitle = Column(VARCHAR(100), ForeignKey('homework.homeworkTitle'), nullable=False)

    def __init__(self, susername, gusername, grade, hdintime, fil, descriptor, hwtitle, filen):
        self.submitUserName = susername
        self.gradeUserName = gusername
        self.grades = grade
        self.handInTime = hdintime
        self.file = fil
        self.courseDescriptor = descriptor
        self.homeworkTitle = hwtitle
        self.fileName = filen


class Reference(Base):
    __tablename__ = "reference"
    referenceName = Column(VARCHAR(100), nullable=False)
    file = Column(VARCHAR(256), nullable=False)
    upLoadTime = Column(DATETIME, primary_key=True)
    downloadable = Column(BIT(1), nullable=False)
    courseDescriptor = Column(VARCHAR(256), ForeignKey('course.courseDescriptor'), primary_key=True, nullable=False)

    def __init__(self, rename, uptime, candownload, descritpor):
        self.referenceName = rename
        self.upLoadTime = uptime
        self.downloadable = candownload
        self.courseDescriptor = descritpor


class Notification(Base):
    __tablename__ = 'notification'
    content = Column(VARCHAR(1000))
    createTime = Column(DATETIME, primary_key=True)
    creatorUsername = Column(VARCHAR(100), ForeignKey('manage.userName'), primary_key=True)
    courseDescriptor = Column(VARCHAR(256), ForeignKey('course.courseDescriptor'), primary_key=True)

    def __init__(self, ctnt, ctime, ctor, cdes):
        self.content = ctnt
        self.createTime = ctime
        self.creatorUsername = ctor
        self.courseDescriptor = cdes


class Complain(Base):
    __tablename__ = 'complain'
    studentUsername = Column(VARCHAR(100), ForeignKey('puser.userName'), primary_key=True, nullable=False)
    courseDescriptor = Column(VARCHAR(256), ForeignKey('course.courseDescriptor'))
    handInTime = Column(DATETIME, primary_key=True)
    reason = Column(VARCHAR(1000))

    def __init__(self, stu, cour, hdint, reasn):
        self.studentUsername = stu
        self.courseDescripton = cour
        self.handInTime = hdint
        self.reason = reasn


class MyJSONEncoder(JSONEncoder):
    def default(self, obj):
        if isinstance(obj, PUser):
            return {'userName': obj.userName, 'nickName': obj.nickName}
        elif isinstance(obj, Teacher):
            # return {obj.id,obj.userName,obj.firstName,obj.lastName,obj.department}
            temp = copy.deepcopy(obj.__dict__)
            temp.pop('_sa_instance_state')
            return temp
        elif isinstance(obj, Student):
            temp = copy.deepcopy(obj.__dict__)
            temp.pop('_sa_instance_state')
            return temp
        elif isinstance(obj, TA):
            temp = copy.deepcopy(obj.__dict__)
            temp['courseName'] = courseDescriptor2Name(temp['courseDescriptor'])
            temp.pop('_sa_instance_state')
            return temp
        elif isinstance(obj, Course):
            temp = copy.deepcopy(obj.__dict__)
            temp.pop('_sa_instance_state')
            return temp
        elif isinstance(obj, Manage):
            temp = copy.deepcopy(obj.__dict__)
            temp['courseName'] = courseDescriptor2Name(temp['courseDescriptor'])
            temp.pop('_sa_instance_state')
            return temp
        elif isinstance(obj, Homework):
            temp = copy.deepcopy(obj.__dict__)
            temp['courseName'] = courseDescriptor2Name(temp['courseDescriptor'])
            temp.pop('_sa_instance_state')
            return temp
        elif isinstance(obj, HandInHomework):
            temp = copy.deepcopy(obj.__dict__)
            temp['courseName'] = courseDescriptor2Name(temp['courseDescriptor'])
            temp.pop('_sa_instance_state')
            return temp
        elif isinstance(obj, Reference):
            temp = copy.deepcopy(obj.__dict__)
            temp['courseName'] = courseDescriptor2Name(temp['courseDescriptor'])
            temp.pop('_sa_instance_state')
            return temp
        elif isinstance(obj, Participation):
            temp = copy.deepcopy(obj.__dict__)
            temp['courseName'] = courseDescriptor2Name(temp['courseDescriptor'])
            temp.pop('_sa_instance_state')
            return temp
        elif isinstance(obj, Notification):
            temp = copy.deepcopy(obj.__dict__)
            temp['courseName'] = courseDescriptor2Name(temp['courseDescriptor'])
            temp.pop('_sa_instance_state')
            return temp
        elif isinstance(obj, Complain):
            temp = copy.deepcopy(obj.__dict__)
            temp['courseName'] = courseDescriptor2Name(temp['courseDescriptor'])
            temp.pop('_sa_instance_state')
            return temp
        elif isinstance(obj, date):
            return str(obj)
        elif isinstance(obj, datetime):
            return str(obj)
        elif isinstance(obj, timedelta):
            return str(obj)
        else:
            pass


def courseDescriptor2Name(sha):
    return session.query(Course.courseName).filter(Course.courseDescriptor == sha).all()[0][0]


Engine = create_engine("mysql+pymysql://tp:teaching@www.neohugh.art:3306/tp", encoding="utf-8")
Session = sessionmaker(bind=Engine)
session = Session()
# Base.metadata.drop_all(Engine)
# Base.metadata.create_all(Engine)
