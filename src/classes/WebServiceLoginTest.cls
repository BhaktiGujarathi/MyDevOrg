@isTest
public class  WebServiceLoginTest{
    @isTest static void testCallout() {
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new WebServiceLoginCreateImpl());
        
        // Call method to test.
        // This causes a fake response to be sent
        // from the class that implements HttpCalloutMock.
        WebServiceLogin webServiceLoginObj = new WebServiceLogin();
        HttpResponse res = webServiceLoginObj.leadCreate();
        
        // Verify response received contains fake values
        String contentType = res.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = res.getBody();
        String expectedValue = '{"firstName":"rest1", "lastName":"rest2", "email":"rest1@rest2.com", "company":"TCS", "status":"Open - Not Contacted"}';
        System.assertEquals(actualValue, expectedValue);
        //System.assertEquals(200, res.getStatusCode());
    }
    
    @isTest static void Updatetest() {
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new WebServiceLoginUpdateImpl ());
        
        // Call method to test.
        // This causes a fake response to be sent
        // from the class that implements HttpCalloutMock.
        WebServiceLogin webServiceLoginObj = new WebServiceLogin();
        HttpResponse res = webServiceLoginObj.leadUpdate();
        
        // Verify response received contains fake values
        String contentType = res.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = res.getBody();
        String expectedValue = '{"firstName":"rest1", "lastName":"rest2", "email":"rest2@rest1.com"}';
        System.assertEquals(actualValue, expectedValue);
        //System.assertEquals(200, res.getStatusCode());
    }
    @isTest static void deletetest() {
        
        Test.setMock(HttpCalloutMock.class, new WebServiceLogindleteImpl ());   
        WebServiceLogin webServiceLoginInstance = new WebServiceLogin();
        HttpResponse response = webServiceLoginInstance.leadDelete();
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');        
        System.assertEquals(200, response.getStatusCode());
    }
}