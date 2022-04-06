@isTest
public with sharing class TestDuplicateEpisode {

    @isTest
    static void testAddSameEpisodes() {
        
        TV_Serie__c tvSerie = TestDataFactory.getSimpleTvSerie('serie1','www.google.pl','sfsdfds');
        insert tvSerie;
        Season__c seasonOne = TestDataFactory.getSimpleSeason('name', tvSerie.Id);
      	insert seasonOne;
        Episode__c episodeOne = TestDataFactory.getSimpleEpisode('name',seasonOne.Id, 'dfsdf');
        insert episodeOne;
        Episode__c episodeTwo = TestDataFactory.getSimpleEpisode('name',seasonOne.Id, 'dfsdf');
        
        
        Boolean isError = false;
        String errorM = '';
        Test.startTest();
        try {
        insert episodeTwo;  
            }
        catch(DmlException e) {
            errorM = e.getMessage();
			isError = true;            
        }
        Test.stopTest();
        System.assertNotEquals('',errorM);
        System.assertEquals(isError,true);       
    }
    
    @isTest
    static void addNotSameEpisodes() {

        TV_Serie__c tvSerie = TestDataFactory.getSimpleTvSerie('serie1','www.google.pl','sfsdfds');
        insert tvSerie;
        List<Season__c> seasons = new List<Season__c>();
        Season__c seasonOne = TestDataFactory.getSimpleSeason('name', tvSerie.Id);
        Season__c seasonTwo = TestDataFactory.getSimpleSeason('name2', tvSerie.Id);
      	seasons.add(seasonOne);
        seasons.add(seasonTwo);
        insert seasons;  
        Episode__c episodeOne = TestDataFactory.getSimpleEpisode('name',seasonOne.Id, 'dfsdf');
        insert episodeOne;
        Episode__c episodeTwo = TestDataFactory.getSimpleEpisode('name',seasonTwo.Id, 'dfsdf');

        Test.startTest();
        insert episodeTwo;
        Test.stopTest();
        
        List<Episode__c> afterTest =  [SELECT Id from Episode__c];
        System.assertEquals(2, afterTest.size());   
    }
    
    @isTest
    static void updateInvalidNameInEpisode() {

        TV_Serie__c tvSerie = TestDataFactory.getSimpleTvSerie('test1','www.google.pl','sfsdfds');
        insert tvSerie;
        Season__c seasonOne = TestDataFactory.getSimpleSeason('name', tvSerie.Id); 		
        insert seasonOne;

        Episode__c episodeOne = TestDataFactory.getSimpleEpisode('name',seasonOne.Id, 'dfsdf');
        insert episodeOne;
        Episode__c episodeTwo = TestDataFactory.getSimpleEpisode('name2',seasonOne.Id, 'dfsdf');
        insert episodeTwo;
        
        String errorM = '';
        Boolean isError = false;
        
        Test.startTest();
        episodeTwo.Episode_Name__c = 'name';
        try {
        update episodeTwo;
        }
        catch(DmlException e) {
			errorM = e.getMessage();
            isError = true;            
        }
        Test.stopTest();
        System.assertNotEquals('',errorM);
        System.assertEquals(isError,true);
    }
    
    @isTest
	static void updateValidNameInEpisode() {

        TV_Serie__c tvSerie = TestDataFactory.getSimpleTvSerie('test1','www.google.pl','sfsdfds');
        insert tvSerie;
        Season__c seasonOne = TestDataFactory.getSimpleSeason('name', tvSerie.Id);
        insert seasonOne;

        Episode__c episodeOne = TestDataFactory.getSimpleEpisode('name',seasonOne.Id, 'dfsdf');
        insert episodeOne;
        Episode__c episodeTwo = TestDataFactory.getSimpleEpisode('name1',seasonOne.Id, 'dfsdf');
        insert episodeTwo;

      
        Test.startTest();
        episodeTwo.Episode_Name__c = 'name2';
        update episodeTwo;
        Test.stopTest();
             
        List<Episode__c> afterTest =  [SELECT Id from Episode__c];
        System.assertEquals(2, afterTest.size());   
    }    

}