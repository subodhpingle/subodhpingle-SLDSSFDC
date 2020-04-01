({
	applychanges : function(component, event, helper) {
		var action = component.get("c.getexecute");
        action.setParams({recid:component.get("v.recordId")});
        
        action.setCallback(this, function(response) 
        {                        
            var state = response.getState();
            if(state === 'SUCCESS')
            {
                console.log( response.getReturnValue());
                if(response.getReturnValue()=='success')
                {
                     var toastEvent = $A.get("e.force:showToast");
    			     toastEvent.setParams({
        		     title : 'Submitted',
                     type : 'Success',
                     "message": "Thank you for raising the Ticket, your query has been submitted to the concerned department."
   					  });
  					  toastEvent.fire();
                      $A.get('e.force:	').fire();
                      var dismissActionPanel = $A.get("e.force:closeQuickAction");
                      dismissActionPanel.fire();
                }
                else 
                {
                    component.set("v.show",true);
                    component.set("v.ErrorResult",response.getReturnValue());
                }
             }
            else if(state === 'ERROR'){
                var errors = action.getError();
                /*if (errors) {
                    if (errors[0] && errors[0].message) {
                        alert(errors[0].message);
                    }
                }
                */
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title : 'Cannot Submit for Approval',
                    type : 'error',
                    "message": errors[0].message
                });
                toastEvent.fire();
                var dismissActionPanel = $A.get("e.force:closeQuickAction");
                dismissActionPanel.fire();
            }
            else
            {
                 var toastEvent = $A.get("e.force:showToast");
    			      toastEvent.setParams({
        				title : 'Error ',
                        type : 'Error',
        				"message": "There is some problem please contact system administrator or try again later"
   					  });
  					  toastEvent.fire();
                    var dismissActionPanel = $A.get("e.force:closeQuickAction");
                    dismissActionPanel.fire();
            }
        });
         $A.enqueueAction(action);
	},
     No: function(component, event, helper) {
        var dismissActionPanel = $A.get("e.force:closeQuickAction");
        dismissActionPanel.fire();
         $A.get('e.force:refreshView').fire();
     // component.set("v.isOpen", false);
   },
})