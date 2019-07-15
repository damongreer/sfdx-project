public with sharing class ContactSearchController {
    @AuraEnabled
    public static List<Contact> searchContacts( String searchTerm ) {
        List<Contact> contacts = new List<Contact>();
        if ( String.isNotBlank( searchTerm ) ) {
            contacts = [SELECT Id, Name, Phone, Email, MailingStreet, MailingCity, MailingState, MailingPostalCode 
                        FROM Contact 
                        WHERE MailingCountry = :searchTerm
                        AND MailingStreet != null
                        LIMIT 10];
        }
        else{
            contacts = [SELECT Id, Name, Phone, Email, MailingStreet, MailingCity, MailingState, MailingPostalCode 
                        FROM Contact
                        WHERE MailingStreet != null
                        LIMIT 10];            
        }
        return contacts;
    }
}