@isTest
private class myDataGenerationTests {

    @TestSetup 
    static void loadRecords(){
        List<Account> a = Test.loadData(Account.sobjectType, 'Mock_Data');
    }
    
    @isTest
    static void testInsert(){
        List<Account> acct = [SELECT Id, Name FROM Account];
        system.assert(acct.size() == 15, 'There should be 15 Accounts');
    }
}