import { LightningElement, api } from 'lwc';

export default class ResumeHeader extends LightningElement {
    @api profileImage;
    @api socialLinks;
    @api userDetails;
}