import { LightningElement,wire,api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { getRecord, updateRecord } from 'lightning/uiRecordApi';
import USER_ID from '@salesforce/user/Id';
import { CloseActionScreenEvent } from 'lightning/actions';

import ID_FIELD from "@salesforce/schema/Case.Id";
import NAME_FIELD from "@salesforce/schema/Case.OwnerId";

export default class EscalateToTL extends LightningElement {
    @api recordId;

    @wire(getRecord,{recordId: USER_ID,fields:'user.ManagerId'})
    wiredRecord({error,data}){
        
        if(data){
            console.log('data present');
            console.log(data);
            console.log(this.recordId);
        }
    }
    

}