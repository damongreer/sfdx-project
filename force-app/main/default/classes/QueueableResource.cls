public class QueueableResource {
    public static void updateOwner(List<Resource_Request__c> req){
        List<Group> oldGroup = new List<Group>([SELECT Id, Name FROM Group WHERE Type = 'Queue']);
        List<Group> grou = new List<Group>();
        List<Group> groupCheck = new List<Group>();
        List<Group> testGroup = new List<Group>();
        List<QueuesObject> qsob = new List<QueuesObject>();
        List<Id> i = new List<Id>();
        Set<String> newSet = new Set<String>();
        
        for(Resource_Request__c r:req){
            newSet.add(r.Market__c);
        }
        if(oldGroup.isEmpty()){
            for(String n:newSet){
                Group gr = new Group();
                gr.Name = n;
                gr.Type = 'Queue';
                grou.add(gr);
            }
            insert grou;
            for(Group g:grou){
                i.add(g.Id);
            }
            grou.clear();
        }        
        else{
            testGroup = [SELECT Name FROM Group WHERE Type = 'Queue'];
            for(String n:newSet){
                for(Group gp:testGroup){
                    if(gp.Name == n){
                        groupCheck.add(gp);
                    }
                }
                if(groupCheck.isEmpty()){
                    Group gr = new Group();
                    gr.Name = n;
                    gr.Type = 'Queue';
                    grou.add(gr);
                }
            }
            if(!grou.isEmpty()){
                insert grou;
                for(Group g:grou){
                    i.add(g.Id);
                }
            }
            grou.clear();
        }
        if(!i.isEmpty()){
            for(Group g: [SELECT Id FROM Group WHERE Id IN :i]){
                QueuesObject sob = new QueuesObject();
                sob.QueueId = g.Id;
                sob.SobjectType = 'Resource_Request__c';
                qsob.add(sob);
            }
            System.runAs(new User(Id = userInfo.getUserId())){
                insert qsob;
            }
        }
        List<Resource_Request__c> quest = new List<Resource_Request__c>();
        for(Group g:[SELECT ID, Name FROM Group WHERE Type = 'Queue']){
            for(Resource_Request__c rr:req){
                if(rr.Market__c == g.Name){
                    rr.OwnerId = g.Id;
                }
            }
        }
    }
}