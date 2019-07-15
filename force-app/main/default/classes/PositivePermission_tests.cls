@isTest 
private class PositivePermission_tests {

    @isTest
    static void testCustomProfile_Positive(){
        List<Profile> p = [SELECT Id FROM Profile WHERE Name = 'Custom User' LIMIT 1];
        User u = [SELECT Id FROM User WHERE ProfileId IN :p];
        system.runAs(u){
            List<Private_Object__c> privOb = [SELECT Id FROM Private_Object__c];
        }
    }
}