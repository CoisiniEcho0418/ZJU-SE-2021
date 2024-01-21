import React, {Component} from 'react';
import SliderItem from './slideritem'
import SliderArrows from './sliderArrows'
import SliderDots from './sliderDots'

class Slider extends Component {
    constructor(props) {
        super(props);
        this.state = {
            nowLocal: 0,
            index:0
        };
    }

    componentDidMount() {
        this.goPlay();
    }

    goPlay=()=> {
        if(this.props.autoplay) {
            this.autoPlayFlag = setInterval(() => {
                this.turn(1);
            }, this.props.delay * 1000);
        }
    }


    // 暂停自动轮播
    pausePlay=()=> {
        clearInterval(this.autoPlayFlag);
    }

    turn=(n)=> {
        let _n = this.state.nowLocal + n;
        if(_n < 0) {
            _n = _n + this.props.items.length;
        }

        if(_n >= this.props.items.length) {
            _n = _n - this.props.items.length;
        }
        this.setState({nowLocal: _n});
    }

    render() {
        let count = this.props.items.length;
        let itemNodes = this.props.items.map((item, idx) => {
            return <SliderItem item={item} count={count} key={'item' + idx} />;
        });


        let dotsNode = <SliderDots turn={this.turn} count={count} nowLocal={this.state.nowLocal} />;
        return (
            <div
                className="slider-container"
                onMouseOver={this.props.pause?this.pausePlay:null}
                onMouseOut={this.props.pause?this.goPlay:null}>
                <ul style={{
                    left: -100 * this.state.nowLocal + "%",
                    transitionDuration: this.props.speed + "s",
                    width: this.props.items.length * 100 + "%"
                }}>
                    {itemNodes}
                </ul>
                {this.props.arrows?<SliderArrows turn={this.turn} items={this.props.items} nowLocal={this.state.nowLocal}/>:null}
                {this.props.dots?dotsNode:null}
            </div>
        );
    }
}
Slider.defaultProps = {
    speed: 1,
    delay: 2,
    pause: true,
    autoplay: true,
    dots: true,
    arrows: true,
    items: [],
};
Slider.autoPlayFlag = null;
export default Slider;