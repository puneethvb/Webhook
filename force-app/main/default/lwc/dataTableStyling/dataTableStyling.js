import { LightningElement, wire } from 'lwc';
import getAccounts from '@salesforce/apex/DataTableController.getAccounts';
import { loadStyle } from 'lightning/platformResourceLoader';
import COLORS from '@salesforce/resourceUrl/colors';
const COLUMNS = [
    {label :'Account Name', fieldName : 'Name', type : 'text', cellAttributes: {
        class :{fieldName : 'accountColor'}
    }},
    {label :'Annual Revenue', fieldName : 'AnnualRevenue', type : 'currency', cellAttributes : {
        class :{fieldName : 'amountColor'},
        iconName : {fieldName : 'iconName'}, iconPosition : 'right'
    }},
    {label :'Industry', fieldName : 'Industry', type : 'text', cellAttributes : {
        class: {fieldName : 'industryColor'}
    }},
    {label : 'Phone', fieldName : 'Phone', type : 'phone'}
];
export default class DataTableStyling extends LightningElement {
    columns = COLUMNS;
    tableData;
    isData;
    isCSSLoaded = false;
    @wire(getAccounts)
    accountsHandler({data,error}){
        if(data){
            console.log('hi',data);
            this.tableData = data.map(item=>{
                let amountColor = item.AnnualRevenue > 500000000 ? "slds-text-color_success" : "slds-text-color_error";
                let iconName = item.AnnualRevenue > 500000000 ? "utility:up":"utility:down";
                return{...item, amountColor,iconName, 
                       industryColor : 'slds-icon-custom-custom35 slds-text-color_default',
                       accountColor : 'dataTable-color'};
            })
        }
        else{
            console.log(error);
        }
    }

    renderedCallback(){
        if(this.isCSSLoaded) return;
        this.isCSSLoaded = true;
        loadStyle(this,COLORS)
            .then(()=>{
                console.log('Succesfully loaded');
            })
            .catch(error=>{
                console.log('Error');
                console.log(error);
                
            })
    }
}