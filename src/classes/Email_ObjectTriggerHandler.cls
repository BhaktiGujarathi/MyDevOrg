/***************************************************************************************************
 *  Title   : Handler Class to handle the functionality of trigger on Email object
 *  Class   : Email_ObjectTriggerHandler
 *  Author  : Bhakti Gujarathi
***************************************************************************************************/

public with sharing class Email_ObjectTriggerHandler {
    public static String stringBody;
    //method to be called from trigger
    public static void temp(List<Email_Object__c> emailList) {
        //List<Query__c> queryList = new List<Query__c>();
        //iterate over the list of email passed from trigger
       
        for(Email_Object__c emailInstance : emailList) {
            String stringToQuery;
            stringToQuery = emailInstance.Body_Of_Email__c;
            //get proper query string from email body
            stringToQuery = stringToQuery.substringBeforeLast(']');
            stringToQuery = stringToQuery.substringAfter('[Query->');
            stringToQuery = stringToQuery.trim();
            //make a callout to webservice
            callToGoogle(stringToQuery);
        }
    }
    
    //anotation required to make a webservice callout
     @future (callout=true)
     //method for callout
    public static void callToGoogle(String queryString) {
        String strLink;
        //instance of http request
        HttpRequest req = new HttpRequest();
        //set URL endpoint
        req.setEndpoint('https://www.google.com/search?q='+EncodingUtil.UrlEncode(queryString,'UTF-8'));
        String query = req.getEndpoint();
        //set mthod of callout
        req.setMethod('GET');
        req.setHeader('Charset', 'UTF-8');
        req.setHeader('Content-Type', 'application/xml');
        Http http = new Http();
        //instance of http response 
        HttpResponse responseHolder = http.send(req);
        stringBody = responseHolder.getBody();  //get body of response in str variable 
             List<Query__c> queryToResponseInstance = [SELECT Id, Query_Text__c, Name
                                                       FROM Query__c
                                                       WHERE Query_Text__c =:queryString];  
                                                       //get the querystring id from org

             Set<String> responseLinkSet = new Set<String>();   
             List<Response_Item__c> reponsesList = new  List<Response_Item__c>();
             List<Response_Item__c> nonDuplicateResponses = new List<Response_Item__c>();
             
             //fetch all the related responses for that query 
             List<Response_Item__c> responseItemToAddList = [SELECT Response_Link__c, 
                                                                    Response_Title__c, 
                                                                    Response_Description__c, 
                                                                    For_Query__c, 
                                                                    For_Query__r.Name
                                                             FROM Response_Item__c
                                                             Where For_Query__r.Name =: 
                                                                  queryToResponseInstance[0].Name];
            
             
             //for all the responses add their links to a set
             for(Response_Item__c responseIterator : responseItemToAddList) {
                 responseLinkSet.add(responseIterator.Response_Link__c.trim());
             }
             
             List<String> strList = stringBody.split('</div></li>');
             strList.remove(0);
             strList.remove(strList.size()-1);
             for(String stringIterator: strList) {
                //manipulate the response of http request
                stringIterator = stringIterator.replace('href="/url?q=', 'link[');
                stringIterator = stringIterator.replace('&amp', ']link');
                strLink = stringIterator.substringbetween('link[',']link');
                stringIterator = stringIterator.replace('<cite>','topic[');
                stringIterator = stringIterator.replace('</cite>','desc[');
                stringIterator = stringIterator.replace('Cached',' ');
                stringIterator = stringIterator.striphtmltags();
                String strtopic = stringIterator.substringbefore('topic[');
                if(strtopic.contains('YouTube ► ')) {
                    strtopic = strtopic.substringbefore('YouTube ► ');
                }
                String strDesc = stringIterator.substringafter('desc[');
                strDesc = strDesc.replace('desc[','');
                strDesc = strDesc.replace(']link','');

                if(!strLink.startsWithIgnoreCase('/settings/ads/preferences')) {
                //if respomset do exists
                    if(responseLinkSet.size() <> 0) {
                        //check if linkset contains the link
                        if(!responseLinkSet.contains(strLink.trim())) {
                            //create a new instance of response
                            Response_Item__c tempResponse = new Response_Item__c(
                                                                 For_Query__c = queryToResponseInstance[0].Id, 
                                                                 Response_Title__c = strtopic, 
                                                                 Response_Link__c = strLink, 
                                                                 Response_Description__c = strDesc);
                            nonDuplicateResponses.add(tempResponse);
                        }
                    } 
                    else {
                         Response_Item__c tempResponse = new Response_Item__c(
                                                            For_Query__c = queryToResponseInstance[0].Id, 
                                                            Response_Title__c = strtopic, 
                                                            Response_Link__c = strLink, 
                                                            Response_Description__c = strDesc);
                        nonDuplicateResponses.add(tempResponse);
                    }
                }
                else {
                    System.debug('------>------advertisement');
                }
                 //insert the list of responses
          }
          if(!nonDuplicateResponses.isEmpty()) {
                insert nonDuplicateResponses;
          }
    }
}