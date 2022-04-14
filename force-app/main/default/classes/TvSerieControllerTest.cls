@isTest
public class TvSerieControllerTest {
        
    @isTest static void TestDeleteTvSerie() {
        List<Episode__c> episodes = new List<Episode__c>();
        List<Season__c> seasons = new List<Season__c>();
        List<TV_Serie__c> tvSeries = new List<TV_Serie__c>();

        // create tv serie and insert
        TV_Serie__c tv = TestDataFactory.getSimpleTvSerie('xD','https://www.google.pl','Description');
        insert tv;
        //create season and insert
        Season__c season = TestDataFactory.getSimpleSeason('Name',tv.Id);
        seasons.add(season);
        insert seasons;

        Review__c review = TestDataFactory.getSimpleReview(7, tv.Id);
        insert review;
        
        //create episodes and insert
        for(Integer i = 0; i< 100; i++) {
			episodes.add(TestDataFactory.getSimpleEpisode('Name'+i,seasons.get(0).Id, 'desc'));
        }
        insert episodes;
		
        Test.startTest();
 		TvSerieController.deleteTvSeries(tv.Id);
        Test.stopTest();
      	List<TV_Serie__c> testTvSerie = [SELECT Id FROM TV_Serie__c];
      	List<Season__c> testSeason = [SELECT Id FROM Season__c];
        List<Episode__c> testEpisode = [SELECT Id FROM Episode__c];
      	System.assertEquals(0,testTvSerie.size());
     	System.assertEquals(0,testSeason.size());
        System.assertEquals(0,testEpisode.size());

	}
}