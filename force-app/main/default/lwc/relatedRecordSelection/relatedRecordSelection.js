import { LightningElement,api,track } from 'lwc';
import updateOp from '@salesforce/apex/OppUpdateClass.updateOpp';
import {getRecordNotifyChange } from 'lightning/uiRecordApi';

export default class RelatedRecordSelection extends LightningElement {
    @api recordId;
    @track acclIst;
    @track caseList;
    selectedAcc;
    selectedCase;
    acclIst = [{label: 'ABCD',value :'0017F00000OLK8jQAH'},
                {label: 'ABCDE',value :'0017F000008xC5yQAE'}];
    onAccChange(event){
        this.selectedAcc = event.detail.value;
    }

    onCasChange(event){
        this.selectedCase = event.detail.value;
    }
    SaveRecs(){
        updateOp({oppId : this.recordId, accId : this.selectedAcc, casId :this.selectedCase})
            .then(result => {
                console.log('succes');
                this.selectedAcc = '';
                getRecordNotifyChange([{recordId: this.recordId}]);

            })
            .catch(error=>{
                console.log('error');
            })
            
    }
}