public with sharing class UserPOC {
public static void UserPOC() {
    List<User> userList = new List<User>();
    List<String> userPermissionSet = new List<String>();
    List<PermissionSetAssignment> psaList = new List<PermissionSetAssignment>();
    String permissionString = '';
    userList = [SELECT Id, Name FROM User];
    psaList = [SELECT PermissionSet.Name, Assignee.Id 
                FROM PermissionSetAssignment 
                ORDER BY Assignee.Id];
    system.debug(psaList);
    for(User user:userList){
    for(PermissionSetAssignment psa:psaList){
      if(psa.Assignee.Id == user.Id){
          permissionString = permissionString +', '+psa.PermissionSet.Name;
      }  
    }
        //userPermissionSet.add(permissionString);
        system.debug('Permission Sets Assigned to '+user.Name+': '+permissionString);
        permissionString = '';
    }

}
}