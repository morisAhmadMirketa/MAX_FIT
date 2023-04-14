@isTest
private class createProductRecordTest {
    @isTest
    static void recordMockTest(){
        Test.setMock(HttpCalloutMock.class, new createProductRecordMock());
        HttpResponse response = createProductRecords.createRecord();

        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');

        System.assertEquals(200, response.getStatusCode());

        Product2 product = [SELECT id FROM Product2 WHERE Name = 'Test Product'];
        System.assertEquals(product.Name, 'Test Product');

        PriceBook2 pb = [SELECT id FROM PriceBook2 WHERE Name = 'morisahmad-pricebook'];
        System.assertEquals(pb.Name,'morisahmad-pricebook');

        List<PriceBookEntry> pbe = [SELECT Id FROM PriceBookEntry WHERE Pricebook2Id =:pb.Id AND Product2Id =:product.Id];
        System.assertEquals(pbe.size(),1);
    }
}