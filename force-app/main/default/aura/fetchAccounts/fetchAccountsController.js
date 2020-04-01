({
	fetchAccounts : function(component, event, helper) {
		var action = component.get("c.fetchAccs");
        action.setParams({
        });	
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.acctList", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
	}
})