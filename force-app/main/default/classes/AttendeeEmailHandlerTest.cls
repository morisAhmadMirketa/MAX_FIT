@isTest
public class AttendeeEmailHandlerTest {
    @isTest
    static void sendConfirmationMailTest(){
        Event_Organizer__c organizer = new Event_Organizer__c();
        organizer.Name = 'Test Organizer';
        insert organizer;

        Location__c location = new Location__c();
        location.Name = 'Test Location';
        insert location;

        Event__c event = new Event__c();
        event.Name__c = 'Test Event';
        event.Organizer__c = organizer.Id;
        event.Location__c = location.Id;
        event.Start_Date_Time__c = Datetime.now();
        event.End_Date_Time__c = Datetime.now().addDays(3);
        event.Max_Seats__c = 20;
        event.Live__c = true;
        insert event;

        Attendees__c attendee = new Attendees__c();
        attendee.Name = 'Test Attendee';
        attendee.Email__c = 'falak27dec@gmail.com';
        insert attendee;

        Event_Attendee__c eventAttendee = new Event_Attendee__c();
        eventAttendee.Attendee__c = attendee.Id;
        eventAttendee.Event__c = event.Id;
        insert eventAttendee;

        List<Event_Attendee__c> eventAttendeeList = [SELECT Id, Attendee__c, Event__c FROM Event_Attendee__c WHERE Id =: eventAttendee.Id];

        Test.startTest();
        AttendeeEmailHandler.sendConfirmationMail(eventAttendeeList);
        Test.stopTest();

        Integer invoice=Limits.getEmailInvocations();
        System.assertEquals(1,invoice,'Only one email is send');
    } 
}