import React from 'react';
import { Route, Switch, Redirect } from 'react-router-dom';

/**
 * 引入各个页面组件
 */
import HomePage from "../pages/home";
import UserInfoPage from "../pages/userinfo";
import CoursePage from "../pages/course";
import UserHomePage from "../pages/userhome";
import Homework from "../pages/course/homework";
import Notes from '../pages/userhome/notes';

/**
 * 网页路由组件
 * 规定全局路由，指定各个路由对应的组件
 *
 * @returns {JSX.Element}
 * @constructor
 *
 * 添加路由：
 * + import PAGE_COMPONENT from "COMPONENT_PATH";
 *
 * + <Route eaxt path="PATH" component={PAGE_COMPONENT}/>
 *
 * TODO：给“找不到此页面”添加一个组件
 */

const AppRouter = () => (
    <div>
        <Switch>
            <Route path="/" exact render={() => <Redirect to="/home" />}/>
            <Route exact path="/home" component={HomePage}/>
            <Route path="/user" exact render={() => <Redirect to="/user/index" />}/>
            <Route exact path="/user/home" component={UserHomePage}/>
            <Route exact path="/user/home/notes" component={Notes}/>
            <Route exact path="/user/setting" component={UserInfoPage}/>
            <Route exact path="/user/course" component={CoursePage}/>
            <Route exact path="/user/course/homework" component={Homework}/>
            <Route render={() => <h1 className={''}>找不到此页面</h1>} />
        </Switch>
    </div>
);

export default AppRouter