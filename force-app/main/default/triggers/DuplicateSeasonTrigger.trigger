trigger DuplicateSeasonTrigger on Season__c (before insert, before update) {
    
    if(trigger.isBefore && (trigger.isInsert || trigger.isUpdate)) {
        DuplicateSeasonHandler.checkDuplicates(Trigger.new);
    }
}