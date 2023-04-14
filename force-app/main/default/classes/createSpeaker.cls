@RestResource(urlMapping='/createSpeaker/*')

global class createSpeaker {

    @HttpPost
    global static String speakerCreation(String name, String email, String phone, String company){
        Speaker__c speaker = new Speaker__c(
            Name = name,
            Email__c = email,
            Phone__c = phone,
            Company__c = company
        );

        try {
            RestResponse res = RestContext.response;
            insert speaker;
            res.statusCode = 200;
            return 'Successful';
        } catch (Exception e) {
            RestResponse res = RestContext.response;
            res.statusCode = 400;
            return 'Insertion Failed';
            
        }


    }        
}