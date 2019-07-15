({
    /* this javascript method is no longer in use but has some useful code
     * doInit : function(component, event, helper) {
        var action = component.get("c.getAccounts");
        action.setParams({"recordId":component.get("v.recordId")});
        action.setCallback(this, result =>helper.aFewAccounts(component, result));
        $A.enqueueAction(action);
    },*/
    doInit : function(component, event, helper){
        var action = component.get("c.getAllAccounts");
        action.setCallback(this, result =>helper.allAccounts(component, result));
        $A.enqueueAction(action);	  
    },
    handleSelect : function(component, event) {
        var selectedItem = event.getParam('name');
        //var globalId = event.getSource().getGlobalId();
        //console.log("Global Id: "+globalId);
        console.log("Selected Account: "+selectedItem);
        component.set("v.selected",selectedItem);
        //component.set("v.globalId",globalId);
        var navEvt = $A.get("e.force:navigateToSObject");
        navEvt.setParams({
            "recordId": component.get("v.selected"),
            "slideDevName": "detail"
        });
        navEvt.fire();
    },
})