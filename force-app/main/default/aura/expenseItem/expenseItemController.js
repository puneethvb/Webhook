({
    doInit : function(component, event, helper) {
        var myDate = component.get("v.expense.Date__c");
        if(myDate){
            component.set("v.formatdate", new Date(myDate));
        }
    },
})