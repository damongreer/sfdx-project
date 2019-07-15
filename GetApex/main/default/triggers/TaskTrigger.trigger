trigger TaskTrigger on Task (after insert) {
    
    if(Trigger.isAfter && Trigger.isInsert){
    	TaskTrigger_Helper.createAccomplishment(Trigger.New);    
    }
}