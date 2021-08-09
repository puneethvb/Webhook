import { LightningElement, wire } from 'lwc';
import fetchContacts from '@salesforce/apex/PaginationDemoController.fetchContacts';

export default class PaginationDemo extends LightningElement {

    contacts;
    currentPage;

    @wire(fetchContacts)
    wiredProcessing({error, data}){
        if(data){
            this.contacts = data;
            console.log(data);
        }

        else{

            console.log(error);

        }
    }

    handleUpdate(event){
        console.log('inside update');
        console.log(event.detail.records);
        this.currentPage = [...event.detail.records];

    }
}