import { LightningElement } from 'lwc';

export default class ModalParentComp extends LightningElement {
    displayModal = false;
    handleClick(){

        this.displayModal = true;
    }

    handleCloseModal(){
        this.displayModal = false;
    }
}