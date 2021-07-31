import { LightningElement, wire } from 'lwc';
import fetchContacts from '@salesforce/apex/RefreshContacttController.fetchContacts';
import { updateRecord } from 'lightning/uiRecordApi';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import {refreshApex} from '@salesforce/apex';
const COLUMNS = [
    {label:'First Name', fieldName : 'FirstName', editable: true},
    {label:'Last Name', fieldName : 'LastName', editable: true},
    {label:'Email', fieldName : 'Email', type: 'email'}
]
export default class RefreshDemoLWC extends LightningElement {
    draftVals = [];
    columns = COLUMNS;
    @wire(fetchContacts)
    contacts;
    handleSave(event){
        console.log(event.detail.draftValues);
        const recordInputs = event.detail.draftValues.map(draft=>{
            const fields = Object.assign({},draft);
            return{fields};
        });

        const promises = recordInputs.map(input=>updateRecord(input));
        Promise.all(promises).then(result=>{
            this.draftVals = [];
            this.showToast('Updated','Records Updated');
            return refreshApex(this.contacts);

        })
        .catch(error=>{

            this.showToast('failed','Records were not saved','error');

        })

    }

    showToast(title, message, variant){

        this.dispatchEvent(new ShowToastEvent({
            title :title,
            message : message,
            variant : variant||'success'
        }))

    }

}