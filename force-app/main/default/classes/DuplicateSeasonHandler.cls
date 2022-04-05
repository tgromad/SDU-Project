public with sharing class DuplicateSeasonHandler {


    public static void checkDuplicates(List<Season__c> seasons) {
 		
        System.debug('###Season__c input : ' + seasons);      
        
        Set<Id> tvSerieIds = new Set<Id>();
        Map<Id,List<String>> mapSeasons = new Map<Id,List<String>>();
        List<Season__c> seasonsInDB = new List<Season__c>();
        
        
        for(Season__c s : seasons) {
            tvSerieIds.add(s.TV_Serie__c);
        }
        System.debug('###TV_Serie_Id from trigger: ' + tvSerieIds);
        

        // takes seasons that tv series id are in input values
        // 
    if(!tvSerieIds.isEmpty()) {

        seasonsInDB = [SELECT Id,Sesaon_Name__c,TV_Serie__c FROM Season__c where TV_Serie__c IN :tvSerieIds];
        System.debug('### seasonsInDB '+seasonsInDB.size());

        // create list for season names
        List<String> SeasonsName = new List<String>();

        if(!seasonsInDB.isEmpty()) {
        System.debug('###Taking seasons from DB');
            for(Id tvId : tvSerieIds) {
                for(Season__c season : seasonsInDB) {
                    if(season.TV_Serie__c == tvId) {
                        SeasonsName.add(season.Sesaon_Name__c);
                        System.debug('### season name '+season.Sesaon_Name__c);
                    	}
                    }
                    System.debug('### seasonsName list '+SeasonsName.size());
                    mapSeasons.put(tvId,SeasonsName.clone());
                    SeasonsName.clear();
                }
        	}
    }
        
        
/* Iterate on seasons by looking if map key(TV_Serie_Id) have same value(Season Name) 
 * The TV_Serie_Id is unique
 * The Map contains the values from database
 * If our Input (seasons) is already in our mapSeassons and the values (Season_Name) are same
 * call Error message
 */
        if(!mapSeasons.keySet().isEmpty()) {
            System.debug('###keySet is not Empty');
        	for(Season__c season : seasons) {
            	if(mapSeasons.get(season.TV_Serie__c).contains(season.Sesaon_Name__c)){
                	System.debug('###season already in this tv serie');
                	season.addError('There is alerady season in same name !'+ mapSeasons.get(season.TV_Serie__c));
                	continue;
            }
        }
       }        
        
        



    }
}