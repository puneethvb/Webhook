import { LightningElement, track } from 'lwc';
import { subscribe, unsubscribe, onError, setDebugFlag, isEmpEnabled } from 'lightning/empApi';

export default class PushTopicConsole extends LightningElement {

    channelName = '/topic/AccountUpdates1';
    subscription = {};
    @track returnedAccount;

    connectedCallback(){
        const messageCallback = (response)=> {
            console.log('New message received: ', JSON.stringify(response));
            this.returnedAccount = JSON.stringify(JSON.parse(JSON.stringify(response)).data.sobject);
            console.log('ReturnedAccount :',this.returnedAccount);
            // Response contains the payload of the new message received
        };
        subscribe(this.channelName, -1, messageCallback).then(response => {
            // Response contains the subscription information on subscribe call
            console.log('Subscription request sent to: ', JSON.stringify(response.channel));
            this.subscription = response;
            console.log('payload: ',JSON.stringify(this.subscription));
            //this.returnedAccount = JSON.stringify(response.sobject);
            //this.toggleSubscribeButton(true);
        });
    }
    clickForAcc(){
        console.log(this.returnedAccount);
    }

}