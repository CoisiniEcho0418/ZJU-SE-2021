import React, {Component} from 'react';

class SliderDots extends Component {
    handleDotClick=(i) =>{
        let option = i - this.props.nowLocal;
        this.props.turn(option);
    }
    render() {
        let dotNodes = [];
        let { count, nowLocal } = this.props;
        for(let i = 0; i < count; i++) {
            dotNodes[i] = (
                <span
                    key={'dot' + i}
                    className={"slider-dot" + (i === this.props.nowLocal?" slider-dot-selected":"")}
                    onClick={()=>this.handleDotClick(i)}>
                </span>
            );
        }
        return (
            <div className="slider-dots-wrap">
                {dotNodes}
            </div>
        );
    }
}

export default SliderDots;