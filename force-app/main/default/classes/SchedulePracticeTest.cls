@isTest
public class SchedulePracticeTest {
    
    static testMethod void testMode(){
        Test.startTest();
        
        SchedulePractice s = new SchedulePractice();
        String sc = '0 0 2 * * ?';
        system.schedule('Test', sc, s);
        
        Test.stopTest();
    }
}