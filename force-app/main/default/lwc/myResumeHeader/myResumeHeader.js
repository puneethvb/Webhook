import { LightningElement,api } from 'lwc';

export default class MyResumeHeader extends LightningElement {

    @api profileImage;
    @api userDetails;
    @api socialLinks;

    get emailLink(){
        return `mailto:${this.userDetails.email}`;
    }
    get phoneLink(){
        return `tel:${this.userDetails.phone}`;
    }
}