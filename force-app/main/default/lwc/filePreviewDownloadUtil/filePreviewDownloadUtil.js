import { LightningElement, api, wire } from 'lwc';
import fetchFileDetails from '@salesforce/apex/FileDownloadController.fetchFileDetails';
import { NavigationMixin } from 'lightning/navigation';

export default class FilePreviewDownloadUtil extends NavigationMixin(LightningElement) {
    @api recordId;
    filesList = [];
    @wire(fetchFileDetails, {parentId :'$recordId'})
    wireResult({data,error}){
        if(data){
            console.log(data);
            this.filesList = Object.keys(data).map(item=>({
                "label":data[item],
                'value':item,
                'url' : `/sfc/servlet.shepherd/document/download/${item}`
            }))

            console.log(this.filesList);        

        }
        else{
            console.log(error);
        }
    }

    handlePreview(event){

        console.log(event.target.dataset.id);

        this[NavigationMixin.Navigate]({
            type:'standard__namedPage',
            attributes:{
                pageName : 'filePreview'
            },
            state : {
                selectedRecordId : event.target.dataset.id
            }
        });

        
          
          
        

    }
}