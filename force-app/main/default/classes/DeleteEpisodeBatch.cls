global with sharing class DeleteEpisodeBatch implements Database.Batchable<sObject>,Database.Stateful {
    
   		 List<TV_Serie__c> episodes = new List<TV_Serie__c>();

	    global DeleteEpisodeBatch(List<TV_Serie__c> e) {	
        episodes = e;
    }
	
    global List<TV_Serie__c> start(Database.BatchableContext bc) {
        return episodes;
    }

    global void execute(Database.BatchableContext bc, List<TV_Serie__c> records) {
        List<Season__c> seasons = [SELECT Id from Season__c where TV_Serie__c =:records];
        List<Episode__c> episodes = [SELECT Id from Episode__c where Season__c =:seasons];
        List<Review__c> reviews = [SELECT Id from Review__c WHERE TV_Serie__c =:records];
        delete episodes;
        delete seasons;
        delete reviews;
        delete records;
    }

    global void finish(Database.BatchableContext bc){
    }
}