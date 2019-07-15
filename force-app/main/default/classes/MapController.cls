public class MapController {

    @AuraEnabled public static List<Contact> getContact(String recordId){
        List<Contact> conList = new List<Contact>();
        conList = [SELECT Id, Name, Phone, Email, MailingStreet, MailingCity, MailingState, MailingPostalCode 
                   FROM Contact 
                   WHERE Id = :recordId];
        return conList;
    }
}