import { LightningElement } from 'lwc';

const SEARCH_PARMS= [
    {label:"Last Name",type:'text'},
    {label:"First Name",type:'text'},
    {label:"Account Phone",type:'phone'},
    {label:'Email',type:'email'},
    {label:'Mailing Zip/Postal Code',type:'text'},    
    {label:'Mobile',type:'phone'}
];

const OWNER_PARMS= [
    {label:"VIN",type:'text'},
    {label:"Case Number",type:'text'},
    {label:"Dealer",type:'text'},
];

export default class AccountWSLWC extends LightningElement {

    searchParams = SEARCH_PARMS;
    ownerParams = OWNER_PARMS;
    
}