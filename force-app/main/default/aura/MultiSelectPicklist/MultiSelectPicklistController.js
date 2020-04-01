({
    doInit: function(component, event, helper)
    {
        var action = component.get("c.getPiklistValues");
        action.setCallback(this, function(response)
        {
            var state = response.getState();
            if (state === "SUCCESS")
            {
                var result = response.getReturnValue();
                var plValues = [];
                for (var i = 0; i < result.length; i++)
                {
                    plValues.push({
                        label: result[i],
                        value: result[i]
                    });
                }
                component.set("v.GenreList", plValues);
            }
        });
        $A.enqueueAction(action);
    },
     
    handleGenreChange: function (component, event, helper) {
        //Get the Selected values   
        var selectedValues = event.getParam("value");
        
        //Update the Selected Values  
        component.set("v.selectedGenreList", selectedValues);
    },
    
    createExp: function(component, event, helper) {
        var action = component.get("c.updateExpense");
        action.setParams({
        	"inv": component.get("v.exp"),
            "selectedEmployees": component.get("v.selectedGenreList")
        });
        action.setCallback(this, function(response) 
        {
        	var state = response.getState();
            if (state === "SUCCESS")
            {    
                var resultsToast = $A.get("e.force:showToast");
                resultsToast.setParams({
                    "title" : "Success",
                    "type" : "Success",
                    "message" : "Expense created successfully."
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