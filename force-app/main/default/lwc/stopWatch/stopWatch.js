import { LightningElement } from 'lwc';

export default class StopWatch extends LightningElement {
    counter = 0;
    timer = '0';
    
    timerRef;
    actionHandler(event){
        const label = event.target.value;
        console.log(event.target.value);
        if(label === 'start'){
            this.setTimer();
        }
        else if(label === 'stop'){
            window.clearInterval(this.timerRef);
            window.localStorage.removeItem('timerStart');
        }
        else if(label === 'reset'){

            this.counter = 0;
            this.timer = '0';
            window.clearInterval(this.timerRef);
            window.localStorage.removeItem('timerStart');
        }
        
        
    }

    setTimer(){
        this.timerRef = window.setInterval(() => {
            this.counter = this.counter+1;
            const StartTime = new Date ((window.localStorage.getItem('timerStart')|| this.startTimeHandler()));
            console.log('startTime',StartTime);
            const timeInSecs  = new Date().getTime() - StartTime.getTime();
            this.timer = this.constructTimerString(Math.floor(timeInSecs/1000));            
        }, 1000);
    }

    startTimeHandler(){
        console.log('st1');
        const newTime = new Date();
        window.localStorage.setItem('timerStart',newTime);
        return newTime;
    }

    constructTimerString(seconds){
        
        const hr = Math.floor(seconds/3600);
        const min = Math.floor(seconds % 3600/60);
        const sec = Math.floor(seconds % 3600 % 60);

        const hDisp = hr > 0 ? hr +(hr == '1' ? ' hour': ' hours') : '';
        const mDisp = min > 0 ? min +(min == '1' ? ' minute': ' minutes') : '';
        const sDisp = sec > 0 ? sec +(sec == '1' ? ' second': ' seconds') : '';

        return hDisp+mDisp+sDisp;

    }

    connectedCallback(){

        if(window.localStorage.getItem('timerStart')){
            console.log('Yes I am present');
            this.setTimer();
        }

    }
}