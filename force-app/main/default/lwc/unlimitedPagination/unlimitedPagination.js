import { LightningElement , api } from 'lwc';
import getAccounts from '@salesforce/apex/UnlimitedPaginationController.getAccounts';
import searchAccounts from '@salesforce/apex/UnlimitedPaginationController.searchAccounts';
import saveRecords from '@salesforce/apex/UnlimitedPaginationController.saveRecords';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class UnlimitedPagination extends LightningElement {
    @api recordsPerPage = 5;
    accounts = [];
    selectedRecords = [];
    elements = [];
    dataMap = [];
    count = 0;
    accName;
    isPreviousDisabled = true;

    connectedCallback(){
        this.getRecords();
    }

    getRecords(){
        getAccounts({prevRef : null , nextRef : null , recordsLimit : this.recordsPerPage})
            .then(data=>{
                if(data){
                    this.formatRecords(data);
                    this.fillElements(data);                    
                }
            })
    }

    handleNext(){
        console.log(this.dataMap);
        if(this.accName && this.accName !== ''){
            searchAccounts({prevRef : null , nextRef : this.dataMap[this.count].value[1],recordsLimit: this.recordsPerPage,name : this.accName})
                .then(data=>{    
                    console.log(data);
                    this.getDataInOrder(data);                        
                })
        }
        else{
            console.log('inside handleNext Else');
            console.log(this.dataMap[this.count].value[1]);
            getAccounts({prevRef : null, nextRef : this.dataMap[this.count].value[1],recordsLimit : this.recordsPerPage})
                .then(data=>{
                    this.getDataInOrder(data);
                })
        }
    }

    handlePrevious(){
        if(this.dataMap){
            if(this.accName && this.accName!== ''){
                searchAccounts({prevRef : this.dataMap[this.count-1].value[0], 
                                nextRef : this.dataMap[this.count-1].value[1],
                                recordsLimit : this.recordsPerPage,
                                name : this.accName
                            })
                    .then(data=>{
                        this.getDataInOrderForPrev(data);
                    })
            }
            else{
                getAccounts({prevRef : this.dataMap[this.count-1].value[0], 
                    nextRef : this.dataMap[this.count-1].value[1],
                    recordsLimit : this.recordsPerPage
                })
                    .then(data=>{
                        this.getDataInOrderForPrev(data);
                    })
            }
        }
    }

    handleSiteChange(event){
        console.log(event.target.name);
        let element = this.accounts.find(ele=> ele.Id === event.target.name);
        console.log(element);
        element.isChecked =  true;
        element.site = event.target.value;
        console.log('4',this.selectedRecords.length);
        if(this.selectedRecords.length > 0 && this.selectedRecords.find(ele=> ele.Id === event.target.name)){
            for(let i = 0; i< this.selectedRecords.length; i++){
                if(this.selectedRecords[i].Id === event.target.name){
                    this.selectedRecords.splice(i,1);
                }
            }
        }
        this.selectedRecords.push(element);
        console.log(this.selectedRecords);
    }

    formatRecords(data){
        this.accounts = [];
        if(data){
            data.forEach(item => {
                this.accounts.push({
                    "Id" : item.Id,
                    "Name" : item.Name,
                    "AccountReference" : item.AccountReference__c,
                    "site" : item.Site,
                    "isChecked" : false
                })
                console.log(this.accounts);                
            });

            if(this.selectedRecords.length > 0){
                this.accounts.forEach(acc => {
                    let element = this.selectedRecords.find(ele => ele.Id == acc.Id);
                    if(element !== undefined){
                        acc.isChecked = true;
                        if(element.site){
                            acc.site = element.site;
                        }
                    }                    
                });
                console.log(this.accounts);
                console.log([...this.accounts]);
                this.accounts = [...this.accounts];
            }
        }
    }

    handleRecordSelection(event){
        console.log(event.target.name);
        let element = this.accounts.find(ele=> ele.Id === event.target.name);
        console.log(element);
        if(event.target.checked && !this.selectedRecords.find(ele=> ele.Id === event.target.name)){
            this.selectedRecords.push(element);
        }
        else if(!event.target.checked && this.selectedRecords.find(ele=> ele.Id === event.target.name)){            
            for(let i=0; i <this.selectedRecords.length; i++){
                if(this.selectedRecords[i].Id === event.target.name){
                    element.isChecked = false;
                    this.selectedRecords.splice(i,1);
                }
            }
        }
        console.log(this.selectedRecords);
    }

    fillElements(data){
        this.elements.push(data[0].AccountReference__c,data[data.length-1].AccountReference__c);
        this.dataMap.push({
            key : this.count,
            value : this.elements
        });
    }

    getDataInOrder(data){
        if(data){
            this.formatRecords(data);
            this.elements = [];
            this.count++;
            if(!this.dataMap[this.count]){
                this.fillElements(data);
            }
            this.fixPreviousActive();
        }
    }

    getDataInOrderForPrev(data){
        if(data){
            this.formatRecords(data);
            this.count--;
            this.fixPreviousActive();
        }
    }

    fixPreviousActive(){
        this.isPreviousDisabled = this.count < 1 ? true :false;
    }

    handleSearch(){
        this.accName = this.template.querySelector('.accname').value;
        this.dataMap = [];
        this.count = -1; // getDatainOrder method has count++ so it will become zero.
        searchAccounts({prevRef : null, nextRef :null, name : this.accName, recordsLimit: this.recordsPerPage})
         .then(data=>{
             this.getDataInOrder(data);
         })
    }

    handleShowAll(){
        this.elements = [];
        this.dataMap = [];
        this.count = 0;
        this.template.querySelector('.accname').value = '';
        this.accName= '';
        this.getRecords();
    }

    showMessage(message, title, variant, mode){
        const evt = new ShowToastEvent({message : message, title : title, mode : mode, variant : variant});
        this.dispatchEvent(evt);
    }

    handleSave(){
        if(this.selectedRecords.length > 0){

            saveRecords({selectedRecsJSON: JSON.stringify(this.selectedRecords)})
             .then(data=>{
                 console.log(data);
                 if(data){
                     this.showMessage('Record(s) saved Successfully','Succes','success','dismissible');
                 }
                 else{
                    this.showMessage('Record(s) failed to save','Error','error','dismissible');
                 }
             })
             .catch(error=>{
                 console.log(error);
                 this.showMessage('System.error: '+JSON.stringify(error.body.message),'Error','error','dismissable');
             })
        }
    }
}