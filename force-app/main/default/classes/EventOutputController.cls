public class EventOutputController {
    public Event__c event{get; set;}
    public List <Event_Speaker__c> eventSpeaker{get; set;}

    public EventOutputController(){
        Id currentRecordId = ApexPages.currentPage().getParameters().get('id');
        this.event = [SELECT Id, Name__c, Organizer__r.Name, Location__r.Name, Location__r.Street__c, Location__r.City__c, Location__r.State__c, Location__r.Country__c, Start_Date_Time__c FROM Event__c WHERE Id=:currentRecordId];
        this.eventSpeaker = [SELECT Id,Speaker__c, Speaker__r.Name, Speaker__r.Profile_URL__c, Speaker__r.About_Me__c FROM Event_Speaker__c WHERE Event__c=:currentRecordId];
    }
}