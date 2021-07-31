import { LightningElement } from 'lwc';

export default class ChildComponent extends LightningElement {
    increase(){
        console.log('inside inc ev');

        this.dispatchEvent(new CustomEvent('incr',{detail :10}));
    }

    decrease(){
        console.log('inside dec ev');
        this.dispatchEvent(new CustomEvent('decr',{detail : 5}));
    }
}