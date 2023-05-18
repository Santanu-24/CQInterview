trigger AccountTrigger on Account (before insert,after insert,after update) {
    if(trigger.isInsert && trigger.isAfter){
        AccountTriggerHandler.createdDefaultContact(trigger.new);
    }
    if(trigger.isUpdate && trigger.isAfter){
        AccountTriggerHandler.afterUpdateHandler(trigger.new, trigger.oldmap);
    }
}