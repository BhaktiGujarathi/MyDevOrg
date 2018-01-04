/***************************************************************************************************
 *  Title              : Controller Class for VF component 
 *  Controller Class   : ResponseController
 *  Author             : Bhakti Gujarathi
***************************************************************************************************/
public with sharing class ResponseController {
    public id idOfQuery{get; set;}
    public List<Response_Item__c> responseListToDisplay;
    public List<Response_Item__c> getresponseListToDisplay() {
        responseListToDisplay = [SELECT Id, 
                                        Response_Title__c,
                                        Response_Link__c,
                                        Response_Description__c 
                                  FROM Response_Item__c
                                  WHERE For_Query__c =:idOfQuery];
        return responseListToDisplay;
    }
    

}