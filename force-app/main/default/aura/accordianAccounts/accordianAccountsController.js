({
    doInit : function(component, event, helper) {
        helper.getAccountAndContactsRelation(component);
    },

    sectionOne : function(component, event, helper) {
       helper.helperFun(component,event,'articleOne');
    }
})