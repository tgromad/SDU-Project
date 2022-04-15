public with sharing class addRatingController {

    @AuraEnabled
    public static void insertReview(Integer rate,String comment,TV_Serie__c tvSerie){
        Review__c review = new Review__c();
        review.Rating__c = rate;
        review.Comment__c = comment;
        review.TV_Serie__c = tvSerie;

        try {
            insert review;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}
