import { LightningElement } from 'lwc';
import {subscribe, unsubscribe, onError, setDebugFlag, isEmpEnabled} from 'lightning/empApi';

export default class PeSubscribe extends LightningElement {
    channelName = '/event/Error_Event__e';
    subscription = {};
    userName;
    stackTrace;
    connectedCallback(){

        const messageCallback = (response)=>{
            console.log('I am inside callback');
            console.log(JSON.stringify(response));
            console.log('==========');
            var abc = response;
            console.log(response.data);
            console.log('==========');
            var b = response.data;
            console.log(b.schema);

            //console.log(JSON.parse(JSON.stringify(response).data));
            //console.log(JSON.stringify(JSON.parse(response.getReturnValue())));
            this.subscription = response;
            console.log(response.data.payload.User_Name__c);
            this.userName = response.data.payload.User_Name__c;
            this.stackTrace =  response.data.payload.Stack_Trace__c;
        };

        subscribe(this.channelName,-1,messageCallback)
        .then(response=>{
            console.log('I am inside cons');
            this.subscription = response;
        })

    }
}