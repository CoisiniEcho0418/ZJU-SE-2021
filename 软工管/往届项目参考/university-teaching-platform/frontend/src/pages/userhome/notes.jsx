import React from 'react';

class Notes extends React.Component{
    constructor(props){
        super(props);
        this.state = {
            notes:[
                '今天去comfinement room研习化学吧',
                '明天再去Ciker Lake实地考察生态学'
            ]
        }
    }

    render() {
        return (
            <div class={'notes-page'}>
                <textarea id={'editor'} class={'editor'} />
                <button class={'btn-add'}
                    onClick={()=>{
                        let new_note = document.getElementById('editor').value;
                        console.log(new_note);
                        let old = this.state.notes;
                        if(new_note != ''){
                            old.push(new_note);
                        }
                        this.setState({
                            notes: old,
                        });
                    }}>添加笔记</button>
                <div class={'note-title'}> 已往笔记 Former Notes </div>
                {this.state.notes.map(
                    item => <li class={'note'} key={item}>
                        <div class={'text'}>{item}</div>
                        <button class={'btn-delete'} onClick={
                            ()=>{
                                let old = this.state.notes;
                                old.splice(old.indexOf(item), 1);
                                this.setState({
                                    notes: old,
                                })
                            }
                        }>删除笔记</button>
                    </li>
                )}
            </div>
        )
    }
}

export default Notes;
