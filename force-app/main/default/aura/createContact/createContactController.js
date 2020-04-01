({ 
    createContact: function (component) 
    {   
        var recordId = component.get("v.recordId");
        var action = component.get("c.getAccountEmail");
        action.setParams({
            accID: recordId
        });
        action.setCallback(this, function(response){
            var accPhone = response.getReturnValue();
            var createRecordEvent = $A.get('e.force:createRecord');
            var RecTypeID  = response.getReturnValue();
            if(createRecordEvent){
            createRecordEvent.setParams({
                'entityApiName': 'Contact',
                'defaultFieldValues': {
                'Phone' : accPhone,
                'AccountId': recordId,
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
})