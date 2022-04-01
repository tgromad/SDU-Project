trigger DuplicateSeasonTrigger on Season__c (before insert, before update) {
  
    
    if(trigger.isBefore && (trigger.isInsert || trigger.isUpdate)) {
        System.debug('###Inside Season Trigger');
        DuplicateSeasonHandler.checkDuplicates(Trigger.new);
    }
}