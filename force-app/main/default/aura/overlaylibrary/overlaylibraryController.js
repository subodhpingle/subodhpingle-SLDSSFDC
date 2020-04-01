({
init : function(component, event, helper) {
     var modalBody;
    var modalFooter;
    $A.createComponents([
        ["c:loadingrecord",{}]
    ],
                        function(components, status){
                            if (status === "SUCCESS") {
                                modalBody = components[0];
                                component.find('overlayLib').showCustomModal({
                                    header: "Create Contact",
                                    body: modalBody,
                                    showCloseButton: true,
                                    cssClass: "my-modal,my-custom-class,my-other-class",
                                    closeCallback: function() {

                                    }
                                });
                            }
                        }
                       );


    }
})