({
   fetchListOfRecordTypes: function(component, event, helper) 
    {
      var action = component.get("c.fetchRecordTypeValues");
      action.setCallback(this, function(response) 
      {
      	component.set("v.lstOfRecordType", response.getReturnValue());
      });
      $A.enqueueAction(action);
   },
    
   createRecord: function(component, event, helper)
   {
      component.set("v.isOpen", true);
      var action = component.get("c.getRecTypeId");
      var recordTypeLabel = component.find("selectid").get("v.value");
      action.setParams({
         "recordTypeLabel": recordTypeLabel
      });
      action.setCallback(this, function(response){
            var accPhone = response.getReturnValue();
            var createRecordEvent = $A.get('e.force:createRecord');
            var RecTypeID  = response.getReturnValue();
            if(createRecordEvent){
            createRecordEvent.setParams({
                'entityApiName': 'Account',
                'defaultFieldValues': {
                'recordTypeId': RecTypeID
          		}
            });
            createRecordEvent.fire();
        } else {
            /* Create Record Event is not supported */
            alert("Account creation not supported");
        }
        });
        $A.enqueueAction(action);
   },
 
  closeModal: function(component, event, helper) {
      // set "isOpen" attribute to false for hide/close model box 
      component.set("v.isOpen", false);
   },
    
   openModal: function(component, event, helper) {
      // set "isOpen" attribute to true to show model box
      component.set("v.isOpen", true);
   },
})