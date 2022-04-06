public with sharing class DuplicateEpisodeHandler {

    public static void checkDuplicates(List<EPisode__c> episodes) {   
        
        Set<Id> SeasonIds = new Set<Id>();
        Map<Id,List<String>> mapEpisodes = new Map<Id,List<String>>();
        List<Episode__c> episodesInDB = new List<Episode__c>();
        
        
        for(Episode__c e : episodes) {
            SeasonIds.add(e.Season__c);
        }
        
        // takes seasons that tv series id are in input values
        // 
        if(!SeasonIds.isEmpty()) {
            episodesInDB = [SELECT Id,Episode_Name__c,Season__c FROM Episode__c where Season__c IN :SeasonIds];

        // create a map where key is a TV_Serie and value is List of series Names
        if(!episodesInDB.isEmpty()) {
            for(Id seasonId : SeasonIds) {
                List<String> SeasonsName = new List<String>();
                for(Episode__c episode : episodesInDB) {
                    if(episode.Season__c == seasonId) {
                        SeasonsName.add(episode.Episode_Name__c);
                    	}
                    }
                    mapEpisodes.put(seasonId,SeasonsName);
                }
        	}
}
        
        
/* Iterate on episodes by looking if map key(Season Id) have same value(Episode Name) 
 * The Season Id is unique
 * The Map contains the values from database
 * If our Input (Episodes) is already in our mapEpisodes and the values (Episode_Name) are same
 * call Error message
 */
        if(!mapEpisodes.keySet().isEmpty()) {
        	for(Episode__c episode : episodes) {
            	if(mapEpisodes.get(episode.Season__c).contains(episode.Episode_Name__c)){
                	episode.addError('There is already an episode of the same name on this season!');
                	continue;
            }
        }
       }        
        
        



    }
}