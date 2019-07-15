/* Written by Damon Greer
 * 4/25/19
 * Errors fixed from what we discussed
 * Error is thrown on the record being duplicated
 * */
public class ClassroomTriggerHelper {
    public static void insertTrigger(List<Classroom__c> newList){
        List<Classroom__c> cl = new List<Classroom__c>([SELECT Id, Name, Grade__c, Department__c, Sub_Department__c 
                                                        FROM Classroom__c]);
        List<Classroom__c> classroom = new List<Classroom__c>();
        for(Classroom__c c: cl){
            for(Classroom__c cs: newList){
                if(c.Grade__c == cs.Grade__c){
                    if(c.Student__c == cs.Student__c && c.Department__c == cs.Department__c && c.Sub_Department__c == cs.Sub_Department__c){
                        cs.addError('This student is already taking these courses');
                    }
                    else{
                        classroom.add(cs);
                    }
                }
            }
        }
    }
    public static void updateTrigger(List<Classroom__c> newList){
        List<Classroom__c> cl = new List<Classroom__c>([SELECT Id, Name, Grade__c, Department__c, Sub_Department__c 
                                                        FROM Classroom__c]);
        List<Classroom__c> classroom = new List<Classroom__c>();
        for(Classroom__c cs: newList){
            if(!cl.contains(cs)){
                classroom.add(cs);
            }
            
        }
    }
}