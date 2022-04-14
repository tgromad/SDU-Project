public class TvSerieController {    
    
    @AuraEnabled
    public static void deleteTvSeries(String tvSerieId){
        
        List<TV_Serie__c> tvSerie = [SELECT Id from TV_Serie__c where Id =: tvSerieId];
        
        DeleteEpisodeBatch bc = new DeleteEpisodeBatch(tvSerie);
		database.executeBatch(bc);

    }

}