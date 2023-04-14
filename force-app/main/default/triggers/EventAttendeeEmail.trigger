trigger EventAttendeeEmail on Event_Attendee__c (after insert){
    AttendeeEmailHandler.sendConfirmationMail(Trigger.new);
}