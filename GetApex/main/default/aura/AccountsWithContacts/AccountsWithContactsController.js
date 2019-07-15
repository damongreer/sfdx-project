({
    doInit : function(component, event, helper) {
        var action = component.get("c.getContacts");
        action.setParams({
            "accId":component.get("v.recordId")
        });
        console.log("Record Id: "+ component.get("v.recordId"));
        action.setCallback(this, function(response){
            var state = response.getState();
            if(component.isValid() && state === "SUCCESS") {
                //component.set("v.contacts", response.getReturnValue());
                component.set("v.totalPages", Math.ceil(response.getReturnValue().length/component.get("v.pageSize")));
                component.set("v.currentPage",1);
                console.log("List of Contacts: "+response.getReturnValue());
                component.set("v.allData",response.getReturnValue());
                component.set("v.headers",[{label:"Contact Name", fieldName:"Name", type:"text"},
                                           {label:"Phone", fieldName:"Phone", type:"text"},
                                           {label:"Email", fieldName:"Email", type:"text"},
                                           {label:"Owner", fieldName:"Owner.Name", type:"text"},
                                           {label:"Created Date", fieldName:"CreatedDate", type:"date"}]);
                helper.dataPrep(component);
            } else {
                console.log('Problem getting account, response state: ' + state);
            }
        });
        $A.enqueueAction(action);
    },
    onFirst : function(component, event, helper) {
        component.set("v.currentPage",1);
        helper.dataPrep(component, helper);
    },
    onNext : function(component, event, helper) {        
        var pageNumber = component.get("v.currentPage");
        component.set("v.currentPage", pageNumber+1);
        helper.dataPrep(component, helper);
    },
    onPrev : function(component, event, helper) {        
        var pageNumber = component.get("v.currentPage");
        component.set("v.currentPage", pageNumber-1);
        helper.dataPrep(component, helper);
    },
    onLast : function(component, event, helper){
        var last = component.get("v.totalPages");
        component.set("v.currentPage", last);
        helper.dataPrep(component, helper);
    },
    resize : function(component, event, helper){
        var pageSize = component.find("select1").get("v.value");
        component.set("v.pageSize", pageSize);
        console.log(component.get("v.pageSize"));
        helper.reload(component, event, helper);
    },
})