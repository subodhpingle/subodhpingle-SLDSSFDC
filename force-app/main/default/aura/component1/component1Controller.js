({
	NavigatetoC2 : function(component, event, helper) 
    {
		var evt = $A.get("e.force:navigateToComponent");	
        console.log('evt'+evt);
        evt.setParams({
            componentDef: "c:component2",
            componentAttributes: 
            {    
                Text : component.get("v.Txt")
            }
        });
        evt.fire();
	}
})