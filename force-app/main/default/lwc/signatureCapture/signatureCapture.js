import { LightningElement } from 'lwc';
import saveSign from '@salesforce/apex/SignatureHelper.saveSign';
import { ShowToastEvent } from 'lightning/platformShowToastEvent'; 

let canvasElement, canvasContext;
export default class SignatureCapture extends LightningElement {
    x = '#0000A0';
    y = 1.5;
    //canvasElement;
    //canvasContext;
    attachment;
    dataURL;
    convertedDataURI;
    isDown;
    isDot = false;
    prevX=0;
    prevY=0;
    currX=0;
    currY=0;
    isThereASign = false;
    constructor(){
        console.log('I am in constructor');
        super();
        this.template.addEventListener('mousemove',this.handleMouseMove.bind(this));
        this.template.addEventListener('mousedown',this.handleMouseDown.bind(this));
        this.template.addEventListener('mouseup',this.handleMouseUp.bind(this));
        this.template.addEventListener('mouseout',this.handleMouseOut.bind(this));
       
    }

    renderedCallback(){
        console.log('Inside Rendered');
        console.log(this);
        canvasElement = this.template.querySelector('canvas');
        console.log(canvasElement);
        canvasContext = canvasElement.getContext("2d");
        
    }
    handleMouseDown(event){
        this.searchCoordinatesForEvent('down',event);
    }
    handleMouseUp(event){
        this.searchCoordinatesForEvent('up',event);
    }
    handleMouseOut(event){
        this.searchCoordinatesForEvent('out',event);
    }

    handleMouseMove(event){
        this.searchCoordinatesForEvent('move',event);
    }


    searchCoordinatesForEvent(request, event){
        event.preventDefault();
        console.log(request);
        if(request == 'down'){
            this.setupCoordinates(event);
            this.isDown = true;
            this.isDot = true;
            if(this.isDot){
                this.drawDot();
                this.isDot = false;                
            }
        }

        if(request === 'up' || request === 'out'){
            this.isDown =  false;
        }

        if(request === 'move'){
            if(this.isDown){
                this.setupCoordinates(event);
                this.reDraw();
            }
        }
    }

    setupCoordinates(event){
        const clientRec = canvasElement.getBoundingClientRect();
        this.prevX = this.currX;
        this.prevY = this.currY;
        this.currX = event.clientX - clientRec.left;
        this.currY =  event.clientY - clientRec.top;
    }

    drawDot(){
        console.log('Inside drawDot');
        //this.isThereASign =  true;
        canvasContext.beginPath();
        canvasContext.fillStyle = this.x;
        canvasContext.fillRect(this.currX,this.currY,this.y,this.y);
        canvasContext.closePath();
    }

    reDraw(){
        console.log('Inside reDraw');
        this.isThereASign = true;
        canvasContext.beginPath();
        canvasContext.moveTo(this.prevX,this.prevY);
        canvasContext.lineTo(this.currX,this.currY);
        canvasContext.strokeStyle = this.x;
        canvasContext.lineWidth = this.y;
        canvasContext.closePath();
        canvasContext.stroke();
    }

    handleSave(){
        canvasContext.globalCompositeOperation = 'destination-over';
        canvasContext.fillStyle = '#FFF';
        canvasContext.fillRect(0,0,canvasElement.width, canvasElement.height);
        this.dataURL = canvasElement.toDataURL("image/png");
        this.convertedDataURI = this.dataURL.replace(/^data:image\/(png|jpg);base64,/, "");
        console.log(this.isThereASign);
        if(this.isThereASign){
            saveSign({signature : this.convertedDataURI})
            .then(result=>{
                this.attachment = result;
                console.log(result.Id);
                this.dispatchEvent(new ShowToastEvent({
                 title : 'Success',
                 variant : 'success',
                 message : 'Attchment created successfully'
             }));

            })

            .catch(error=>{
                 this.dispatchEvent(new ShowToastEvent({
                    title : 'failure',
                    message : 'Failed',
                    variant : 'error'
             }));
         })

        }
        else{
            this.dispatchEvent(new ShowToastEvent({
                title : 'No Signature found',
                message : 'Please sign the canvas before submitting.',
                variant : 'warning'
            }));

        }
        this.handleClear();  
        
    }

    handleClear(){
        canvasContext.clearRect(0,0,canvasElement.width,canvasElement.height);
        this.isThereASign =  false;
    }

}