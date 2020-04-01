({
    init : function(component, event, helper) {
        var action = component.get("c.saveThisLead");
        console.log("init");
        var ldid = component.get("v.leadid");
        console.log(ldid);
        action.setParams({
           "leadid":ldid
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if(component.isValid() && state ==="SUCCESS"){
                component.set("v.lead", response.getReturnValue());
            } else if (state === "ERROR"){
                var errors = action.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        Component.set("v.message", errors[0].message);
                        console.log(errors[0].message);
                    }
                }
             }
            console.log(response.getReturnValue());
        });
        $A.enqueueAction(action);
    },    
})