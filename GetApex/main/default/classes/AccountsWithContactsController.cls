public class AccountsWithContactsController {
    @AuraEnabled
    public static List<Contact> getContacts(String accId){
        List<Contact> con = [SELECT Id, Name, Phone, Email, Owner.Name, CreatedDate 
                             FROM Contact 
                             WHERE AccountId = :accId 
                             LIMIT 2000];
        system.debug(con);
        return con;
    }
}