({
    doInit : function(component, event, helper) {
        var action = component.get("c.getAccountRecords");
        action.setCallback(this, function(response) {
            var state = response.getState(); //Checking response status
            console.log("accounts... "+JSON.stringify(response.getReturnValue()));
            if (component.isValid() && state === "SUCCESS")
                component.set("v.accounts", response.getReturnValue());  // Adding values in Aura attribute variable.   
        });
        $A.enqueueAction(action);
    },

    Clicked : function(component, event, helper){
        var ctarget = event.currentTarget;
        var id_str = ctarget.dataset.value;
        console.log(id_str);

        var action = component.get("c.getContactRecords");
        action.setParams({ accId :  id_str});
        action.setCallback(this, function(response) {
            var state = response.getState(); //Checking response status
            console.log("contactsss... "+JSON.stringify(response.getReturnValue()));
            if (component.isValid() && state === "SUCCESS")
                component.set("v.contacts", response.getReturnValue());  // Adding values in Aura attribute variable.   
        });
        $A.enqueueAction(action);
    }
})