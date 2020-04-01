({
     calculate : function(component)
      {
        var v1 = parseInt(component.find("inputOne").get("v.inputOne"));
        var v2 = parseInt(component.find("inputTwo").get("v.inputTwo"));
        var total = (v1 + v2);
        console.log(total);
        component.find("totalValue").set("v.value", total);
        }
})