/*************************************
 * Developed by Damon Greer
 * Email: damon.greerjr@cognizant.com
 * Date: 06/14/2019
 * **********************************/
public class TaskTrigger_Helper {
    public static void createAccomplishment(List<Task> newTasks){
        List<Accomplishment__c> newAccomp = new List<Accomplishment__c>(); //Accomplishments to be inserted
        List<String> bodyContainer = new List<String>(); //Contains unparsed String elements
        List<String> finalBody = new List<String>(); //Contains only the body we are adding to the new record
        String body; //Placeholder for the email body as it comes in
        String subject; //PLaceholder for the email subject as it comes in
        Integer x = 0; //Iteration variable for array elements
        Date d = Date.today(); //Date of accomplishment is the day the trigger is fired
        
        for(Task t:newTasks){
            subject = t.Subject;
            //The if condition is to ensure that tasks 
            //being created aren't being made into records 
            //unless they come from an email
            if(subject.containsIgnoreCase('Email')){
                subject = subject.remove('Email: ');
                body = t.Description;
                //Split the string : and new line
                bodyContainer = body.split(':|\\n');
                
                //iterate through the email output
                for(String n:bodyContainer){
                    //The email body always outputs 2
                    //elements away from its output
                    if(n.containsIgnoreCase('Body')){
                        for(Integer y = x+2;y<bodyContainer.size();y++){
                                finalBody.add(bodyContainer[y]);
                        }
                    }
                    x++;
                }
                //Build the description field for the new record 
                String description;
                for(String n:finalBody){
                    //The beginning check ensures that the data 
                    //is added being that the string starts as null
                    if(description == null){
                        description = n;
                    }
                    //Outlook adds the below signature to its outbound emails
                    //The else if statement basically skips that addition
                    else if(n.containsIgnoreCase('This e-mail and any files transmitted')){}
                    else{
                        description = description +'\n'+ n;
                    }
                }
                //Create the accomplishment
                Accomplishment__c accomp = new Accomplishment__c();
                accomp.Name = subject;
                accomp.Description__c = description;
                accomp.Contact__c = t.WhoId;
                accomp.Date_of_Achievement__c = d;
                newAccomp.add(accomp);
            }
        }
        //Check for empty list in the case that an ordinary task is created
        if(!newAccomp.isEmpty()){
            insert newAccomp;
        }
    }
}