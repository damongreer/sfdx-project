({
    dataPrep : function(component) {
        var data = [];
        var pageNumber = component.get("v.currentPage");
        var pageSize = component.get("v.pageSize");
        var allData = component.get("v.allData");
        var total = component.get("v.totalPages");
        var current = component.get("v.currentPage");
        var x = (pageNumber-1)*pageSize;
        var myDate;
        var convertDate;
        if(pageNumber == 1){
            component.set("v.prevDisable",true);
            component.set("v.firstDisable",true);
        }
        else{
            component.set("v.prevDisable",false);
            component.set("v.firstDisable",false);
        }
        //creating data-table data
        for(; x<(pageNumber)*pageSize; x++){
            if(allData[x]){
                myDate = new Date(allData[x].CreatedDate);
                convertDate = myDate.getMonth()+1+"/"+myDate.getDate()+"/"+myDate.getFullYear();
                console.log("Date conversion: "+convertDate);
                allData[x].CreatedDate = convertDate;
                data.push(allData[x]);
            }
        }
        if(total === current){
            component.set("v.nextDisable",true);
            component.set("v.lastDisable",true);
        }
        else{
            component.set("v.nextDisable",false);
            component.set("v.lastDisable",false);
        }
        component.set("v.contacts", data);
    },
    reload : function(component, event, helper) {
        var action = component.get("c.getContacts");
        action.setParams({
            "accId":component.get("v.recordId")
        });
        console.log("Record Id: "+ component.get("v.recordId"));
        action.setCallback(this, function(response){
            var state = response.getState();
            if(component.isValid() && state === "SUCCESS") {
                let myPage = component.get("v.currentPage");
                console.log("Current page: "+myPage);                
                component.set("v.totalPages", Math.ceil(response.getReturnValue().length/component.get("v.pageSize")));
                let numPages = component.get("v.totalPages");
                console.log("Total pages available: "+numPages);
                if(numPages >= myPage){
                    component.set("v.currentPage",myPage);
                }
                else{
                    component.set("v.currentPage",1);
                }
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
})