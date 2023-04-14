@isTest
public class EventSpeakerHandlerTest {
    @isTest
    static void eventSpeakerTestMethod(){

        Event__c firstEvent = new Event__c();
        firstEvent.Name__c = 'WWE1';
        firstEvent.Live__c = true;
        firstEvent.Start_Date_Time__c = Datetime.now().addDays(4);
        firstEvent.End_Date_Time__c = Datetime.now().addDays(7);
        insert firstEvent;

        Event__c secondEvent = new Event__c();
        secondEvent.Name__c = 'WWE2'; 
        secondEvent.Live__c = true;
        secondEvent.Start_Date_Time__c = Datetime.now().addDays(3);
        secondEvent.End_Date_Time__c = Datetime.now().addDays(6);
        insert secondEvent;

        Event__c thirdEvent = new Event__c();
        thirdEvent.Name__c = 'WWE3'; 
        thirdEvent.Live__c = true;
        thirdEvent.Start_Date_Time__c = Datetime.now().addDays(1);
        thirdEvent.End_Date_Time__c = Datetime.now().addDays(3);
        insert thirdEvent;

        Speaker__c newSpeaker = new Speaker__c();
        newSpeaker.Name = 'TestSpeaker';
        newSpeaker.Email__c = 'falak27dec@gmail.com';
        insert newSpeaker;

        Event_Speaker__c firstEventSpeaker = new Event_Speaker__c();
        firstEventSpeaker.Event__c = firstEvent.Id;
        firstEventSpeaker.Speaker__c = newSpeaker.Id;
        insert firstEventSpeaker;

        Event_Speaker__c thirdEventSpeaker = new Event_Speaker__c();
        thirdEventSpeaker.Event__c = thirdEvent.Id;
        thirdEventSpeaker.Speaker__c = newSpeaker.Id;
        //insert thirdEventSpeaker;

        Event_Speaker__c secondEventSpeaker = new Event_Speaker__c();
        secondEventSpeaker.Event__c = secondEvent.Id;
        secondEventSpeaker.Speaker__c = newSpeaker.Id;
        //insert secondEventSpeaker;

        Test.startTest();
        try {
            insert secondEventSpeaker; 
            insert thirdEventSpeaker;
            System.assert(false,'Expected an error but none occured means secondEventSpeaker record is insert'); 
        } catch (DmlException e) {
            System.assert(e.getMessage().contains('This speaker is already booked in Event'), 'Unexpected error message: ' + e.getMessage());
        }
        Test.stopTest();

    }
}