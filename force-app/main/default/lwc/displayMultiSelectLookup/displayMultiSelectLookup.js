import { LightningElement, track } from 'lwc';

export default class DisplayMultiSelectLookup extends LightningElement {
    selectedItemsToDisplay ='';
    @track values = [];
    isItemExists = false;

    retrievHandler(event){
        let args = JSON.parse(JSON.stringify(event.detail.arr));
        this.displayScreen(args);
    }

    removeHandler(event){
        let args = JSON.parse(JSON.stringify(event.detail.arr));
        this.displayScreen(args);
    }

    displayScreen(args){
        this.values = [];
        args.map(element=>{
            this.values.push(element.label);
        });

        this.isItemExists = (args.length>0);
        this.selectedItemsToDisplay = this.values.join(', ');

    }
}