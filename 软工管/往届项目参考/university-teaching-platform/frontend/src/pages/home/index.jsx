import React, { Component } from 'react';

import Item1 from "./item1"
import Item2 from "./item2";

class HomePage extends Component {
    constructor(props){
        super(props)
    }

    render() {
        return (
            <div div className='home-container'>
                <Item1 />
                <Item2 />
            </div>
        )

    }
}

export default HomePage