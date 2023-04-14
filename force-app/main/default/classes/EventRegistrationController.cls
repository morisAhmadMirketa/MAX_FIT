public class EventRegistrationController {
    public Event_Organizer__c eventOrganizer {get; set;}

    public Location__c eventLocation {get; set;}

    public Event__c event { get;set;}

    public EventRegistrationController(){
        eventOrganizer = new Event_Organizer__c();
        eventLocation = new Location__c();
        event = new Event__c();      
    }

    public void save(){
        //To Save It;
        Savepoint sp = Database.setSavepoint();
        try{
            insert eventOrganizer;
            insert eventLocation;
            event.Organizer__c = eventOrganizer.Id;
            //Event__c is for Event Type
            if(event.Event__c != 'Virtual')
                event.Location__c = eventLocation.Id;
            insert event; 
        }catch(Exception e){
            Database.rollback(sp);
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,e.getMessage()));
            AddLog.insertLog(e.getMessage(), 'Error Message');
        }
 
    }
}