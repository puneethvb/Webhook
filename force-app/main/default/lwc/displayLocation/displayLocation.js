import { LightningElement, wire, track } from 'lwc';
import {subscribe, unsubscribe, APPLICATION_SCOPE, MessageContext} from 'lightning/messageService';
import selectedEntity from '@salesforce/messageChannel/SelectedEntityId__c';

let selectedAccount;
export default class DisplayLocation extends LightningElement {
    subscription = null;
    //selectedAccount;
    selecetdAccountName ='';
    @track mapMarkers = [];
    zoomLevel = 4;
    center;
    isDisplayLocation = false;
    
    @wire(MessageContext)
    messageContext;

    connectedCallback(){
        console.log(' I am here in callba');
        this.subscribeToMessageChannel();
        this.isDisplayLocation =  false;
    }
   /* constructor(){
        super();
        console.log(' I am here in cons');
        this.subscribeToMessageChannel();
        this.isDisplayLocation =  false;
    }*/

    disconnectedCallback(){
        this.unsubscribeToMessageChannel();
    }

    subscribeToMessageChannel(){
        console.log(this.subscription);
        if(!this.subscription){
            console.log('inside subscribe');
            this.subscription = subscribe(
                this.messageContext,selectedEntity,
                (message)=> this.handleMessage(message),
                {scope : APPLICATION_SCOPE}
            );
            console.log(this.subscription);
        }
    }

    unsubscribeToMessageChannel(){
        unsubscribe(this.subscription);
        this.subscription = null;
    }

    handleMessage(message){
        selectedAccount = message.entityInfo;
        this.selecetdAccountName = selectedAccount.Name;
        console.log(this.selecetdAccountName);
        this.mapMarkers = [{
            location :{
                Street : selectedAccount.BillingStreet,
                City : selectedAccount.BillingCity,
                State : selectedAccount.BillingState,
                Country : selectedAccount.BillingCountry
            },
            icon : 'custom:custom26',
            title : selectedAccount.Name,
            }

        ];
        this.center= {
            location: {
                City : selectedAccount.BillingCity
            }
        };
        this.zoomLevel = 6;
        this.isDisplayLocation = true;
    }

}