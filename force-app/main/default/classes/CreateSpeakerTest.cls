@isTest
private class CreateSpeakerTest {
    @isTest
    static void createSpeakerTest(){

        Test.startTest();

        RestContext.request = new RestRequest();
        RestContext.response = new RestResponse();

        String speaker1 = createSpeaker.speakerCreation('Test22', 'test22@gmail.com', '74849321', 'Mirketa');
        String speaker2 = createSpeaker.speakerCreation('Test22', 'test22@gmail.com', '74849321', 'Mirketa');

        List<Speaker__c> currSpeaker = [SELECT Id,Name,Email__c,Phone__c,Company__c FROM Speaker__c WHERE Name = 'Test22'];


        System.assertEquals(1,currSpeaker.size());
        System.assertEquals(400,RestContext.response.statusCode);

        Test.stopTest();
    }
}