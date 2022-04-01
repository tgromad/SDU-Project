public with sharing class DuplicateSeasonHandler {


    public static void checkDuplicates(List<Season__c> seasons) {
 		
        System.debug('###Season__c from trigger: ' + seasons);      
        
        List<Id> tvSerieIds = new List<Id>();
        for(Season__c s : seasons) {
            tvSerieIds.add(s.TV_Serie__c);
        }
        System.debug('###TV_Serie_Id from trigger: ' + tvSerieIds);
        
		Map<String,Id> mapSeasons = new Map<String,Id>();
        // takes seasons that tv series id are in input values
        List<Season__c> seasonsInDB = [SELECT Id,Sesaon_Name__c,TV_Serie__c FROM Season__c where TV_Serie__c IN :tvSerieIds];
        
        // create a map where key is a season name and value is tv serie
        if(!seasonsInDB.isEmpty()) {
        System.debug('###Taking seasons from DB');
            for(Season__c season : seasonsInDB) {
            mapSeasons.put(season.Sesaon_Name__c,season.TV_Serie__c);
        	}
        }
        
/* Iterate on seasons by looking if map key(Season_Name) have same value(TV_Serie) 
 * The Name of seasons should be unique in same TV_Serie that's why the Name is a key
 * The Map contains the values from database
 * If our Input (seasons) Name is already in our mapSeassons(key) and the values (TV_Serie Id) are same
 * call Error message
 */
        if(!mapSeasons.keySet().isEmpty()) {
        	for(Season__c season : seasons) {
            	if(mapSeasons.get(season.Sesaon_Name__c) == season.TV_Serie__c){
                	System.debug('###season already in this tv serie');
                	season.addError('There is alerady season in same name !'+ mapSeasons.get(season.Sesaon_Name__c));
                	continue;
            }
        }
       }        
        
        



    }
}