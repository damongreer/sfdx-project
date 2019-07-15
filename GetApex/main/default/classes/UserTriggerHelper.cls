public class UserTriggerHelper {
    
    public static void addGroup(List<User> newList){
        Set<Group> emptyGroup = new Set<Group>();
        List<Group> eGroup = new List<Group>();
        List<User> use = new List<User>();
        Set<String> strings = new Set<String>();
        Set<Group> gr =  new Set<Group>([SELECT Id, Name FROM Group WHERE Name != null]);
        system.debug(gr);
        List<Id> userId = new List<Id>();
        for(User u:newList){
            if(u.Market__c != '--None--'){
                strings.add(u.Market__c);
                userID.add(u.Id);
            }
            System.debug(strings);
            System.debug(userID);
        }
        if(gr.isEmpty()){
            for(String n:strings){
                if(n != '--None--'){
                    Group newGroup = new Group();
                    newGroup.Name =n;
                    newGroup.Type = 'Regular';
                    emptyGroup.add(newGroup);
                }
            }
            if(!emptyGroup.isEmpty()){
                eGroup.addAll(emptyGroup);
                insert eGroup;
                System.debug(eGroup);
                emptyGroup.clear();
                eGroup.clear();
            }
        }
        else{
            for(String markets:strings){
                for(Group groupCheck:gr){
                    for(User u:newList){
                        if(groupCheck.Name==u.Market__c){
                            use.add(u);
                            System.debug(use);
                        }
                    }
                    if(use.isEmpty()){
                        Group g = new Group();
                        g.Name = markets;
                        g.Type = 'Regular';
                        emptyGroup.add(g);
                        use.clear();
                    }
                }
                if(!emptyGroup.isEmpty()){
                    eGroup.addAll(emptyGroup);
                    insert eGroup;
                    System.debug(eGroup);
                    eGroup.clear();
                    emptyGroup.clear();
                }
            }
        }
        List<Group> groups = new List<Group>([SELECT Id, Name FROM Group WHERE Name != null]);
        List<GroupMember> gm = new List<GroupMember>();
        List<User> users = new List<User>([SELECT Id, Market__c 
                                           FROM User 
                                           WHERE Id IN :userId]);
        for(User u:users){
            for(Group gro:groups){
                if(u.Market__c == gro.Name){
                    GroupMember g = new GroupMember();
                    g.UserOrGroupId = u.Id;
                    g.GroupId = gro.Id;
                    gm.add(g);
                }
                else if(u.Market__c == '--None--'){
                    break;
                }
                else{
                    system.debug('Its broken');
                }
            }
        }
        if(!gm.isEmpty()){
            insert gm;
        }    }
    public static void deleteGroupMember(List<User> newList){
        List<GroupMember> gm = new List<GroupMember>([SELECT Id, UserOrGroupId 
                                                      FROM GroupMember 
                                                      WHERE UserOrGroupId IN :newList]);
        delete gm;
    }
    
}