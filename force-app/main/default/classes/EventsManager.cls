@RestResource(urlMapping='/Events/*')
global class EventsManager {

    public class WrapperEvent{
        String name;
        Datetime date_time;
        Integer max_attendee;
        public void set(String name, Datetime date_time, Integer max_attendee){
            this.name = name;
            this.date_time = date_time;
            this.max_attendee = max_attendee;
        }
    }

    public class WrapperEventOrganizer{
        String name;
        String email;
        public void set(String name, String email){
            this.name = name;
            this.email = email;
        }
    }

    public static Map<String, Object> jsonMapMaking(Object eventobject, Object eventOrganiserObject){
        Map<String, Object> jsonMap = new Map<String,Object>();
        jsonMap.put('event_organizer', eventOrganiserObject);
        jsonMap.put('event', eventObject);
        return jsonMap;
    }


    @HttpGet
    global static void getEvents(){
        RestContext.response.addHeader('Content-Type', 'application/json,charset-UTF-8');
        Integer totalEvents = [Select count() from Event__c];

        if(totalEvents <= 50000) {
            List<Event__c> result = [SELECT Id,Name__c,Start_Date_Time__c,End_Date_Time__c,Max_Seats__c,Organizer__r.Name,Organizer__r.Email__c FROM Event__c];

            List<Object> eventDataList = new List<Object>();

            for(Event__c eventDetail : result){
                WrapperEvent eventObject = new WrapperEvent();
                WrapperEventOrganizer eventOrganizerObject = new WrapperEventOrganizer();

                eventObject.set(eventDetail.Name__c,eventDetail.Start_Date_Time__c,(Integer)eventDetail.Max_Seats__c);
                eventOrganizerObject.set(eventDetail.Organizer__r.Name,eventDetail.Organizer__r.Email__c);

                eventDataList.add(EventsManager.jsonMapMaking(eventObject,eventOrganizerObject));
            }

            RestContext.response.responseBody = Blob.valueOf(JSON.serialize(eventDataList));
        }

        else{
            AddLog.insertLog('Object has more than 50K Records','Web Service to get all the events');
        }
    }
}