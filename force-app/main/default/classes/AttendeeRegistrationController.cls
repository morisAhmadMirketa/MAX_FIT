public class AttendeeRegistrationController {
    public Attendees__c attendee {get; set;}
    public Event_Attendee__c eventAttendee {get; set;}
    public Location__c location {get; set;}

    public AttendeeRegistrationController(){
        Id currentRecordId = ApexPages.currentPage().getParameters().get('id');
        attendee = new Attendees__c();
        eventAttendee = new Event_Attendee__c();
        location = new Location__c();
        if(currentRecordId!=null){
            eventAttendee.Event__c = currentRecordId;
        }
    }

    public void save(){
        Savepoint sp = Database.setSavepoint();
        try{
            insert location;
            attendee.Address__c = location.Id;
            insert attendee;
            eventAttendee.Attendee__c = attendee.Id;
            insert eventAttendee;
        }catch(Exception e){
            Database.rollback(sp);
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,e.getMessage()));
            AddLog.insertLog(e.getMessage(), 'Error Message');
        }
    }
}