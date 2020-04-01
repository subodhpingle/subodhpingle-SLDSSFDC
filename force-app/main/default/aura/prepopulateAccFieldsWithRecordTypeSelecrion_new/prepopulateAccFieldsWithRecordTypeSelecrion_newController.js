({
    
    /* On the component Load this function call the apex class method, 
    * which is return the list of RecordTypes of object 
    * and set it to the lstOfRecordType attribute to display record Type values
    * on ui:inputSelect component. */
    
    fetchListOfRecordTypes: function(component, event, helper) {
        component.set("v.showRecordTypeSelection", true);
        var action = component.get("c.getListOfRecordType");
        action.setCallback(this, function(response) {
            var recordTypeList = response.getReturnValue();
            console.log(recordTypeList);
            component.set("v.lstOfRecordType", recordTypeList);
            if(recordTypeList.length > 0){
                component.set('v.selectedRecordTypeId', recordTypeList[0].Id);
            }
        });
        $A.enqueueAction(action);
    },
    
    changeRecordType : function(component, event, helper){
        var recordTypeId = event.currentTarget.id;
        console.log(recordTypeId);
        component.set('v.selectedRecordTypeId', recordTypeId);
    },
    createRecord: function(component, event, helper) {
        component.set("v.showRecordTypeSelection", true);
		var recordId = component.get('v.recordId');
        var action = component.get("c.getAccountEmail");
        action.setParams({
            "accID": component.get('v.recordId')
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.showRecordTypeSelection", false);
                var res = response.getReturnValue();
                var defaultValues = {
                    'AccountId': recordId,
                    'Phone' : res
                }
                if(res.AccountId != undefined){
                    defaultValues['AccountId'] = res.AccountId;
                }
                var createRecordEvent = $A.get("e.force:createRecord");
                createRecordEvent.setParams({
                    "entityApiName": 'Contact',
                    'recordTypeId': component.get('v.selectedRecordTypeId'),
                    'defaultFieldValues': defaultValues
                });
                createRecordEvent.fire();
            } else if (state == "INCOMPLETE") {
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Oops!",
                    "message": "No Internet Connection"
                });
                toastEvent.fire();
            } else if (state == "ERROR") {
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Error!",
                    "message": "Please contact your administrator"
                });
                toastEvent.fire();
            }
        });
        $A.enqueueAction(action);
    },
    
    closeModal: function(component, event, helper){
        component.set("v.showRecordTypeSelection", false);
    },
})