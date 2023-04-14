public class CheckDuplicateEventSpeaker {
    public static void CheckDuplicateEventSpeaker(List<Event_Speaker__c> newEventSpeakers) {
        Set<Id> newSpeakerList = new Set<Id>();
        Set<Id> newEventList = new Set<Id>();

        for (Event_Speaker__c eventSpeaker : newEventSpeakers){
            newSpeakerList.add(eventSpeaker.Speaker__c);
            newEventList.add(eventSpeaker.Event__c);
        }

        //To Fetch all Existing Events
        List<Event__c> OldEventsList = [SELECT Id, Name__c, Start_Date_Time__c, End_Date_Time__c FROM Event__c];

        Map<Id, Event__c> oldEventsMap = new Map<Id, Event__c>();
        
        for (Event__c oldEvent : OldEventsList){
            oldEventsMap.put(oldEvent.Id, oldEvent);
        }

        //key -> speaker Id, value -> list of events
        Map<Id, List<Event__c>> speakerToEventsMap = new Map<Id, List<Event__c>>();

        for (Event_Speaker__c eventSpeaker : [SELECT Id, Event__c, Speaker__c, Event__r.Start_Date_Time__c FROM Event_Speaker__c WHERE Speaker__c IN: newSpeakerList ORDER BY Event__r.Start_Date_Time__c]){
            if (speakerToEventsMap.containsKey(eventSpeaker.Speaker__c)){
                speakerToEventsMap.get(eventSpeaker.Speaker__c).add(oldEventsMap.get(eventSpeaker.Event__c));
            }
            else{
                speakerToEventsMap.put(eventSpeaker.Speaker__c, new List<Event__c>{oldEventsMap.get(eventSpeaker.Event__c)});
            }
        }

        for (Event_Speaker__c eventSpeaker : newEventSpeakers){
            if (speakerToEventsMap.containsKey(eventSpeaker.Speaker__c)){
                Event__c eventNow = oldEventsMap.get(eventSpeaker.Event__c);
                List<Event__c> existingEvents = speakerToEventsMap.get(eventSpeaker.Speaker__c);
                integer n = existingEvents.size();

                // Case 1 : Event should go at Start
                if (eventNow.End_Date_Time__c < existingEvents.get(0).Start_Date_Time__c){
                    existingEvents.add(0, eventNow);
                    speakerToEventsMap.get(eventSpeaker.Speaker__c).add(eventNow);
                    continue;
                }

                // Case 2 : Event should go at End
                if (eventNow.Start_Date_Time__c > existingEvents.get(n - 1).End_Date_Time__c){
                    existingEvents.add(eventNow);
                    speakerToEventsMap.get(eventSpeaker.Speaker__c).add(eventNow);
                    continue;
                }

                // Case 3 : Event should go in between
                
                boolean flag = false;

                for (integer i = 1; i < n; i++){
                    if (eventNow.Start_Date_Time__c > existingEvents.get(i - 1).End_Date_Time__c && eventNow.End_Date_Time__c < existingEvents.get(i).Start_Date_Time__c){
                        existingEvents.add(i, eventNow);
                        flag=true;
                    }
                    if (flag) 
                    break;
                }

                // Case 4 : Invalid Event
                if (!flag){
                    eventSpeaker.addError('Speaker is already booked for this time slot.');
                }

                eventSpeaker.addError('Speaker is already booked for this time slot.');
            }
        }

    }
}