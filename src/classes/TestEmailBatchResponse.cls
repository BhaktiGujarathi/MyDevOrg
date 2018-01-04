@isTest
private class TestEmailBatchResponse {
    static testMethod void testBatchOfReplyEmail() {
        List<Query__c> queryListInstance = new List<Query__c>();
        List<Reply_To__c> replyListInstance = new List<Reply_To__c>();
        List<Contact> contactListInstance = new List<Contact>();
        for(Integer i = 0; i < 5; i++) {
            Query__c queryInstance = new Query__c(Query_Text__c = 'query'+i);
            queryListInstance.add(queryInstance);
        }
        insert queryListInstance;
        
        List<Query__c> queryAssertListInstance = [SELECT Id, Query_Text__c
                                                  FROM Query__c
                                                  WHERE Query_Text__c LIKE 'query%'];
                                                 
        for(Integer i = 0; i < 5; i++) {
            Contact contactInstance = new Contact(LastName = 'TestLastName'+i);
            contactListInstance.add(contactInstance);
        }
        insert contactListInstance;
        
        List<Contact> contactAssertListInstance = [SELECT Id, LastName
                                                   FROM Contact
                                                   WHERE LastName LIKE 'Test%'];
                                                   
        for(Integer i = 0; i < 5; i++) {
            Reply_To__c replyTestInstance = new Reply_To__c(QueryCode__c = queryAssertListInstance[i].Id, ContactCode__c = contactAssertListInstance[i].Id);
            replyListInstance.add(replyTestInstance);
        }
        insert replyListInstance;
        
        EmailResponseBatch batchObj = new EmailResponseBatch();
        
        Test.startTest();
        Database.executeBatch(batchObj);
        Test.stopTest();
        
        System.assertequals(5,batchObj.mails.size());
    }
}