({
    doInit : function(component, event, helper) 
    {
        //get inventory record Id
        var action = component.get("c.getInventory");
        action.setParams({"inventoryId" : component.get("v.recordId")});
 
        //configure action handler
        action.setCallback(this, function(response)
        {
            var state = response.getState();
            if(state === "SUCCESS")
            {
                component.set("v.inventory", response.getReturnValue());                
            }
            else
            {
                console.log('Problem getting inventory, response state : '+state);
            }
        });
        $A.enqueueAction(action);
    },
    
    performSearch: function(component, event, helper) 
    {
        var searchInput = component.find("searchInput");
        var searchValue = searchInput.get("v.value");
        var nameField = component.find("itemname");       
        action.setParams({recordId : searchValue});// setting the parameter to apex class method
       // perform the search and get the results somehow
     },
    
    requestCall: function(component, event, helper) 
    {
        //prepare action for update inventory
        var validItem = true;
		var nameField = component.find("itemname");
        var itemname = nameField.get("v.value");
        
		if ($A.util.isEmpty(itemname))
        {
            validItem = false;
            nameField.set("v.errors", [{message:"Rating cant be blank."}]);
        }
        else 
        {
            alert('inside else');
       		nameField.set("v.errors", null);
            var updateCall = component.get("c.updateInventoryCall");
            alert('inside updateCall');
        	updateCall.setParams({
            "inv" : component.get("v.inventory")
        	});
			alert('inside inv');
            //configure response handler for this action
            updateCall.setCallback(this, function(response)
            {
                alert('inside update call again');
                var state = response.getState();
                if(state === "SUCCESS")
                {    
                	alert('inside state');
                    var resultsToast = $A.get("e.force:showToast");
                    resultsToast.setParams({
                    "title" :   "Requesting",
                    "message" : "Case closed successfully."
                    });
                    
                    //Update the UI: closePanel, show toast, refresh page
                    $A.get("e.force:closeQuickAction").fire();
                    resultsToast.fire();
                    $A.get("e.force:refreshView").fire();
            	}
                else if(state === "ERROR")
                {
                    alert('inside else state');
                    console.log('Problem updating call, response state '+state);
                }
                else
                {
                    console.log('Unknown problem: '+state);
                }
           });
            
            //send the request to updateCall
            $A.enqueueAction(updateCall);
            }
            if(validItem)
            {
                var newItem = component.get("v.newItem");
                console.log("Create item: " + JSON.stringify(newItem));
            }
     },
    cancelCall: function(component, event, helper) 
    {
        $A.get("e.force:closeQuickAction").fire();
    }
})