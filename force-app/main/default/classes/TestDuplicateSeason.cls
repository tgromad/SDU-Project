@isTest
public class TestDuplicateSeason {
	
    @isTest
    static void testAddSameSeasons() {
        
        TV_Serie__c tvSerie = TestDataFactory.getSimpleTvSerie('serie1','www.google.pl','sfsdfds');
        insert tvSerie;
        List<Season__c> seasons = new List<Season__c>();
        Season__c seasonOne = TestDataFactory.getSimpleSeason('name', tvSerie.Id);
        Season__c seasonTwo = TestDataFactory.getSimpleSeason('name', tvSerie.Id);
      	insert seasonOne;
        
        String errorM = '';
        Boolean isError = false;
        Test.startTest();
        try {
        insert seasonTwo;         
            }
        catch(Exception e){
            errorM = e.getMessage();
            isError = true;
        }
        Test.stopTest();
        System.assertEquals(isError,true);
        System.assertNotEquals('', errorM);
    }
    
    @isTest
    static void addNotSameSeasons(){
        TV_Serie__c tvSerie = TestDataFactory.getSimpleTvSerie('serie1','www.google.pl','sfsdfds');
        insert tvSerie;
        TV_Serie__c tvSerie2 = TestDataFactory.getSimpleTvSerie('test2','www.google.pl','sfsdfds');
        insert tvSerie2;
        List<Season__c> seasons = new List<Season__c>();
        Season__c seasonOne = TestDataFactory.getSimpleSeason('name', tvSerie.Id);
        Season__c seasonTwo = TestDataFactory.getSimpleSeason('name2', tvSerie.Id);
        Season__c seasonThree = TestDataFactory.getSimpleSeason('name', tvSerie2.Id);
        
      	seasons.add(seasonOne);
        seasons.add(seasonTwo);
        insert seasons;  
        
        Test.startTest();
        insert seasonThree;
        Test.stopTest();
        
        List<Season__c> afterTest =  [SELECT Id from Season__c];
        System.assertEquals(3, afterTest.size());   
    }
    
    @isTest
    static void updateInvalidNameInTVSerie(){
        TV_Serie__c tvSerie = TestDataFactory.getSimpleTvSerie('test1','www.google.pl','sfsdfds');
        insert tvSerie;
        List<Season__c> seasons = new List<Season__c>();
        Season__c seasonOne = TestDataFactory.getSimpleSeason('name', tvSerie.Id);
        Season__c seasonTwo = TestDataFactory.getSimpleSeason('name2', tvSerie.Id);
 		insert seasonOne;
        insert seasonTwo;
        
        String errorM = '';
        Boolean isError = false;
        Test.startTest();
        seasonTwo.Sesaon_Name__c = 'name';
        try {
        update seasonTwo;
        }
        catch(Exception e){
            errorM = e.getMessage();
            isError = true;
        }
        Test.stopTest();
        System.assertEquals(isError,true);
        System.assertNotEquals('', errorM);     
    }
    
    @isTest
	static void updateValidNameInTVSerie(){
        TV_Serie__c tvSerie = TestDataFactory.getSimpleTvSerie('test1','www.google.pl','sfsdfds');
        insert tvSerie;
        List<Season__c> seasons = new List<Season__c>();
        Season__c seasonOne = TestDataFactory.getSimpleSeason('name', tvSerie.Id);
        Season__c seasonTwo = TestDataFactory.getSimpleSeason('name1', tvSerie.Id);
 		seasons.add(seasonOne);
        seasons.add(seasonTwo);
        insert seasons;
      
        Test.startTest();
        seasonTwo.Sesaon_Name__c = 'name2';
        update seasonTwo;
        Test.stopTest();
             
        List<Season__c> afterTest =  [SELECT Id from Season__c];
        System.assertEquals(2, afterTest.size());   
    }    
}