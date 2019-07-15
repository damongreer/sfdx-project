({  
    allAccounts : function(component, result){
        var accounts = result.getReturnValue();
        var parents = { undefined: { items: [] }};
        accounts.forEach(account => parents[account.Id] = { items: [], name: account.Id, label: account.Name, expanded: false});
        accounts.forEach(account => parents[account.ParentId].items.push(parents[account.Id]));
        component.set("v.accts", parents[undefined].items);
        console.log("Accounts: "+JSON.stringify(component.get("v.accts")));
    },
})