import { LightningElement,api, track } from 'lwc';

export default class FileUploadUtil extends LightningElement {

    @track isProcessCompleted = false;
    @api recordId;
    @track message;
    @track spinner;

    linkFiles(event){
        this.spinner = true;
        setTimeout(() => {
            this.isProcessCompleted = true; 
            this.message = '5 email attachments linked to the case';
            this.spinner = false;
             }, 2000);
        

        
    }
}