({
	loadData : function(component, event, helper) {
        var action = component.get("c.initMethod");
        action.setParams({
        });
        action.setParams({
            "accId": component.get("v.recordId")
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.wrapperList", response.getReturnValue());
                console.log(response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    },
    //Select all contacts
    handleSelectAllContacts: function(component, event, helper) {
        var getID = component.get("v.contactList");
        var checkvalue = component.find("selectAll").get("v.value");        
        var checkContact = component.find("checkContact"); 
        if(checkvalue == true){
            for(var i=0; i<checkContact.length; i++){
                checkContact[i].set("v.value",true);
            }
        }
        else{ 
            for(var i=0; i<checkContact.length; i++){
                checkContact[i].set("v.value",false);
            }
        }
    },
    
    //Process the selected contacts
    handleSelectedContacts: function(component, event, helper) {
        var selectedContacts = [];
        var checkvalue = component.find("checkContact");
        if(!Array.isArray(checkvalue)){
            if (checkvalue.get("v.value") == true) {
                selectedContacts.push(checkvalue.get("v.text"));
            }
        }else{
            for (var i = 0; i < checkvalue.length; i++) {
                if (checkvalue[i].get("v.value") == true) {
                    selectedContacts.push(checkvalue[i].get("v.text"));
                }
            }
        }
        console.log('selectedContacts-' + selectedContacts);
        helper.deleteSelectedRecords(component,event,selectedContacts);
    },
})