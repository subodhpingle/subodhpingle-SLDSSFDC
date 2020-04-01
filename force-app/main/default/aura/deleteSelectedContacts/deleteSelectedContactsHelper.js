({
	getConList : function(component, event) {
		// call apex method for fetch child records list.
        var action = component.get('c.getContacts');
    	action.setCallback(this, function(actionResult){
            var state = actionResult.getState();
            if (state === 'SUCCESS') {
                //set response value in contactsList attribute on component.
                component.set('v.contactsList', actionResult.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    },
    
    deleteSelectedContacts: function(component, event, childRecordsIds){
        //call apex class method
        var action = component.get('c.deleteSelectedCon');
 
        // Pass the all selected child record's Id's and
        // Parent Record id (ID of the currently displaying record[context record]) to apex method. 
        // ### You don’t need to add a recordId attribute to a component yourself.
        // It's automatic created with implements force:hasRecordId interface.###
        action.setParams({ 
            "lstOfContactIds": childRecordsIds
        });
 
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                // This standard 'e.force:refreshView' and 'e.force:showToast' event not work from lightning appliation
                
                // display SUCCESS message
                 var toastEvent = $A.get("e.force:showToast");
          			toastEvent.setParams({
        				"title": "Success!",
        				"message": "Selected record(s) has been deleted successfully."
    				});
                    toastEvent.fire();
              
                // refresh/reload the page view
                $A.get('e.force:refreshView').fire();
                
                // call init function again [clear selected checkboxes]
                this.getConList(component,event);
            }
        });
        $A.enqueueAction(action);
    },
})