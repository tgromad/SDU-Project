@isTest
public class TestDuplicateSeason {
	
    @isTest
    static void testAddSameSeasons() {
        
        TV_Serie__c tvSerie = TestDataFactory.getSimpleTvSerie('www.google.pl','sfsdfds');
        insert tvSerie;
        List<Season__c> seasons = new List<Season__c>();
        Season__c seasonOne = TestDataFactory.getSimpleSeason('name', tvSerie.Id);
        Season__c seasonTwo = TestDataFactory.getSimpleSeason('name', tvSerie.Id);
      	insert seasonOne;
        
        String errorM = '';
        Test.startTest();
        try {
        insert seasonTwo;         
            }
        catch(Exception e){
            errorM = e.getMessage();
        }
        Test.stopTest();
        System.assertNotEquals('', errorM);
    }
    
    @isTest
    static void addNotSameSeasons(){
        TV_Serie__c tvSerie = TestDataFactory.getSimpleTvSerie('www.google.pl','sfsdfds');
        insert tvSerie;
        List<Season__c> seasons = new List<Season__c>();
        Season__c seasonOne = TestDataFactory.getSimpleSeason('name', tvSerie.Id);
        Season__c seasonTwo = TestDataFactory.getSimpleSeason('name2', tvSerie.Id);
      	seasons.add(seasonOne);
        seasons.add(seasonTwo);
        
        Test.startTest();
        insert seasons;    
        Test.stopTest();
        
        List<Season__c> afterTest =  [SELECT Id from Season__c];
        System.assertEquals(2, afterTest.size());   
    }
    
    @isTest
    static void updateInvalidNameInTVSerie(){
                TV_Serie__c tvSerie = TestDataFactory.getSimpleTvSerie('www.google.pl','sfsdfds');
        insert tvSerie;
        List<Season__c> seasons = new List<Season__c>();
        Season__c seasonOne = TestDataFactory.getSimpleSeason('name', tvSerie.Id);
        Season__c seasonTwo = TestDataFactory.getSimpleSeason('name2', tvSerie.Id);
 		insert seasonOne;
        insert seasonTwo;
        
        String errorM = '';
        Test.startTest();
        seasonTwo.Sesaon_Name__c = 'name';
        try {
        update seasonTwo;
        }
        catch(Exception e){
            errorM = e.getMessage();
        }
        Test.stopTest();
        System.assertNotEquals('', errorM);     
    }
static void updateValidNameInTVSerie(){
                TV_Serie__c tvSerie = TestDataFactory.getSimpleTvSerie('www.google.pl','sfsdfds');
        insert tvSerie;
        List<Season__c> seasons = new List<Season__c>();
        Season__c seasonOne = TestDataFactory.getSimpleSeason('name', tvSerie.Id);
        Season__c seasonTwo = TestDataFactory.getSimpleSeason('name1', tvSerie.Id);
 		insert seasonOne;
    
        Test.startTest();
        seasonTwo.Sesaon_Name__c = 'name2';
        update seasonTwo;
        Test.stopTest();
             
        List<Season__c> afterTest =  [SELECT Id from Season__c];
        System.assertEquals(2, afterTest.size());   
    }    
}