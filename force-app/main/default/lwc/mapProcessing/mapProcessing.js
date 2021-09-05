import { LightningElement, wire } from 'lwc';
import getMap from '@salesforce/apex/MapProcessing.getMap';
export default class MapProcessing extends LightningElement {

    processedMap = [];
    show= false;
    @wire(getMap)
    wiredMap({error,data}){
        if(data){
            this.show = true;
            for(let keyUp in data){
                if(data.hasOwnProperty(keyUp)){        
                    this.processedMap.push({value : data[keyUp], key:keyUp});
                }
            }
        }
        console.log('processed',this.processedMap);
    }
}