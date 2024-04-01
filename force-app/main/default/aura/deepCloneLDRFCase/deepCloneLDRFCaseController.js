({
    //deepCloneLDRF method on init event
	deepCloneLDRF : function(component, event, helper) {
		var action = component.get("c.deepCloneLDRFCase");
        action.setParams({ recordId : component.get("v.recordId") });
        action.setCallback(this, function(response) {             
            var state = response.getState();
            if (state === "SUCCESS") {                
                if(response.getReturnValue() == true)
                {
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        "title": "Success!",
                        "message": $A.get("$Label.c.LDRFDeepCloneSuccess"),
                        "type":"success",
                        "mode":"dismissible"
                    });
                    toastEvent.fire();
                    $A.get('e.force:refreshView').fire();
                }
                else
                {
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        "title": "Error!",
                        "message": $A.get("$Label.c.LDRFDeepCloneError"),
                        "type":"error",
                         "mode":"dismissible"
                    });
                    toastEvent.fire();
                }               
            }
            else {
               
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        "title": "Error!",
                        "message": $A.get("$Label.c.LDRFDeepCloneError"),
                        "type":"error",
                         "mode":"dismissible"
                    });
                    toastEvent.fire();
            }
             $A.get("e.force:closeQuickAction").fire();
        });
        $A.enqueueAction(action);
	}
})