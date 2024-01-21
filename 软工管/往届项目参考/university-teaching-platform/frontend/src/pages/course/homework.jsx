import React from 'react';

class Homework extends React.Component{
    constructor(props) {
        super(props);
        this.state = {

        }
    }
    get_submits(){
        let submits = [
            {
                'stu': 'zhang san',
                'stu_id': 3180100001,
            },
            {
                'stu': 'li si',
                'stu_id': 3180100001,
            },
            {
                'stu': 'wang wu',
                'stu_id': 3180100001,
            },
            {
                'stu': 'zhao liu',
                'stu_id': 3180100001,
            }
        ];
        return(
            <div>
                {submits.map(
                    item => <li class={'submitation'} key={item}>
                        <div class={'submitter'}>{item['stu']}</div>
                        <button class={'btn-download'}>download</button>
                        <button className={'btn-download'}>grade</button>
                    </li>
                )}
            </div>
        )
    }

    render(){
        return(
            <div class={'hw-submits'}>
                {this.get_submits()}
            </div>
        )
    }
}

export default Homework;