import { LightningElement } from 'lwc';

export default class GetterProp extends LightningElement {
    get message(){
        return 'I am Puneeth';
    }

    get message1(){
        return 'I am Puneeth1';
    }
}