({
    init: function(component, event, helper) {
        var action = component.get("c.getRecords");
        action.setCallback(this, result => helper.parse(component, result));
        $A.enqueueAction(action);
    }
})