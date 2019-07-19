global class PermissionSetUpdateBatch implements Database.Batchable<sObject>{
    
    global Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('SELECT PermissionSet.Name, Assignee.Id'+'\n'+ 
                                        'FROM PermissionSetAssignment ORDER BY Assignee.Id');
    }
    global void execute(Database.BatchableContext bc, List<PermissionSetAssignment> scope){
        String userId;
        String permissionString = '';
        String aNum = '';
        
        List<PermissionSetChange__c> pscNewList = new List<PermissionSetChange__c>();
        List<PermissionSetChange__c> pscSortedList = new List<PermissionSetChange__c>();
        List<PermissionSetChange__c> pscOldList = new List<PermissionSetChange__c>([SELECT Name, User__c, New_Permission_Sets__c, CreatedDate FROM PermissionSetChange__c ORDER BY User__c, Name DESC]);
        
        for(PermissionSetChange__c pscCheck: pscOldList){
            if(aNum == null){
                aNum = pscCheck.Name;
                //Add logic to get the old permission set value in a collection
                //To use in the new record being created
            }
            else if(aNum == pscCheck.Name){

            }
        }
        for(PermissionSetAssignment psa:scope){
            if(userId == null){
                userId = psa.Assignee.Id;
                permissionString = permissionString +psa.PermissionSet.Name+',';
                break;
            }
            else if(userId == psa.Assignee.Id){
                permissionString = permissionString +psa.PermissionSet.Name+',';
            }
            else if(userId != psa.Assignee.Id){
                PermissionSetChange__c psc = new PermissionSetChange__c();
                psc.User__c = userId;
                psc.New_Permission_Sets__c = permissionString;
                userId = psa.Assignee.Id;
            }
        }
    }
    global void finish(Database.BatchableContext bc){}

}