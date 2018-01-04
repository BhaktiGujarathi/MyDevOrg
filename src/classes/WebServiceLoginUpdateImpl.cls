@isTest
global class WebServiceLoginUpdateImpl implements HttpCalloutMock {
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest req) {
                       
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"firstName":"rest1", "lastName":"rest2", "email":"rest2@rest1.com"}');
        
        return res;
    }
}