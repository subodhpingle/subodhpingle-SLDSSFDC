({
        getAccountAndContactsRelation : function(cmp) {
            var action = cmp.get("c.getAccountAndContactsRelation");
            action.setCallback(this, function(response){
                var state = response.getState();
                if (state === "SUCCESS") {
                    cmp.set("v.accounts", response.getReturnValue());


         }
        });
        $A.enqueueAction(action);
    },
    helperFun : function(component,event,secId) {
      var acc = component.find(secId);
            for(var cmp in acc) {
            $A.util.toggleClass(acc[cmp], 'slds-show');  
            $A.util.toggleClass(acc[cmp], 'slds-hide');  
       }
    },
})