({
	next : function(component, event, helper) 
    {
		var setid = component.get("v.selTabId");
        if(setid == '1')
        {
            component.set("v.selTabId", '2');
        }
        
        if(setid == '2')
        {
            component.set("v.selTabId", '3');
        }
        
        else if(setid == '3')
        {
            component.set("v.selTabId", '4');
        }
	},
    
    back : function(component, event, helper) 
    {
    	var setid = component.get("v.selTabId");
 	    if(setid == '2')
		{
    		component.set("v.selTabId", '1');
		}
	    if(setid == '3')
		{
    		component.set("v.selTabId", '2');
		}
        if(setid == '4')
		{
    		component.set("v.selTabId", '3');
		}
	}
})