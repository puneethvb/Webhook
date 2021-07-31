({
	clickCreate : function(component, event, helper) {
        var validExpense = component.find("expenseform").reduce(function(validsofar,inputCmp){
            inputCmp.showHelpMessageIfInvalid();
            return validsofar && inputCmp.get("v.validity").valid;
        },true);
        
        if(validExpense){
            var newExpense = component.get("v.newExpense");
            console.log("Create Expense: "+JSON.stringify(newExpense));
            helper.createExpense(component,newExpense);
        }
		
	}
})