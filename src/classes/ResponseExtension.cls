public with sharing class ResponseExtension {
    public ApexPages.StandardController queri;
    public Id idOfParentQuery;
    public List<Response_Item__c> responseList;
    public ResponseExtension(apexPages.StandardController controller) {
        this.queri = controller;
        responseList = new List<Response_Item__c>();
    }
    
    public List<Response_Item__c> getresponseList() {
        idOfParentQuery = apexPages.currentPage().getParameters().get('queryId');
        responseList = [SELECT id,
                               Response_Title__c,
                               Response_Link__c,
                               Response_Description__c
                        FROM Response_Item__c
                        WHERE For_Query__c = :idOfParentQuery];
        return responseList;
    }
    //Save error: common.apex.runtime.bytecode.BytecodeApexObjectType cannot be cast to common.apex.runtime.impl.ApexType
    //https://developer.salesforce.com/forums/?id=906F0000000BQHgIAO
}