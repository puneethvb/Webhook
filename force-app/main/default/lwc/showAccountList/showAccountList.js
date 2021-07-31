import { LightningElement, wire } from 'lwc';
import fetchAccounts from '@salesforce/apex/AccountHelper.fetchAccountLocations';
import {publish, MessageContext } from 'lightning/messageService';
import selectedEntity from '@salesforce/messageChannel/SelectedEntityId__c';

export default class ShowAccountList extends LightningElement {
    @wire(MessageContext)
    messageContext;

    @wire(fetchAccounts)
    accounts;

    handleClick(event){
       /* let dataset = event.target;
        console.log('target ',JSON.stringify(dataset));
        let temp = event.target.dataset;
        let key = event.target.key;
        console.log(temp);
        console.log(key);*/
        let accId = event.target.name;
        console.log(accId);
        let selectedAcc = this.accounts.data.find(element => element.Id == accId);
        console.log(selectedAcc);
        let payload = {entityInfo : selectedAcc};
        console.log(payload);
        publish(this.messageContext,selectedEntity,payload);
    }

}