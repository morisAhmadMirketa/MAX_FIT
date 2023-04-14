public class AddLog {
    public static void insertLog( String logDetails, String processName) {
        Error_Log__c log = new Error_Log__c();
        log.Log_Date_Time__c = dateTime.now();
        log.Log_Details__c = logDetails;
        log.Process_Name__c = processName;

        insert log;
    }
}