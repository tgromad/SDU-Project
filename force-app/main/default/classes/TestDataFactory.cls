@isTest
public with sharing class TestDataFactory {

    public static Episode__c getSimpleEpisode(String name, Id season, String description) {
        Episode__c episode = new Episode__c();
        episode.Episode_Name__c = name;
        episode.Season__c = season;
        episode.Description__c = description;
        return episode;
    }

    public static Review__c getSimpleReview(Integer rating, Id tvserie) {
        Review__c review = new Review__c();
        review.Rating__c = rating;
        review.TV_Serie__c = tvserie;
        return review;
    }

    public static Season__c getSimpleSeason(String name, Id tvserie) {
        Season__c season = new Season__c();
        season.Sesaon_Name__c = name;
        season.TV_Serie__c = tvserie;
        return season;
    }

    public static TV_Serie__c getSimpleTvSerie(String name,String url, String description) {
        TV_Serie__c tvserie = new TV_Serie__c();
        tvserie.Name = name;
        tvserie.Logo_url__c = url;
        tvserie.Description__c = description;
        tvserie.Year_of_production__c = '1999';
        return tvserie;
    }
}