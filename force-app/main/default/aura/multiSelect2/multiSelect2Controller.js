({   
   scriptsLoaded : function(component, event, helper) 
   {
		console.log('load successfully');      
       // active/call select2 plugin function after load jQuery and select2 plugin successfully    
       $(".select2Class").select2({
           placeholder: "Select Multiple values"
       });
	},
    
    doInit: function(component, event, helper)
    {
       /*On the component load call the fetchPickListVal helper method
         pass the Picklist[multi-select] API name in parameter  
       */ 
        helper.fetchPickListVal(component,'skills__c');
    },
    
    createAccount : function(component,event,helper)
    {
      /*
        when User will click on the "Create Account" button on UI ,
        first we get the selected picklist values by :
        $('[id$=picklist]').select2("val")
        and set it to the objAcc attribute[account type] Skills__c field.
      */   
        var selectedSkills = $('[id$=picklist]').select2("val");
        component.set("v.objAcc.Skills__c",selectedSkills);
      
      // after set the Picklist value get the Current Account Record 
      // and call the "saveAccount" apex method which is save our record  
        var getCurrentAccount = component.get("v.objAcc");       
        var action = component.get("c.saveAccount");
        action.setParams({
             "acc": getCurrentAccount
        });
       
        action.setCallback(this, function(response)
                           {
            if (response.getState() == "SUCCESS") {
             alert('account Save Successfully-->' + JSON.stringify(response.getReturnValue()));   
            }
        });
        $A.enqueueAction(action);
    }
})