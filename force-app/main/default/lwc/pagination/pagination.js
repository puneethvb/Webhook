import { LightningElement,api } from 'lwc';

export default class Pagination extends LightningElement {
    pageSize = 5;
    currentPage;
    numberOfPages;
    currentPageNum = 1;
    totalRecords;
    get disableNext(){
        return this.currentPageNum >= this.numberOfPages;
    }

    get disablePrev(){
        return this.currentPageNum <= 1;
    }
    @api 
    get records(){
        return this.totalRecords;
    }
    set records(data){
        if(data){
            this.totalRecords = data;
            this.numberOfPages =Math.ceil(data.length/this.pageSize);
            this.sendCurrentPage();
        }
    }
    
    handleNext(){

        console.log('Inside handleNext');
        console.log(this.currentPageNum);
        console.log(this.numberOfPages);
        if(this.currentPageNum < this.numberOfPages){
            this.currentPageNum+=1;
            this.sendCurrentPage();
        }

    }

    handlePrevious(){

        if(this.currentPageNum > 1){
            this.currentPageNum -=1;
            this.sendCurrentPage();

        }

    }

    sendCurrentPage(){

        const start = (this.currentPageNum-1)*this.pageSize;
        const end = start + this.pageSize;

        this.currentPage = this.totalRecords.slice(start,end);
        this.dispatchEvent(new CustomEvent('update',{
            detail: {
                records : this.currentPage
            }
        }));
    }
}