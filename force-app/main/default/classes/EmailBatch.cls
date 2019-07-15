global class EmailBatch implements Database.Batchable<SObject> {
    global Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('SELECT Id, Name, Owner.Email FROM Account WHERE BillingState = null LIMIT 1');
    }
    global void execute(Database.BatchableContext bc, List<Account> scope){
        String email;
        for(Account a:scope){
            email = a.Owner.Email;
        }
    }
    global void finish(Database.BatchableContext bc){
        Messaging.SingleEmailMessage msg = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[]{''};
            msg.setToAddresses(toAddresses);
        msg.setSubject('Damn Daniel');
        msg.setPlainTextBody('');
        
    }
}