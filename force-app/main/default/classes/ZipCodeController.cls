public class ZipCodeController {
    @AuraEnabled public static List<Account> getAccounts(String recordId){
        List<Account> acc = new List<Account>();
        List<Account> accounts = new List<Account>();
        String state;
        String zip;
        acc = [SELECT Id, Name, BillingState, BillingPostalCode 
               FROM Account 
               WHERE Id = :recordId 
               LIMIT 1]; 
        for(Account a:acc){
            state = a.BillingState;
            zip = a.BillingPostalCode;
        }
        accounts = [SELECT Id, Name 
                    FROM Account 
                    WHERE BillingState = :state 
                    AND BillingPostalCode = :zip 
                    Order By Name DESC];
        return accounts;
    }
}