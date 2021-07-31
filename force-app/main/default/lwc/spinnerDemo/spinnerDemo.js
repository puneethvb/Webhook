import { LightningElement } from 'lwc';

export default class SpinnerDemo extends LightningElement {
    showSpinner = false;

    displaySpinner(){
        this.showSpinner = true;
    }
    hideSpinner(){
        this.showSpinner = false;
    }
}