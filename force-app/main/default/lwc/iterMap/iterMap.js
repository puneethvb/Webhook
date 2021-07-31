import { LightningElement,wire,track } from 'lwc';
import simpleMap from '@salesforce/apex/LWCUtil.simpleMap';
import sobjList from '@salesforce/apex/LWCUtil.listOfSobjects';
import parseData from '@salesforce/apex/LWCUtil.parseData';

export default class IterMap extends LightningElement {
    @track mapData= [];
    name = 'Punee';
    count = 5;
    param1;
    param2;
    param3;
    @track accounts;
    @wire(simpleMap,{name :'$name'})
    wiredMap({data,error}){
        console.log(data);
        console.log(error);
        if(data){
            console.log(data);
            for(let key in data ){
                this.mapData.push({value:data[key],key:key});
            }
        }
    }

    constructor(){
        super();
        sobjList({count : this.count, abc : this.name})
        .then(result=>{
            this.accounts = result;
        })
        .catch(error=>{
            console.log('Error');
        })
       
    }

    displayParams(){
        parseData()
        .then(result=>{
            console.log('I am here');
            let obj = JSON.parse(result);
            console.log(obj);
            this.param1 = obj['param1'];
            console.log(this.param1);
            this.param2 = obj['param2'];
            this.param3 = obj['param3'];
            console.log(this.param1,this.param2,this.param3);
        })
        .catch(error=>{
            console.log('Error in button');
        })
    }

}