public class SpeakerRegistrationController {
    public Speaker__c speaker {get; set;}
    public Event_Speaker__c eventSpeaker {get; set;}

    public speakerRegistrationController(){
        Id currentRecordId = ApexPages.currentPage().getParameters().get('id');
        speaker = new Speaker__c();
        eventSpeaker = new Event_Speaker__c();
        if(currentRecordId!=null){
            eventSpeaker.Event__c = currentRecordId;
        }
    }

    public void save(){
        Savepoint sp = Database.setSavepoint();
        try{
            insert speaker;
            eventSpeaker.Speaker__c = speaker.Id;
            insert eventSpeaker;
        }catch(Exception e){
            Database.rollback(sp);
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,e.getMessage()));
            AddLog.insertLog(e.getMessage(), 'Error Message');
        }

    }
}