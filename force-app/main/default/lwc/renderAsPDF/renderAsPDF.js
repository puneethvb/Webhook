import { LightningElement } from 'lwc';
import generatePDF from '@salesforce/apex/DisplayRichTextHelper.generatePDF';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';

export default class RenderAsPDF extends LightningElement {
    allowedFormats =  ['font', 'size', 'bold', 'italic', 'underline', 'strike',
    'list', 'indent', 'align', 'link', 'image', 'clean', 'table', 'header', 'color',
    'background','code','code-block'];

    get myVal(){
        return '**Generate PDF using LWC';
    }
    contentDocId;

    handlePDF(){
        const editor = this.template.querySelector('lightning-input-rich-text');
        generatePDF({pdfData : editor.value})
            .then(data=>{
                this.contentDocId = data;
                this.dispatchEvent(new ShowToastEvent({
                    message : 'Attachment created with Id '+this.contentDocId,
                    title : 'Success',
                    variant : 'success'
                }));
            })
            .catch(error=>{
                this.dispatchEvent(new ShowToastEvent({
                    message : 'Error occured',
                    title : 'Error',
                    variant : 'error'
                }));

            })
    }

}