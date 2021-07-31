import { LightningElement } from 'lwc';
import retreiveNews from '@salesforce/apex/NewsController.retreiveNews';

export default class NewsComponent extends LightningElement {

    result = [];

    connectedCallback(){

        this.fetchNews();

    }

    fetchNews(){
        retreiveNews()
            .then(response=>{
                console.log(response);
                this.formatResponse(response.articles);
            })
            .catch(error=>{
                console.log(error);
            })
    }

    formatResponse(articles){

        this.result = articles.map((item,index)=>{
            let id = `news_${index+1}`;
            let name = item.source.name;
            let date = new Date(item.publishedAt).toDateString();
            return{...item,id:id,name:name,publishedDate:date};
        })

    }
}

/*
author: "Jonathon Ramsey"
content: "Pictures of thousands of brand new, unsellable Ford F-150s parked in lots in at least three states expressed the semiconductor shortage in real and financial terms. Ford's pain has been especially dr… [+2246 chars]"
description: ""
publishedAt: "2021-07-18T02:31:06Z"
source:
name: "Autoblog"
__proto__: Object
title: "Ford considering shipping incomplete F-150s to dealers - Yahoo! Voices"
url: "https://www.autoblog.com/2021/07/17/unfinished-ford-f150s-might-ship-dealers/"
urlToImage: "https://o.aolcdn.com/images/dims3/GLOB/legacy_thumbnail/1062x597/format/jpg/quality/100/https://s.yimg.com/os/creatr-uploaded-images/2021-07/6ff00a80-e759-11eb-8ff5-5201fea50128"
__proto__: Object
*/