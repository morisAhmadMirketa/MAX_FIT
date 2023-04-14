@isTest
public class AddLogTest {
    @isTest
    static void insertLogTest() {

        String logDetails = 'Test log details';
        String processName = 'Test process';

        Test.startTest();
        AddLog.insertLog(logDetails, processName);
        Test.stopTest();

        List<Error_Log__c> logs = [SELECT Id, Log_Date_Time__c, Log_Details__c, Process_Name__c FROM Error_Log__c];
        System.assertEquals(logDetails, logs[0].Log_Details__c );
        System.assertEquals(processName, logs[0].Process_Name__c);
    }
}