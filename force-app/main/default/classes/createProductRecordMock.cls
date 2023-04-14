@isTest
global class createProductRecordMock implements HttpCalloutMock{
    global HTTPResponse respond(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('[{"id": 1, "title": "Test Product", "price": 400, "description": "Perfect Test Product"}]');
        response.setStatusCode(200);
        return response;
    }
}