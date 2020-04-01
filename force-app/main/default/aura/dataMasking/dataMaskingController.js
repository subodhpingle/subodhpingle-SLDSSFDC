({
    loadData: function(component, event, helper) {
        //call apex class method
        var action = component.get('c.initMethod');
        action.setCallback(this, function(response) {
            //store state of response
            var state = response.getState();
            if (state === "SUCCESS") {
                //set response value in contactList attribute on component.
                var responseData = response.getReturnValue();
                component.set('v.contactList', responseData);
            }
        });
        $A.enqueueAction(action);
    },
 
    // show data value on mouse hover in table column 
    onMouseOver: function(component, event, helper) {
        // find the current element (column source) by event 
        var eventGetSource = event.getSource();
        // get the field actual value which is store in title, 
        var eventSourceVal = eventGetSource.get("v.title");
        // set the value of column with title on mouse over  
        eventGetSource.set("v.value", eventSourceVal);
    },
 
    // hide data value on mouse out in table column
    onMouseOut: function(component, event, helper) {
        // find the current element (column source) by event 
        var eventGetSource = event.getSource();
        //mask or hide data again on mouse out with ****..
        eventGetSource.set("v.value", '********************');
    },
})