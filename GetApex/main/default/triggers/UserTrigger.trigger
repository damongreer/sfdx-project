trigger UserTrigger on User (before insert, after insert, before update, after update) {

    if(Trigger.isAfter && Trigger.isInsert){
        UserTriggerHelper.addGroup(Trigger.new);
    }
    else if(Trigger.isBefore && Trigger.isUpdate){
        UserTriggerHelper.deleteGroupMember(Trigger.new);
    }
    else if(Trigger.isAfter && Trigger.isUpdate){
        UserTriggerHelper.addGroup(Trigger.new);
    }
}