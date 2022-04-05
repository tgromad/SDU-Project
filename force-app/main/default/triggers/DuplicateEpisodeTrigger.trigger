trigger DuplicateEpisodeTrigger on Episode__c (before insert, before update) {
    
    if(trigger.isBefore && (trigger.isInsert || trigger.isUpdate)) {
        DuplicateEpisodeHandler.checkDuplicates(Trigger.new);
    }
}