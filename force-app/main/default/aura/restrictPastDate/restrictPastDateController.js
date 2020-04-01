({
    scriptsLoaded : function(component, event, helper) {
        $(document).ready(function()
        { 
          //Restrict past date selection in date picker  
            $("#datepickerId").datepicker({
                beforeShowDay: function(date) 
                {
                    var today = new Date();
                    if(date > today)
                    {
                        return [true];
                    }
                    else
                    {
                        return [false];
                    }	 
                },
            });           
        });
    },
    
    getVal : function(component,event,helper)
    {
        // to get selected date value using jQuery  
        var oDate = $('#datepickerId').val();
        alert(oDate);        
    }  
})