({
	fetchAllAccounts: function(component, event, helper) 
    {
      var action = component.get("c.fetchAllOpportunities");
      action.setCallback(this, function(response) 
      {
          var state = response.getState();
          if(state === "SUCCESS") 
          {
              component.set("v.opportunities", response.getReturnValue());
          }
      });
      $A.enqueueAction(action);
   }
})