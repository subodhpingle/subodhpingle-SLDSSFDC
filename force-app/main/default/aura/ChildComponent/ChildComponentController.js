({
	childComponentEvent : function(component, event, helper) {
		//Get the event using registerEvent name. 
        var cmpEvent = component.getEvent("sampleCmpEvent"); 
        //Set event attribute value
        cmpEvent.setParams({"message" : "Welcome"}); 
        cmpEvent.fire(); 
	}
})