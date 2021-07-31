import { LightningElement, api } from 'lwc';

const SLDS_SHOW = 'slds-show fade';
const SLDS_HIDE = 'slds-hide';
const DOT_SHOW = 'dot active';
const DOT_HIDE = 'dot';
export default class CustomCarousel extends LightningElement {
    slidesData= [];
    slideIndex =1;
    timer;
    @api showFull = false;
    @api interval = 1000;
    @api autoScroll = false;
    @api 
    
    get slides(){
        return this.slidesData;
    }

    set slides(data){
        this.slidesData = data.map((item,index)=>{

            return index===0? {...item,slideIndex:index+1,cardClass:SLDS_SHOW,dotClass:DOT_SHOW}:{...item,slideIndex:index+1,cardClass:SLDS_HIDE,dotClass:DOT_HIDE};

        })
    }
    get maxWidth(){
        return this.showFull? `width:100%`:'width:50%';
    }
    handleBack(){
        console.log('inside 1');
        this.processSlide(this.slideIndex - 1);

    }

    handleForward(){
        console.log('inside 2');
        this.processSlide(this.slideIndex + 1);

    }

    processSlide(index){
        console.log('inside 3',index);
        if(index > this.slides.length){
            this.slideIndex = 1;
        }
        else if(index < 1){
            this.slideIndex = this.slides.length;
        }
        else{
            this.slideIndex = index;
        }

        this.slidesData = this.slidesData.map(item=>{
            return item.slideIndex === this.slideIndex ? {...item,cardClass:SLDS_SHOW,dotClass:DOT_SHOW}:{...item,cardClass:SLDS_HIDE,dotClass:DOT_HIDE};
        })
        console.log(this.slidesData);
    }

    currentSlide(event){
        let index = Number(event.target.dataset.id);
        console.log(index);
        this.processSlide(index);
    }

    connectedCallback(){

        if(this.autoScroll){
            this.timer = window.setInterval(() => {

                this.processSlide(this.slideIndex+1);
                
            }, this.interval);
        }

    }

    disconnectedCallback(){
        if(this.autoScroll){
            window.clearInterval(this.timer);
        }
    }


    
}