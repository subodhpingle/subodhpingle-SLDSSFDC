({
    doInit: function(component, event, helper) 
    {
        // Fetch the account list from the Apex controller
        helper.getCaseList(component);
    }
})