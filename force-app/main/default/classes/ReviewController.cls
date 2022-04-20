public with sharing class ReviewController {
    public String tvSerieId{get;set;}

    @AuraEnabled(cacheable=true)
    public static List<Review__c> getReviewList(String tvSerieId) {
        return [SELECT Id, Rating__c,Comment__c,CreatedDate
                 FROM Review__c WHERE Review__c.TV_Serie__c =: tvserieid];
                 
    }   
}
