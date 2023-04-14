@IsTest
private class EventManagerTest {

    @TestSetup
    static void createData(){

        Event_Organizer__c organizer = new Event_Organizer__c (
            Name = 'Test Name',
            Email__c = 'test@gmail.com'
        );

        insert organizer;

        Event__c event = new Event__c(
            Name__c = 'Test1',
            Start_Date_Time__c = Datetime.newInstance(2023, 5, 7, 12, 00, 00),
            Max_Seats__c = 10,
            Organizer__c = organizer.Id
        );

        insert event;
    }

    @IsTest
    static void eventManagerTest(){
        Test.startTest();
        RestContext.response = new RestResponse();
        EventsManager.getEvents();

        List<Object> results = (List<Object>) JSON.deserializeUntyped(RestContext.response.responseBody.toString());
        Map<string, object> resultDataMap = (Map<string, object>) results[0];
        Map<string,Object> eventDataMap = (Map<string,Object>) resultDataMap.get('event');

        System.assertEquals('Test1', String.valueOf(eventDataMap.get('name')));

        Test.stopTest();
    }
}