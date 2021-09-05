import { LightningElement } from 'lwc';
import { loadStyle} from 'lightning/platformResourceLoader';
import input from '@salesforce/resourceUrl/input';

export default class InputIcon extends LightningElement {

    showPassword = false;
    get utilityClass(){
        return this.showPassword? 'utility:hide' : 'utility:preview';
    }

    get passwordType(){
        return this.showPassword? 'text' : 'password';
    }

    handleClick(){
        this.showPassword = !this.showPassword;
    }

    connectedCallback(){
        loadStyle(this,input).then(()=>{
            console.log('loaded successfully1233');
        })
    }
}