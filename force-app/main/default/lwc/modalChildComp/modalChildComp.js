import { LightningElement, api } from 'lwc';

export default class ModalChildComp extends LightningElement {
    @api header;
    @api content;
    handleCancel(){
        const newEvent = new CustomEvent('close');
        this.dispatchEvent(newEvent);
    }
}