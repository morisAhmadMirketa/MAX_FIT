@isTest
public class DeleteOldRecordsTest {
    @TestSetup
    static void setupTest(){
        List<Event__c> eventsToDelete = new List<Event__c>();
        for (Integer i = 0; i < 200; i++) {
            Event__c event = new Event__c();
            event.Name__c = 'Test Event ' + i;
            event.Start_Date_Time__c = Date.today().addMonths(-3);
            event.End_Date_Time__c = Date.today().addMonths(-3).addDays(3);
            event.Live__c = true;
            eventsToDelete.add(event);
        }

        insert eventsToDelete;
    }

    @isTest
    static void eventDeleteBatchTestMethod() {
        Test.startTest();
        DeleteOldRecords batch1 = new DeleteOldRecords();
        Database.executeBatch(batch1);
        Test.stopTest();

        List<Event__c> deletedEventsRecord = [Select Id,Name__c from Event__c];

        System.assertEquals(0, deletedEventsRecord.size(),'All events record which are occur two months before should delete');
    }

}