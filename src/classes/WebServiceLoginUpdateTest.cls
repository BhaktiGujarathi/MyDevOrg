@isTest
public class  WebServiceLoginUpdateTest{
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
}