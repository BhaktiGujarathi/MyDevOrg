/**
 *  Title   : A class for consuming a webservice from other org
 *  Class   : WebServiceLogin
 *  Author  : Bhakti Gujarathi
 *  Created On: 8/24/2015
 */
public class WebServiceLogin
{
    //A login method to login and get token as a response
    public static OauthResponseWrapper loginMethod()
    {
        //setting up all parameters required for calling a method to get token
        String username = 'bhakti.gujrathi@eternussolutions.com';
        String password = 'neetabharat2708';
        String clientId = '3MVG9ZL0ppGP5UrD7I96IetCSpCykrEP37GD_d4PDhrB90zSQH4YIzpraVqqym799bjkiJvgAOYAGxz1CIrAF';
        String clientSecret = '4048653891253505627';
        HttpRequest request = new HttpRequest(); 
        request.setmethod('POST');   
        // setting an endpoint and body for http request
        request.setEndpoint('https://login.salesforce.com/services/oauth2/token'); 
        request.setBody('grant_type=password' +'&client_id=' + clientId +'&client_secret=' + clientSecret + 
                    '&username=' + EncodingUtil.urlEncode(username, 'UTF-8') + '&password=' + EncodingUtil.urlEncode(password, 'UTF-8'));
        Http http = new Http();
        //send a request for getting a token
        HTTPResponse res = http.send(request);   
       
        System.debug('BODY: '+res.getBody());
        System.debug('STATUS:'+res.getStatus());
        System.debug('STATUS_CODE:'+res.getStatusCode());
        //getting a return value of request in an instance of wrapper of response
        OauthResponseWrapper wrapperInstane = (OauthResponseWrapper)JSON.deserialize(res.getBody(),OauthResponseWrapper .class);
        system.debug('############'+wrapperInstane.access_token);
        //return the response in wrapper instance
        return wrapperInstane;
    }
    
    //method to create a new lead instance
    public HttpResponse leadCreate()
    {
        OauthResponseWrapper Instance = webServiceLogin.loginMethod();
        Http httpInstance = new Http();
        HttpRequest HttpRequestInstance = new HttpRequest();
        HttpRequestInstance.setHeader('Authorization','Bearer '+Instance.access_token);
        HttpRequestInstance.setHeader('Content-Type','application/json');
        HttpRequestInstance.setHeader('accept','application/json');
        HttpRequestInstance.setMethod('POST');
        String parameterForCreate = '{"firstName":"rest1", "lastName":"rest2", "email":"rest1@rest2.com", "company":"TCS", "status":"Open - Not Contacted"}';
        HttpRequestInstance.setBody(parameterForCreate);
        HttpRequestInstance.setEndpoint(Instance.instance_url+'/services/apexrest/LeadManipulation');
        //HttpRequestInstance.setHeader('Authorization', 'OAuth '+Instance.access_token);
        HttpResponse responseInstance = httpInstance.send(HttpRequestInstance);
        system.debug('############### Response'+responseInstance.getBody());
        return responseInstance;
    } 
     
    //method to update a existing lead instance
    public HttpResponse leadUpdate()
    {
        OauthResponseWrapper Instance = webServiceLogin.loginMethod();
        Http httpInstance = new Http();
        HttpRequest HttpRequestInstance = new HttpRequest();
        HttpRequestInstance.setHeader('Authorization','Bearer '+Instance.access_token);
        HttpRequestInstance.setHeader('Content-Type','application/json');
        HttpRequestInstance.setHeader('accept','application/json');
        HttpRequestInstance.setEndpoint(Instance.instance_url+'/services/apexrest/LeadManipulation?_HttpMethod=PATCH');
        //HttpRequestInstance.setHeader('X-HTTP-Method-Override','PATCH');
        HttpRequestInstance.setMethod('POST');
        String parameterForUpdate = '{"firstName":"rest1", "lastName":"rest2", "email":"rest2@rest1.com"}';
        HttpRequestInstance.setBody(parameterForUpdate);
        HttpRequestInstance.setHeader('Authorization', 'OAuth '+Instance.access_token);
        
        HttpResponse responseInstance = httpInstance.send(HttpRequestInstance);
        system.debug('############### Response'+responseInstance.getBody());
        
        return responseInstance;
    }
    
    //method to delete an instnace of lead
    public HttpResponse leadDelete()
    {
        OauthResponseWrapper Instance = webServiceLogin.loginMethod();
        Http httpInstance = new Http();
        HttpRequest HttpRequestInstance = new HttpRequest();
        HttpRequestInstance.setHeader('Authorization','Bearer '+Instance.access_token);
        HttpRequestInstance.setHeader('Content-Type','application/json');
        HttpRequestInstance.setHeader('accept','application/json');
        HttpRequestInstance.setEndpoint(Instance.instance_url+'/services/apexrest/LeadManipulation?firstName=rest1&lastName=rest2&email=rest2@rest1.com');
        HttpRequestInstance.setMethod('DELETE');      
        HttpRequestInstance.setHeader('Authorization', 'OAuth '+Instance.access_token);       
        HttpResponse responseInstance = httpInstance.send(HttpRequestInstance);
        system.debug('############### Response'+responseInstance.getBody());
        system.debug('success');
        return responseInstance;
    }
    
    public class OauthResponseWrapper
    {
        public String id{get;set;}
        public String issued_at{get;set;}
        public String instance_url{get;set;}
        public String signature{get;set;}
        public String access_token{get;set;}
    }
}