import { LightningElement } from 'lwc';

export default class ParentComp extends LightningElement {
    parentProp = 0;
    handleIn(event){
        console.log('Inside In');
        this.parentProp = this.parentProp + event.detail;
        console.log(this.parentProp);
    }
    handleD(event){
        console.log('Inside d');
        this.parentProp = this.parentProp - event.detail;
        console.log(this.parentProp);
    }
}