import { LightningElement } from 'lwc';
import template1 from './multiTemplate1.html';
import template2 from './multiTemplate2.html';
export default class MultiTemplate extends LightningElement {
    showTemp = true;
    render(){
        return this.showTemp ? template1 : template2;
    }

    switchTemp(){
        this.showTemp = !this.showTemp;
    }
}