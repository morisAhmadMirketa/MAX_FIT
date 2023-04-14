public class DeleteOldRecords implements Database.Batchable<sObject>{
    public Database.QueryLocator start(Database.BatchableContext BC){
        String query = 'SELECT Id FROM Event__c WHERE End_Date_Time__c < LAST_N_MONTHS:2 AND Live__c = true';
        return Database.getQueryLocator( query );
    }

    public void execute(Database.BatchableContext BC, list<Event__c> listRecords){
        delete listRecords;
    }

    public void finish(Database.BatchableContext BC){
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(new String[]{'falak27dec@gmail.com'});
        mail.setSubject('execution of the batch has been processed.');
        mail.setPlainTextBody('Deletion Of 2 months Old events has been processed.');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
}