import React from 'react';
import ReactDOM from 'react-dom';
import App from "./App";
import reportWebVitals from './utils/reportWebVitals';

import './styles/entry.less'
import './utils/icons/iconfont'
import './styles/swiper.css';
import 'antd/dist/antd.css'

ReactDOM.render(
    <App />,
    document.getElementById('root')
);

// If you want to start measuring performance in your app, pass a function
// to log results (for example: reportWebVitals(console.log))
// or send to an analytics endpoint. Learn more: https://bit.ly/CRA-vitals
reportWebVitals();