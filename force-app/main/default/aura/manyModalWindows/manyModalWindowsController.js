({
    fetchListOfRecordTypes: function(component, event, helper) 
    {
      var action = component.get("c.fetchRecordTypeValues");
      action.setCallback(this, function(response) 
      {
      	component.set("v.lstOfRecordType",response.getReturnValue());
      });
      $A.enqueueAction(action);
   },
    
   saveContact: function(component,event,helper)
   {
       component.set("v.isFirstModalOpen", true);
       var action = component.get("c.getRecTypeId");
       var recordTypeLabel = component.find("selectid").get("v.value");
       action.setParams({
           "recordTypeLabel": recordTypeLabel
       });
       action.setCallback(this, function(response)
      	{
            var state = response.getState();
            if(state == "SUCCESS") 
         	{
                var recordId = component.get("v.recordId"); 
                var conRecTypeID  = response.getReturnValue();
                alert('conRecTypeID:' +conRecTypeID);
                
                var action2 = component.get("c.createContact");
                action2.setParams({ 
                    "con": component.get("v.conObj"),
                    "recTypeID": conRecTypeID
                });
    			
                action2.setCallback(this, function(a){
           		var state = a.getState();
            	if (state === "SUCCESS")
                {
                	var resultsToast = $A.get("e.force:showToast");
                	resultsToast.setParams({
                        "title" : "Success",
                        "type" : "Success",
                        "message" : "Contact created successfully."
                	});
                    //Update the UI: closePanel, show toast, refresh page
                    $A.get("e.force:closeQuickAction").fire();
                    resultsToast.fire();
                    //$A.get("e.force:refreshView").fire();
            	}
        	});
    		$A.enqueueAction(action2);
   		}
     });
       $A.enqueueAction(action);
       component.set("v.isFirstModalOpen", false);
       component.set("v.isThirdModalOpen", false);
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
      component.set("v.isFirstModalOpen",True);
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