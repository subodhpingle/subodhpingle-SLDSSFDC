({
    deleteSelectedRecords : function(component,event,selectedContacts) {
        var action1 = component.get("c.deleteSelectedContacts");
        action1.setParams({
        });
        action1.setParams({
            "conListToDelete": selectedContacts
        });
        action1.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                // This standard 'e.force:refreshView' and 'e.force:showToast' event not work from lightning application
                // display SUCCESS message
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Success!",
                    "message": "Selected record(s) has been deleted successfully."
                });
                toastEvent.fire();
                // refresh/reload the page view
                $A.get('e.force:refreshView').fire();            
            }
        });
        $A.enqueueAction(action1);
    }
})