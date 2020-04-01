({
    cancel: function(component, event, helper)
    {
         var navEvt = $A.get("e.force:navigateToSObject");
        navEvt.setParams({
            "recordId": component.get("v.recordId"),
            "isredirect":true
        });
        navEvt.fire();
        
    },
    hideModal : function(component, event, helper) {
        var recordId = component.get("v.recordId"); 
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "message": "Account was saved.",
            "type":"Success"
        });
        toastEvent.fire();
        var navEvt = $A.get("e.force:navigateToSObject");
        navEvt.setParams({
            "recordId": component.get("v.recordId"),
            "isredirect":true
        });
        navEvt.fire();
        $A.get('e.force:refreshView').fire();
    },
    
    save : function(component, event, helper){
        try {
            component.find("edit").get("e.recordSave").fire();
        }
        catch (e) {
            alert(e);
        }
        
    }
})