public class FSCController {
    private final FSC__c fsc;
    public FSCController() {
        fsc = [SELECT Payor_Name__c, Plan_Type__c 
                        FROM FSC__c 
                        LIMIT 1];
    }
    public FSC__c getInsuranceInfo(){
        return fsc;
    }
}
