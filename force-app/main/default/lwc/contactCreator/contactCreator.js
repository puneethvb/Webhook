import { LightningElement } from 'lwc';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import CONTACT_OBJECT from '@salesforce/schema/Contact';
import FIRST_NAME from '@salesforce/schema/Contact.FirstName';
import LAST_NAME from '@salesforce/schema/Contact.LastName';
import Email from '@salesforce/schema/Contact.Email';


export default class ContactCreator extends LightningElement {

    objectApiName = CONTACT_OBJECT;
    fields = [FIRST_NAME,LAST_NAME,Email];
    handleSuccess(event){
        const showToast = new ShowToastEvent({
            title : "Contact created",
            message : "Record Id "+ event.detail.id,
            variant : "success"
        });

    this.dispatchEvent(showToast);

    }
}