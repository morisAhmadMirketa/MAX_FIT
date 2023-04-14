trigger EventSpeakerHandler on Event_Speaker__c (before insert, before update) {
    CheckDuplicateEventSpeaker.CheckDuplicateEventSpeaker(Trigger.new);
}