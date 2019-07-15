global class BatchPractice implements Database.Batchable<SObject> {
    
    
    global Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('SELECT Id, Status, LastModifiedDate, CreatedDate FROM Case');
    }
    
    global void execute(Database.BatchableContext bc, List<Case> scope){
        List<Case> newCase = new List<Case>();
        Date dt = Date.newInstance(2019, 04, 26);
        for(Case c: scope){
            if(c.LastModifiedDate < dt){
                c.Status = 'Closed';
            }
            newCase.add(c);
        }
        Database.update(newCase, false);
    }
    
    global void finish(Database.BatchableContext bc){
    }
}