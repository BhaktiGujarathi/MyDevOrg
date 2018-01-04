@isTest
global class WebServiceLoginCreateImpl implements HttpCalloutMock {
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest req) {
        // Optionally, only send a mock response for a specific endpoint
        // and method.
        //System.assertEquals('https://login.salesforce.com/services/oauth2/token', req.getEndpoint());
        //System.assertEquals('POST', req.getMethod());
        
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"firstName":"rest1", "lastName":"rest2", "email":"rest1@rest2.com", "company":"TCS", "status":"Open - Not Contacted"}');
        //res.setStatusCode(200);
        return res;
    }
}