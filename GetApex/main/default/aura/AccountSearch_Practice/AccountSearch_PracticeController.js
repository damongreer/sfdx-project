({
    doInit : function(component, event, helper) {
        var action = component.get("c.getAccounts");
        action.setCallback(this, function(response){
            var result = response.getReturnValue();
            var state = response.getState();
            if(state === "SUCCESS"){
                component.set("v.accList",result);
            }
            else{
                console.log("There was an error: "+state);
            }
        });
        $A.enqueueAction(action);
    },
    search : function(component, event, helper) {
        var searchTerm = component.find("search").get("v.value");
        var action = component.get("c.searchAccounts");
        action.setParams({
            "term":searchTerm
        });
        action.setCallback(this, function(response){
            var result = response.getReturnValue();
            var state = response.getState();
            if(state === "SUCCESS"){
                component.set("v.accList",result);
            }
            else{
                console.log("There was an error: "+state);
            }
        });
        $A.enqueueAction(action);
    },
})