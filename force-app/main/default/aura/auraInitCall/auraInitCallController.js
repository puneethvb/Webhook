({
    doInit : function(component, event, helper) {

        var action = component.get("c.listOfSobjects");
        console.log('I am here');
        action.setParams({count:10,abc:'qq'});
        action.setCallback(this,function(response){
            console.log('response :',response);
            if(response.state === 'SUCCESS'){
                let val = response.getReturnValue();
                console.log(val);
                let s = 'Ytetsts';
                component.set('v.String1',s);
            }
        });

        $A.enqueueAction(action);

    }
})