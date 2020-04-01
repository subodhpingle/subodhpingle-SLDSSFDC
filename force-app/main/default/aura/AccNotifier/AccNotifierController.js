({
	fireComponentEvent : function(cmp,event) 
    {
		var cmpEvent = cmp.getEvent("cmpAccEvent");	
        cmpEvent.setParams({"AccRecord" : cmp.get("v.newAccount")});
        cmpEvent.fire();
	}
})