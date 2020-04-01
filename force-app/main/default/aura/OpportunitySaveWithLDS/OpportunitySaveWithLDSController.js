({
    
    doInit: function(component, event, helper) {
        // Prepare a new record from template
        component.find("opprecord").getNewRecord(
            "Opportunity", // sObject type (entityAPIName)
            null,      // recordTypeId
            false,     // skip cache?
            $A.getCallback(function() {
                var rec = component.get("v.opportunity");
                var error = component.get("v.recordSaveError");
                if(error || (rec === null)) {
                    console.log("Error initializing record template: " + error);
                }
                else {
                    console.log("Record template initialized: " + rec.apiName);
                }
            })
        );
    },
    
	handleSaveOpportunity : function(component, event, helper) {
        alert('inside handleSaveOpportunity');
        if(helper.validateContactForm(component)) {
        component.set("v.opportunityRecord.AccountId", component.get("v.recordId"));
            component.find("opprecord").saveRecord(function(saveResult) {
                alert('inside record' );
                if (saveResult.state == "SUCCESS" || saveResult.state == "DRAFT") {
                    alert('inside SUCCESS' );
                    // record is saved successfully
                    var resultsToast = $A.get("e.force:showToast");
                    resultsToast.setParams({
                        "title": "Saved",
                        "message": "The opportunity record was saved."
                    });
                    resultsToast.fire();
                } else if (saveResult.state == "INCOMPLETE") {
                    alert('inside INCOMPLETE' );
                    // handle the incomplete state
                    console.log("User is offline, device doesn't support drafts.");
                } else if (saveResult.state == "ERROR") {
                    alert('inside ERROR' );
                    // handle the error state
                    console.log('Problem saving contact, error: ' + 
                                 JSON.stringify(saveResult.error));
                } else {
                    alert('inside else' );
                    console.log('Unknown problem, state: ' + saveResult.state +
                                ', error: ' + JSON.stringify(saveResult.error));
                }
            });
	}
    }
})