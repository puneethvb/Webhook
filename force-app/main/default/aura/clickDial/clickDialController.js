({
    callMe : function(component, event, helper) {

        var openCtiEvent  = $A.get("e.opencti:clickToDial");
        openCtiEvent.setParams({
            "number" 	: '+919632437373', 
             "recordId"	: '5002h000004dUZG'
    });
    openCtiEvent.fire();

    }
})