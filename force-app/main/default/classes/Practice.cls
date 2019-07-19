public class Practice {
    public static void newData(){
        /*List<PermissionSetAssignment> psaList = new List<PermissionSetAssignment>();
        List<PermissionSetChange__c> pscList = new List<PermissionSetChange__c>();
        String userId;
        String permissionStringFinal;
        String permissionString = '';
        psaList = [SELECT PermissionSet.Name, Assignee.Id FROM PermissionSetAssignment WHERE PermissionSet.Name != null ORDER BY Assignee.Id];
        for(PermissionSetAssignment psa: psaList){
            if(userId == null){
                userId = psa.Assignee.Id;
                permissionString = permissionString +psa.PermissionSet.Name+',';
                system.debug(userId);
            }
            else if(userId == psa.Assignee.Id){
                permissionString = permissionString +psa.PermissionSet.Name+',';
            }
            else if(userId != psa.Assignee.Id && psa.PermissionSet.Name != null){
                permissionStringFinal = permissionString.removeEnd(',');
                PermissionSetChange__c psc = new PermissionSetChange__c();
                psc.User__c = userId;
                psc.New_Permission_Sets__c = permissionStringFinal;
                userId = psa.Assignee.Id;
                permissionString = '';
                pscList.add(psc);
                system.debug('PS: '+psc);
            }
        }*/
        List<User> userList  = new List<User>();
        List<Number__c> numList = new List<Number__c>();
        userList = [SELECT Id FROM User];
        for(Integer i=0;i<55;i++){
            Number__c num = new Number__c();
            if(i>20 && i<=30){
                num.User__c = userList[21].Id;
            }
            else if(i>30){
                num.User__c = userList[16].Id;
            }
            else{
                num.User__c = userList[i].Id;
            }
            num.tekst__c = 'Some Text';
            numList.add(num);
        }
        insert numList;
    }
}