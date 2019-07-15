@isTest
private class BatchPracticeTest {
    @testSetup
    static void setup(){
        List<SObject> ls = Test.loadData(Case.sobjectType, 'TestCases');
        Database.insert(ls, false);
    }
    
    static testMethod void test(){
        Test.startTest();
        BatchPractice practice = new BatchPractice();
        Id batchId = Database.executeBatch(practice);
        Test.stopTest();
        
        System.assertEquals(49, [SELECT count() FROM Case WHERE Status = 'Closed']);
    }
    
}