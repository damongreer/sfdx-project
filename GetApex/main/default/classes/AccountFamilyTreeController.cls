public class AccountFamilyTreeController {
    @AuraEnabled public static List<Account> getAccounts(String recordId) {
        List<Account> accounts = new List<Account>();
        List<Account> acc = new List<Account>();
        String pId;
        String aId;
        accounts = [SELECT Id, Name, ParentId 
                    FROM Account 
                    WHERE Id = :recordId 
                    LIMIT 1];
        for(Account a:accounts){
            if(a.ParentId != null){
                pId = a.ParentId;
                acc.add(a);
            }
            else{
                acc.add(a);
            }
        }
        accounts.clear();
        if(pId != null){
            accounts = [SELECT Id, Name, ParentId FROM Account WHERE Id =:pId];
            for(Account a:accounts){
                if(a.ParentId != null){
                    a.ParentId = null;
                }
                acc.add(a);
            }
            accounts.clear();
        }
        accounts = [SELECT Id, Name, ParentId FROM Account WHERE ParentId =:recordId];
        acc.addAll(accounts);
        return acc;
    }  
    @AuraEnabled public static List<Account> getAllAccounts() {
        List<Account> accounts = new List<Account>();
        accounts = [SELECT Id, Name, ParentId 
                    FROM Account];
        return accounts;
    }    
}