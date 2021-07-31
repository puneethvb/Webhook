import { LightningElement, api } from 'lwc';

export default class Loader extends LightningElement {

    @api spinnerText='';
    @api variant = 'brand';
    @api size ='medium';

    get helpText(){
        return this.spinnerText != ''? this.spinnerText : 'Loading...';
    }

}