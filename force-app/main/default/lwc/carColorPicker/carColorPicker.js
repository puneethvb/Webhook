import { LightningElement } from 'lwc';
const BASE_IMAGE = 'https://sfdc-demo.s3-us-west-1.amazonaws.com/ecars';
const COLORS = ['red','green','black','blue','white']; 

export default class CarColorPicker extends LightningElement {
    colors = COLORS;
    selectedColor = this.colors[0];
    get selectedImage(){

        return `${BASE_IMAGE}/car_${this.selectedColor}.jpg`;

    }

    handleColor(event){
        this.selectedColor = event.target.dataset.color;
        console.log(this.selectedColor);
    }
}