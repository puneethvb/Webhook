import { LightningElement, api } from 'lwc';

export default class ActionLWC extends LightningElement {

    @api invoke(){
        console.log('Hell meeting me');
    }
}