({
    handleClicknew : function(cmp, event) 
    {
        var attributeValue = cmp.get("v.textNew");
        console.log("current text: " + attributeValue);

        var target = event.getSource();
        cmp.set("v.textNew", target.get("v.value"));
    }

})