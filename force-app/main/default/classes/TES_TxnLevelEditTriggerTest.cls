@isTest(SeeAllData=false)
public class TES_TxnLevelEditTriggerTest {
    @TestSetup
    static void TES_TxnLevelEditTriggerTestSetup(){
        List<TES_Order__c> TES_OrderTestList = new List<TES_Order__c>();
        List<TES_TxnHeader__c> TES_TxnHeaderTestList = new List<TES_TxnHeader__c>();
        Account AccountTestRecord = new Account();
        String AccountTestId;
        
        //AccountTestRecord = TestDataFactory.dfacCreateAccount(1,'Person Account', 1);
        AccountTestRecord.Name = 'Test Account Record';
        AccountTestRecord.Mrn__c = '100100';
        insert AccountTestRecord;
        
        AccountTestId = [SELECT Id From Account LIMIT 1].Id;
        
        for (Integer i=0;i<5;i++) {
            TES_Order__c TES_OrderTestRecord = new TES_Order__c();
            TES_OrderTestRecord.Account__c = AccountTestId;
            TES_OrderTestRecord.EncounterNumber__c = '100'+i;
            TES_OrderTestList.add(TES_OrderTestRecord);
        }
        insert TES_OrderTestList;
        
        TES_OrderTestList = [SELECT Id FROM TES_Order__c];
        for(Integer j=0;j<5;j++){
            TES_TxnHeader__c TES_TxnHeaderTestRecord = new TES_TxnHeader__c();
            TES_TxnHeaderTestRecord.TES_Order__c = TES_OrderTestList[j].Id;
            TES_TxnHeaderTestRecord.TxnNumber__c = '100'+j;
            TES_TxnHeaderTestList.add(TES_TxnHeaderTestRecord);
        }
        insert TES_TxnHeaderTestList;
        List<TES_TxnLevelEdit__c> TES_TxnLevelEditTestList = new List<TES_TxnLevelEdit__c>();
        for(Integer k=0;k<200;k++){
            TES_TxnLevelEdit__c TES_TxnLevelEditTestRecord = new TES_TxnLevelEdit__c();
            TES_TxnLevelEditTestRecord.Name = 'Test Edit'+k;
            if(k<40){
                TES_TxnLevelEditTestRecord.EncounterNumber__c = '1000';
                TES_TxnLevelEditTestRecord.Transaction_Number__c = '1000';
            }            
            else if(k>=40 && k<80){
                TES_TxnLevelEditTestRecord.EncounterNumber__c = '1001';
                TES_TxnLevelEditTestRecord.Transaction_Number__c = '1001';
            }            
            else if(k>=80 && k<120){
                TES_TxnLevelEditTestRecord.EncounterNumber__c = '1002';
                TES_TxnLevelEditTestRecord.Transaction_Number__c = '1002';
            }            
            else if(k>=120 && k<160){
                TES_TxnLevelEditTestRecord.EncounterNumber__c = '1003';
                TES_TxnLevelEditTestRecord.Transaction_Number__c = '1003';
            }            
            else{
                TES_TxnLevelEditTestRecord.EncounterNumber__c = '1004';
                TES_TxnLevelEditTestRecord.Transaction_Number__c = '1004';
            }
            TES_TxnLevelEditTestList.add(TES_TxnLevelEditTestRecord);
        }
        insert TES_TxnLevelEditTestList;
        
    }
    @isTest
    public static void TES_TxnLevelEditBulkTest() {
        List<TES_TxnLevelEdit__c> TES_TxnLevelEditResultsList = new List<TES_TxnLevelEdit__c>();
        TES_TxnLevelEditResultsList = [SELECT Id FROM TES_TxnLevelEdit__c LIMIT 200];
        system.assertEquals(200,TES_TxnLevelEditResultsList.size());
    }
    @isTest
    public static void TES_TxnLevelEditNullOrderTest(){
        try{
            TES_TxnLevelEdit__c TES_TxnLevelEditNullOrderTestRecord = new TES_TxnLevelEdit__c();
            TES_TxnLevelEditNullOrderTestRecord.Name = 'Nul Order';
            TES_TxnLevelEditNullOrderTestRecord.EncounterNumber__c = '';
            TES_TxnLevelEditNullOrderTestRecord.Transaction_Number__c = '1000';
            insert TES_TxnLevelEditNullOrderTestRecord;
        }
        catch(Exception e){
            Boolean TES_TxnLevelEditOrderIsNull = e.getMessage().contains('TES_Order__c is required for this record.') ? true:false;
            System.assert(TES_TxnLevelEditOrderIsNull);
        }
    }
    @isTest
    public static void TES_TxnLevelEditNullTransactionTest(){
        try{
            TES_TxnLevelEdit__c TES_TxnLevelEditNullTransactionTestRecord = new TES_TxnLevelEdit__c();
            TES_TxnLevelEditNullTransactionTestRecord.Name = 'Null Order';
            TES_TxnLevelEditNullTransactionTestRecord.EncounterNumber__c = '1000';
            TES_TxnLevelEditNullTransactionTestRecord.Transaction_Number__c = '';
            insert TES_TxnLevelEditNullTransactionTestRecord;
        }
        catch(Exception e){
            Boolean TES_TxnLevelEditTransactionIsNull = e.getMessage().contains('The TES_TxnHeader__c is required for this record.') ? true:false;
            System.assert(TES_TxnLevelEditTransactionIsNull);
        }
    }
    @isTest
    public static void TES_TxnLevelEditRestrictedUserTest(){        
        // If you don't use runAs here, you will get a mixed DML exception
        Profile p = [select id from profile where name='Standard User'];
        
        User u = new User(alias = 'standt', 
                          email='standarduser@testorg.com', 
                          emailencodingkey='UTF-8', 
                          lastname='Testing', 
                          languagelocalekey='en_US', 
                          localesidkey='en_US', 
                          profileid = p.Id,
                          timezonesidkey='America/Los_Angeles', 
                          username='standardusertest@myspace.com');
        insert u;
        
        Group g = new Group();
        g.Name = 'Test Group';
        g.DeveloperName = 'TestGroup';
        insert g;
        
        GroupMember gm = new GroupMember();
        gm.GroupId = g.Id;
        gm.UserOrGroupId = u.Id;
        insert gm;
        
        System.runAs(u) {
            try{
                TES_TxnLevelEdit__c TES_TxnLevelEditInvalidPermissionsTestRecord = new TES_TxnLevelEdit__c();
                TES_TxnLevelEditInvalidPermissionsTestRecord.Name = 'Invalid Record';
                TES_TxnLevelEditInvalidPermissionsTestRecord.EncounterNumber__c = '1000';
                TES_TxnLevelEditInvalidPermissionsTestRecord.Transaction_Number__c = '1000';
                insert TES_TxnLevelEditInvalidPermissionsTestRecord;
            }
            catch(Exception e){
                Boolean TES_TxnLevelEditRecordFail = e.getMessage().contains('') ? false:true;
                system.assert(TES_TxnLevelEditRecordFail);
                system.debug('Exception: '+e.getMessage());
            }
        }
    }
}