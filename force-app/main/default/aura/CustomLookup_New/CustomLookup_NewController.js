({
	doHandleSearchEvent : function(component, event, helper) {
		var searchParam = event.getParam('searchText');
        var action = component.get('c.getRecordList');
        //alert(searchParam);
        action.setParams({
            ObjectName : component.get('v.objName'),
            sreachText : searchParam,
            fieldInSearch : component.get('v.fieldName')
        });
        if(!searchParam){
            component.set('v.recordList', null);
            return;
        }
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === 'SUCCESS' || state ==='DRAFT'){
                var responseValue = response.getReturnValue();
                for(let i=0; i<responseValue.length; i++){
                    responseValue[i].Name = responseValue[i][component.get('v.fieldName')]
                }
                console.log('responseValue ', responseValue);
                component.set('v.recordList', responseValue);
            }
        });
        $A.enqueueAction(action);
	},
    doHandleSelectEvent : function(component, event, helper) {
        var record = event.getParam('record');
        console.log('record ', record);
        component.set('v.selectedRecordList', record);
        var fieldAPIName = component.get('v.fieldName');
        //alert(record[fieldAPIName]);
        //component.set('v.recordValue', record[fieldAPIName]);
        //component.set('v.recordList', null);
    },
    handleRemove: function(component, event, helper){
        event.preventDefault();
        component.set('v.selecteRecord', null);
        component.set('v.recordValue', null);
    },
    
    createExp: function(component, event, helper)
    {
        var action = component.get("c.updateExpense");
        action.setParams({
        	"inv": component.get("v.exp")
        });
        alert(+action);
        action.setCallback(this, function(response) 
        {
        	var state = response.getState();
            if (state === "SUCCESS")
            {   
                alert(+state); 
                var resultsToast = $A.get("e.force:showToast");
                resultsToast.setParams({
                    "title" : "Success",
                    "type" : "Success",
                    "message" : "Account created successfully."
                });
                
            	//Update the UI: closePanel, show toast, refresh page
                $A.get("e.force:closeQuickAction").fire();
                resultsToast.fire();
                $A.get("e.force:refreshView").fire();
            }
            else if(state === "ERROR")
            {
            	console.log('Problem updating call, response state '+state);
            }
            else
            {
            	console.log('Unknown problem: '+state);
            }
        });
        $A.enqueueAction(action);
    }
})