({
    parse: function(component, result) {
        var accounts = result.getReturnValue(),
            parents = { undefined: { items: [] }};
        accounts.forEach(account => parents[account.Id] = { items: [], name: account.Id, label: "Account: "+account.Name, expanded: false});
        accounts.forEach(account => { if(account.Contacts) { account.Contacts.forEach(contact => parents[account.Id].items.push({items: [], name: contact.Id, label: "Contact: "+contact.Name, expanded: false}))}});
        accounts.forEach(account => parents[account.ParentId].items.push(parents[account.Id]));
        component.set("v.data", parents[undefined].items);
    }
})