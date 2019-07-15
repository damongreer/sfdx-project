public class AccountSearch_Practice {
    
    @AuraEnabled public static List<Account> getAccounts(){
        List<Account> accounts = new List<Account>();
        accounts = [SELECT Id, Name, BillingState, BillingPostalCode 
                    FROM Account
                    ORDER BY BillingState, BillingPostalCode DESC];
        return accounts;
        
    }    
    @AuraEnabled public static List<Account> searchAccounts(String term){
        List<Account> accounts = new List<Account>();
        system.debug('Zip: '+term);
        accounts = [SELECT Id, Name, BillingState, BillingPostalCode 
                    FROM Account 
                    WHERE BillingPostalCode = :term];
        return accounts;
        
    }
}