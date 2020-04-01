({
    handleNext : function(component,event,helper){
        var getselectedStep = component.get("v.selectedStep");
        if(getselectedStep == "step1"){
            component.set("v.selectedStep", "step2");
        }
        else if(getselectedStep == "step2"){
            component.set("v.selectedStep", "step3");
        }
         else if(getselectedStep == "step3"){
            component.set("v.selectedStep", "step4");
        }
    },
     
    handlePrev : function(component,event,helper){
        var getselectedStep = component.get("v.selectedStep");
        if(getselectedStep == "step2"){
            component.set("v.selectedStep", "step1");
        }
        else if(getselectedStep == "step3"){
            component.set("v.selectedStep", "step2");
        }
        else if(getselectedStep == "step4"){
            component.set("v.selectedStep", "step3");
        }
    },
     
    handleFinish : function(component,event,helper){
        alert('Finished...');
        component.set("v.selectedStep", "step1");
    },
     
    selectStep1 : function(component,event,helper){
        component.set("v.selectedStep", "step1");
    },
    selectStep2 : function(component,event,helper){
        component.set("v.selectedStep", "step2");
    },
    selectStep3 : function(component,event,helper){
        component.set("v.selectedStep", "step3");
    },
    selectStep4 : function(component,event,helper){
        component.set("v.selectedStep", "step4");
    },
})