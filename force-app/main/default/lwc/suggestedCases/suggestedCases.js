import { LightningElement, api, wire } from 'lwc';
import fetchCases from '@salesforce/apex/CaseController.fetchSuggestedCases';

const columns = [
    {
        label : 'Case Number',
        fieldName : 'urlField',
        fixedWidth : 120,
        type :'url',
        typeAttributes : {
            label : {
                fieldName : 'CaseNumber'
            },
            target : '_blank'
        },
        sortable : true
    },
    {label : 'Subject', fieldName : 'Subject'}
];
export default class SuggestedCases extends LightningElement {

    @api recordId;
    records;
    columns;
    error;
    
    @wire(fetchCases,{caseId : '$recordId'})
    wiredCases({error,data}){
        console.log(data);
        if(data){
            console.log('Inside Data');
            let urlField;
            this.records = data.map(item=>{
                urlField = '/lightning/r/Case/' + item.Id + '/view';
                return{...item,urlField};
            });
            console.log(this.records);
            this.columns = columns;
        }
        else if(error){
            console.log('Inside Error');
            console.log(error);

        }
    }

}