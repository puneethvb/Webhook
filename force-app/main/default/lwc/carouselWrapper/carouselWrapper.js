import { LightningElement } from 'lwc';
import CAROUSEL_IMG from '@salesforce/resourceUrl/carousel';
import carouselWrapper from './carouselWrapper.html';
import standardCarousel from './standardCarousel.html';


export default class CarouselWrapper extends LightningElement {

    slides = [
        {
            image : `${CAROUSEL_IMG}/1.jpeg`,
            header : 'Caption 1',
            text : 'Add your Text Here for Image 1'
        },
        {
            image : `${CAROUSEL_IMG}/2.jpg`,
            header : 'Caption 2',
            text : 'Add your Text Here for Image 2'
        },
        {
            image : `${CAROUSEL_IMG}/3.jpg`,
            header : 'Caption 3',
            text : 'Add your Text Here for Image 3'
        }
    ];

    showCustom = true;

    handleSwitch(){
        this.showCustom = !this.showCustom;
        console.log(this.showCustom);
    }

    render(){
        return this.showCustom ? carouselWrapper : standardCarousel;
    }

}