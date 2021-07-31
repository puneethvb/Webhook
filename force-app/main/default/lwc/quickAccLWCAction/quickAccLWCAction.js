import { LightningElement } from 'lwc';
import {CloseActionScreenEvent} from 'lightning/actions';

export default class QuickAccLWCAction extends LightningElement {
    closeAction(){
        this.dispatchEvent(new CloseActionScreenEvent());
    }
}