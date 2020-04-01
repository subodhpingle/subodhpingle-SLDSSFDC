({
    doInit: function(component, event, helper) 
    {
        	component.find("contactRecordCreator").getNewRecord(
            "Contact", // objectApiName
            null, // recordTypeId
            false, // skip cache?
            $A.getCallback(function() 
            {
                var rec = component.get("v.newContact");
                var error = component.get("v.newContactError");
                if(error || (rec == null)) 
                {
                    console.log("Error initializing record template: " + error);
                }
                else 
                {
                    console.log("Record template initialized: " + rec.apiName);
                }
            })
        );
         $A.enqueueAction(action);
    },
    
    handleSaveContact: function(component,event,helper)
    {
        if(helper.validateContactForm(component))
        {
            component.set("v.simpleNewContact.AccountId",component.get("v.recordId"));
         	
            // below is the code to retreive the recordTypeID
            var action = component.get("c.getRecTypeId");
            var recordTypeLabel = component.find("selectid").get("v.value");
            action.setParams({
                "recordTypeLabel": recordTypeLabel
            });
			action.setCallback(this, function(res)
            {   
                var state = response.getState();
                if(state === "SUCCESS") 
                {
                	var RecTypeID  = response.getReturnValue();
                    component.find("contactRecordCreator").saveRecord(function(saveResult)
                    {
                        if (saveResult.state == "SUCCESS" || saveResult.state == "DRAFT")
                        {
                            component.set("v.recordTypeId",RecTypeID);
                            // Success! Prepare a toast UI message
                            var resultsToast = $A.get("e.force:showToast");
                            resultsToast.setParams({
                                "title": "Contact Saved",
                                "message": "The new contact was created."
                            });

                            // Update the UI: close panel, show toast, refresh account page
                            $A.get("e.force:closeQuickAction").fire();
                            resultsToast.fire();
    
                            // Reload the view so components not using force:recordData
                            // are updated
                            $A.get("e.force:refreshView").fire();
                		}
                        else if (saveResult.state == "INCOMPLETE")
                        {
                            console.log("User is offline, device doesn't support drafts.");
                        }
                        else if (saveResult.state == "ERROR")
                        {
                            console.log('Problem saving contact, error: ' +
                                         JSON.stringify(saveResult.error));
                        }
                        else 
                        {
                            console.log('Unknown problem, state: ' + saveResult.state +
                                        ', error: ' + JSON.stringify(saveResult.error));
                        }
            		});
                }
        	});
            $A.enqueueAction(action);
     	}
  	},

    handleCancel: function(component, event, helper) {
        $A.get("e.force:closeQuickAction").fire();
    },    
    closeFirstModal: function(component, event, helper){
      // set "isOpen" attribute to false for hide/close model box 
      component.set("v.isFirstModalOpen", false);
   },    
    openFirstModal: function(component, event, helper){
      // set "isOpen" attribute to false for hide/close model box 
      component.set("v.isFirstModalOpen",true);
   },    
    openSecondModal: function(component, event, helper){
      // set "isOpen" attribute to false for hide/close model box 
      component.set("v.isSecondModalOpen",true)
      component.set("v.isFirstModalOpen",false);
   },   
    closeSecondModal: function(component, event, helper){
      // set "isOpen" attribute to false for hide/close model box 
      component.set("v.isSecondModalOpen",false);
   },    
    openThirdModal: function(component, event, helper){
      // set "isOpen" attribute to false for hide/close model box 
      component.set("v.isThirdModalOpen",true);
      component.set("v.isSecondModalOpen",false);
   },
    closeThirdModal: function(component, event, helper){
      // set "isOpen" attribute to false for hide/close model box 
      component.set("v.isThirdModalOpen",false);
   },
})