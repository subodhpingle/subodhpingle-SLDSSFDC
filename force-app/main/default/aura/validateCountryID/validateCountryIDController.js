//JS CONTROLLER
//js controller
({
   /* doInit : function(component, event, helper) 
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
   */   
    requestCall: function(component, event, helper) 
    {
        //prepare action for update inventory
        var validItem = true;
		var nameField = component.find("myAtt");
        var myAtt = nameField.get("v.value");
        
        if(myAtt && myAtt.trim() !== '') 
        {    
      		component.find("myAtt").set("v.disabled", false);
    	} 
        else 
        {
      		component.find("myAtt").set("v.disabled", false);
    	}
		
		if ($A.util.isEmpty(myAtt))
        {
            validItem = false;
            nameField.set("v.errors", [{message:"Country ID should not be blank !"}]);
        }
		else
		{
			nameField.set("v.errors", null);
			
            //below logic is used for validating country ID by clicking on Validate button
			var updateCall = component.get("c.validateCountryID");
            updateCall.setParams({
            "cid" : component.get("v.myAttribute")
        	});
        
            //configure response handler for this action
            updateCall.setCallback(this, function(response)
            {
                var state = response.getState();
                if(state == "SUCCESS")
                {               
                    var resultsToast = $A.get("e.force:showToast");
                    resultsToast.setParams({
                    "title" : "Sending",
                    "type" : "Success",    
                    "message" : "Country ID has found in Contact."
                    });
                    
                    //Update the UI: closePanel, show toast, refresh page
                    $A.get("e.force:closeQuickAction").fire();
                    resultsToast.fire();
                    $A.get("e.force:refreshView").fire();
            	}     
                else
            	{
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title : 'Error',
                        type  : 'Error',
                        "message": "Something is wrong. Please contact system administrator."
                    });
                    toastEvent.fire();
                    var dismissActionPanel = $A.get("e.force:closeQuickAction");
                    dismissActionPanel.fire();
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
})