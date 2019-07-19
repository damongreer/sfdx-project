public class InsuranceController {
    public final Insurance__c insuranceInfo;
    public InsuranceController() {
        insuranceInfo = [SELECT Payor_Name__c, Insurance_1_Type__c 
                        FROM Insurance__c 
                        WHERE Account__r.Id = :user.Id LIMIT 1];
    }
    public Insurance__c getInsurance(){
        return insuranceInfo;
    }
}
