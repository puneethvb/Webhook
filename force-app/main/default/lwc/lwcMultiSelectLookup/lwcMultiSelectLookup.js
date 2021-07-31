import { LightningElement, api, track} from 'lwc';
import getRecords from '@salesforce/apex/MultiSelectLookupController.retreiveRecords';

export default class LwcMultiSelectLookup extends LightningElement {

    @track globalSelectedItems =[];
    @api labelName;
    @api objName;
    @api fieldNames;
    @api filtes;
    @api iconName;
    
    @track items = [];//holds all values from DB
    @track selectedItems = []; //all items from current selection
    @track previousSelectedItems = [];
    @track values = [];
    searchInput ='';
    isDialogDisplay = false;
    noRecFound = false;
    
    onChangeSearchInput(event){
        console.log('inside search change');
        this.searchInput = event.target.value;
        console.log(this.searchInput);
        if(this.searchInput.trim().length > 0){
            getRecords({
                objName : this.objName,
                fields : this.fieldNames,
                filter : this.filtes,
                search : this.searchInput
            })
            .then(result=>{
                console.log(result);
                this.items = [];
                this.values = [];
                this.previousSelectedItems = [];
                if(result.length > 0){
                    console.log('Inside the reults');
                    result.map(res=>{
                        this.items = [...this.items,{value : res.recordId, label : res.recordName}];
                        this.globalSelectedItems.map(element=>{
                            if(element.value == res.recordId){
                                this.values.push(element.value);
                                this.previousSelectedItems.push(element);
                            }

                        });
                    });
                    this.isDialogDisplay = true;
                    this.noRecFound = false;
                    console.log('finishing the DB call');
                }
                else{
                    this.isDialogDisplay = false;
                    this.noRecFound = true;
                }
            })
            .catch(error=>{
                console.log(error);
                this.items = undefined;
                this.isDialogDisplay = false;
            })

        }
        else{
            this.isDialogDisplay =  false;
        }
    }

    handleCheckboxChange(event){
        let tempSelected = event.detail.value;
        this.selectedItems= [];
        tempSelected.map(val=>{
            let arr = this.items.find(element => element.value == val);
            if(arr != undefined){
                this.selectedItems.push(arr);
            }
        });
    }

    handleRemove(event){
        let tempRem = event.target.name;
        console.log(tempRem);
        this.globalSelectedItems = this.globalSelectedItems.filter(item=> item.value != tempRem);
        let arr = this.globalSelectedItems;
        this.initilizeValues();
        this.values=[];
        const custEvt = new CustomEvent('remove',{
                                        detail : {tempRem,arr}
        });
        this.dispatchEvent(custEvt);
    }

    handleDoneClick(event){
        this.previousSelectedItems.map(pItem=>{
            this.globalSelectedItems = this.globalSelectedItems.filter(item => item.value != pItem.value);
        });

        this.globalSelectedItems.push(...this.selectedItems);
        const arr = this.globalSelectedItems;
        this.previousSelectedItems = this.selectedItems;
        this.initilizeValues();
        const eventCust = new CustomEvent('retrieve',{
            detail : {arr}
        });
        this.dispatchEvent(eventCust);
    }

    handleCancelClick(){
        this.initilizeValues();
    }

    initilizeValues(){
        this.searchInput = '';
        this.isDialogDisplay = false;
    }
}