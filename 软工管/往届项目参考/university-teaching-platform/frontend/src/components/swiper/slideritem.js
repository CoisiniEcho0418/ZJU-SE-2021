import React, {Component} from 'react';

class SliderItem extends Component {
    render() {
        let { count, item } = this.props;
        let width = 100 / count + '%';
        return (
            <li className="slider-item" style={{width: width}} ref={node=>this.$ul=node}>
                <a href={item.forwardUrl}><img src={item.bannerImage} alt='区块链' /></a>
            </li>
        );
    }
}

export default SliderItem;