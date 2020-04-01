({
	mul : function(component, event, helper) {
        
        var result = component.get("v.a1") * component.get("v.a2");
        component.set("v.result",result);
		
	}
})