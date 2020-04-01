({
      // Fetch the accounts from the Apex controller
     getCaseList: function(component) 
     {
     	var action = component.get('c.getCase');
        
     	//Set up the callback
      	var self = this;
     	var recId =  component.get("v.recordId");
      	action.setParams({"caseIdS":recId});
      	action.setCallback(this, function(actionResult) 
      	{
        	var result = actionResult.getReturnValue();
            console.log('response');
            //component.set('v.cases', actionResult.getReturnValue());
           // component.set('v.openCaseCount',result.totalOpenCases);
            
           /* if(result &&  result.Account && result.Account.ReplacementScore__c)
            {
              	component.set('v.replacementScore',result.Account.ReplacementScore__c);
            }
            
            if(result &&  result.Account && result.Account.FOCScore__c)
            {
              	component.set('v.focScore',result.-Account.FOCScore__c);
            }
            
            if(result &&  result.Account && result.Account.DataScore__c)
            {
              	component.set('v.dataScore',result.Account.DataScore__c);
            }
           */ 
        });
        $A.enqueueAction(action);
      }
})