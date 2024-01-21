import React,{Component} from 'react';
export default class SliderArrows extends Component {
    componentDidMount(){
        // console.log(this.node.offsetLeft)
    }
    render(){

        return (
            <div className='slider-arrow'>
                <span className='arrow-btn arrow-prev' onClick={()=>{}} ref={node=>this.node=node}></span>
                <span className='arrow-btn arrow-next' onClick={()=>{}}></span>
                {/*{this.props.items.map((item,index)=>{
                    return(
                        <span key={index} className={this.props.nowLocal===index?'active':''}
                              onClick={()=>{this.props.go(index-this.props.nowLocal)}}>
                        </span>
                    )
                })}*/}
            </div>
        )
    }
}
