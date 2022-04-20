public with sharing class TvSerieController {
    
    @AuraEnabled(cacheable=true)
    public static List<TV_Serie__c> getTvSerieList(){

        return [SELECT Id,Name,Year_of_production__c,Rating__c FROM TV_Serie__c];
    }    

}
