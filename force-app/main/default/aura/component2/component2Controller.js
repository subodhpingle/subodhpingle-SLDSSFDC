({
	NavigatetoC1 : function(component, event, helper) 
    {
		var evt = $A.get("e.force:navigateToComponent");	
        console.log('evt'+evt);
        console.log('test :'+component.get("v.Text"));
        evt.setParams({
            componentDef: "c:component1"
        });
        evt.fire();
	}
})