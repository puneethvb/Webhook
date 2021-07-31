({
	clickCreateItem : function(component, event, helper) {
        var validItem = component.find('itemform').reduce(function(validsofar,inputCmp){
            inputCmp.showHelpMessageIfInvalid();
            return validsofar && inputCmp.get("v.validity").valid;            
        },true);
         
        if(validItem){
            var newItem = component.get("v.newItem"); 
            var theItems = component.get("v.items");
            var itemParsed = JSON.parse(JSON.stringify(newItem));
            theItems.push(itemParsed);
            component.set("v.items",theItems);
            component.set("v.newItem",{'sobjectType': 'Camping_Item__c','Name': '','Quantity__c': 0,
                          'Price__c': 0,'Packed__c': false });
        }
	}
})