public with sharing class TES_TxnLevelEditTriggerHandler {
    public static void TES_TxnLevelEditBeforeInsert(List<TES_TxnLevelEdit__c> TES_TxnLevelEditList) {
            List<TES_Order__c> TES_OrderList = new List<TES_Order__c>();
            List<TES_TxnHeader__c> TES_TxnHeaderList = new List<TES_TxnHeader__c>();
            List<String> EncounterNumberList = new List<String>();
            List<String> TransactionNumberList = new List<String>();

            for(TES_TxnLevelEdit__c TxnLevel:TES_TxnLevelEditList){
                EncounterNumberList.add(TxnLevel.EncounterNumber__c);
                TransactionNumberList.add(TxnLevel.Transaction_Number__c);
            }
            if(!EncounterNumberList.isEmpty()){
                TES_OrderList = [SELECT Id, EncounterNumber__c FROM TES_Order__c];
            }
            if(!TransactionNumberList.isEmpty()){
                TES_TxnHeaderList = [SELECT Id, TxnNumber__c FROM TES_TxnHeader__c];
            }
            for(TES_TxnLevelEdit__c TxnLevel:TES_TxnLevelEditList){
                for(TES_Order__c TesOrder:TES_OrderList){
                    if(TxnLevel.EncounterNumber__c == TesOrder.EncounterNumber__c){
                        TxnLevel.TES_Order__c = TesOrder.Id;
                    }
                }
                if(TxnLevel.TES_Order__c ==  null){
                    TxnLevel.addError('TES_Order__c is required for this record.');
                }
            }
            for(TES_TxnLevelEdit__c TxnLevel:TES_TxnLevelEditList){
                for(TES_TxnHeader__c TxnHeader:TES_TxnHeaderList){
                    if(TxnLevel.Transaction_Number__c == TxnHeader.TxnNumber__c){
                        TxnLevel.TES_TxnHeader__c = TxnHeader.Id;
                    }
                }
                if(TxnLevel.TES_TxnHeader__c == null){
                    TxnLevel.addError('The TES_TxnHeader__c is required for this record.');
                }
            }
    }
}