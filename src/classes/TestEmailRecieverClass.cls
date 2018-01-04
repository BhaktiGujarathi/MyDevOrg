/***************************************************************************************************
 *  Title   : Test Class for the Class handling the email service and trigger callout to google 
 *  Class   : TestEmailRecieverClass
 *  Author  : Bhakti Gujarathi
***************************************************************************************************/
@isTest
private class TestEmailRecieverClass {
    //test creation of related contact
    static testMethod void testContactCreation() {
       Messaging.InboundEmail email = new Messaging.InboundEmail();
       Messaging.InboundEnvelope envelope = new Messaging.InboundEnvelope();
       
       email.fromAddress = 'bhaktigujarathi@ymail.com';
       email.Subject = 'Testmail';
       email.plainTextBody = 'hi, [Query-> India]';
       email.fromName = 'Bhakti Gujju';
       Test.setMock(HttpCalloutMock.class, new MockTestEmail_ObjectTriggerHandler());
       
       Test.startTest();
       EmailRecieverClass EmailRecieverClassObject = new EmailRecieverClass();
       EmailRecieverClassObject.handleInboundEmail(email, envelope);
       Test.stopTest();
       
       List<Contact> contactTestListInstance = [SELECT id, LastName
                                                FROM Contact
                                                WHERE LastName = 'Bhakti Gujju'];
       System.assertEquals(1,contactTestListInstance.size());
    }
    
    //test if a contact already exists
    static testMethod void testExistingContact() {
       Contact contactTestInstance = new Contact(LastName = 'Bhakti Gujju', Email = 'bhaktigujarathi@ymail.com');
       insert contactTestInstance;
       
       Messaging.InboundEmail email = new Messaging.InboundEmail();
       Messaging.InboundEnvelope envelope = new Messaging.InboundEnvelope();
     
       email.fromAddress = 'bhaktigujarathi@ymail.com';
       email.Subject = 'Testmail';
       email.plainTextBody = 'hi, [Query-> India]';
       email.fromName = 'Bhakti Gujju';
       Test.setMock(HttpCalloutMock.class, new MockTestEmail_ObjectTriggerHandler());
       
       Test.startTest();
       EmailRecieverClass EmailRecieverClassObject = new EmailRecieverClass();
       EmailRecieverClassObject.handleInboundEmail(email, envelope);
       Test.stopTest();
       
       List<Contact> contactTestListInstance = [SELECT id, LastName
                                                FROM Contact
                                                WHERE LastName = 'Bhakti Gujju'];
       System.assertEquals(1,contactTestListInstance.size());
    }
    
    //test creation of related query
    static testMethod void testQueryCreation() {
       Messaging.InboundEmail email = new Messaging.InboundEmail();
       Messaging.InboundEnvelope envelope = new Messaging.InboundEnvelope();
       
       email.fromAddress = 'bhaktigujarathi@ymail.com';
       email.Subject = 'Testmail';
       email.plainTextBody = 'hi, [Query-> India]';
       email.fromName = 'Bhakti Gujju';
       Test.setMock(HttpCalloutMock.class, new MockTestEmail_ObjectTriggerHandler());
       
       Test.startTest();
       EmailRecieverClass EmailRecieverClassObject = new EmailRecieverClass();
       EmailRecieverClassObject.handleInboundEmail(email, envelope);
       Test.stopTest();
       
       List<Query__c> queryTestListInstance = [SELECT id, Query_Text__c
                                               FROM Query__c
                                               WHERE Query_Text__c = 'India'];
       System.assertEquals(1,queryTestListInstance.size()); 
    }
    
    //test if query already exists
    static testMethod void testExistingQuery() {
       Query__c queryTestInstance = new Query__c(Query_Text__c = 'India');
       insert queryTestInstance;
       
       Messaging.InboundEmail email = new Messaging.InboundEmail();
       Messaging.InboundEnvelope envelope = new Messaging.InboundEnvelope();
       
       email.fromAddress = 'bhaktigujarathi@ymail.com';
       email.Subject = 'Testmail';
       email.plainTextBody = 'hi, [Query->India]';
       email.fromName = 'Bhakti Gujju';
       Test.setMock(HttpCalloutMock.class, new MockTestEmail_ObjectTriggerHandler());
       
       Test.startTest();
       EmailRecieverClass EmailRecieverClassObject = new EmailRecieverClass();
       EmailRecieverClassObject.handleInboundEmail(email, envelope);
       Test.stopTest();
       
       List<Query__c> queryTestListInstance = [SELECT id, Query_Text__c
                                               FROM Query__c
                                               WHERE Query_Text__c = 'India'];
       System.assertEquals(1,queryTestListInstance.size()); 
    }
    
    //test the result success
    static testMethod void testResultSuccess() {
       Messaging.InboundEmail email = new Messaging.InboundEmail();
       Messaging.InboundEnvelope envelope = new Messaging.InboundEnvelope();
       
       email.fromAddress = 'bhaktigujarathi@ymail.com';
       email.Subject = 'Testmail';
       email.plainTextBody = 'hi, [Query-> India]';
       email.fromName = 'Bhakti Gujju';
       Test.setMock(HttpCalloutMock.class, new MockTestEmail_ObjectTriggerHandler());
       
       Test.startTest();
       EmailRecieverClass EmailRecieverClassObject = new EmailRecieverClass();
       Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
       Test.stopTest();
       
       result = EmailRecieverClassObject.handleInboundEmail(email, envelope);
       
       System.assertEquals(true,result.success);
    }
    
    //test error reply email
    static testMethod void testErrorResultMessage() {
       Messaging.InboundEmail email = new Messaging.InboundEmail();
       Messaging.InboundEnvelope envelope = new Messaging.InboundEnvelope();
       
       email.fromAddress = 'bhaktigujarathi@ymail.com';
       email.Subject = 'Testmail';
       email.plainTextBody = '';
       email.fromName = 'Bhakti Gujju';
       
       EmailRecieverClass EmailRecieverClassObject = new EmailRecieverClass();
       Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
       result = EmailRecieverClassObject.handleInboundEmail(email, envelope);
       
       System.assertEquals(false,result.success);
       System.assertEquals('Email Body Is empty!!! \n Query format is [Query->Your Query]', result.message);
    }
    
    //test if querystring is empty
    static testMethod void testErrorForEmptyQuery() {
       Messaging.InboundEmail email = new Messaging.InboundEmail();
       Messaging.InboundEnvelope envelope = new Messaging.InboundEnvelope();
       
       email.fromAddress = 'bhaktigujarathi@ymail.com';
       email.Subject = 'Testmail';
       email.plainTextBody = '[Query->]';
       email.fromName = 'Bhakti Gujju';
       
       EmailRecieverClass EmailRecieverClassObject = new EmailRecieverClass();
       Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
       result = EmailRecieverClassObject.handleInboundEmail(email, envelope);
       
       System.assertEquals(false,result.success);
       System.assertEquals('Query String Empty!! \n Query format is [Query->Your Query]', result.message);
    }
    
    //test is responses already exists for the existing query
    static testMethod void testExistingResponses() {
       Query__c queryTestInstance = new Query__c(Query_Text__c = 'India');
       insert queryTestInstance;
       
       List<Response_Item__c> responseTestList = new List<Response_Item__c>();
       Response_Item__c resp0 = new Response_Item__c(For_Query__c = queryTestInstance.id, Response_Title__c = 'Amazon.com: Online Shopping for Electronics, Apparel, Computers ... ', Response_Link__c = 'http://www.amazon.com/', Response_Description__c= 'SimilarOnline retailer of books, movies, music and games along with electronics');
       responseTestList.add(resp0);
       Response_Item__c resp1 = new Response_Item__c(For_Query__c = queryTestInstance.id, Response_Title__c = 'Amazon.com &#124; Facebook', Response_Link__c = 'https://www.facebook.com/Amazon', Response_Description__c = 'SimilarAmazon.com. 26005525 likes · 162437 talking about this. Official Facebook page');
       responseTestList.add(resp1);
       insert responseTestList;
       
       Messaging.InboundEmail email = new Messaging.InboundEmail();
       Messaging.InboundEnvelope envelope = new Messaging.InboundEnvelope();
       
       email.fromAddress = 'bhaktigujarathi@ymail.com';
       email.Subject = 'Testmail';
       email.plainTextBody = 'hi, [Query->India]';
       email.fromName = 'Bhakti Gujju';
       Test.setMock(HttpCalloutMock.class, new MockTestEmail_ObjectTriggerHandler());
       
       Test.startTest();
       EmailRecieverClass EmailRecieverClassObject = new EmailRecieverClass();
       EmailRecieverClassObject.handleInboundEmail(email, envelope);
       Test.stopTest();
       
       List<Response_Item__c> responseTestListInstance = [SELECT id, For_Query__c
                                                          FROM Response_Item__c
                                                          WHERE For_Query__c =:queryTestInstance.id];
       System.assertNotEquals(2,responseTestListInstance.size()); 
    }
    
    //test the list of responses in email reply
    static testMethod void testResponsesInEmail() {
       Query__c queryTestInstance = new Query__c(Query_Text__c = 'India');
       insert queryTestInstance;
       
       Messaging.InboundEmail email = new Messaging.InboundEmail();
       Messaging.InboundEnvelope envelope = new Messaging.InboundEnvelope();
       ResponseController controllerInstance = new ResponseController();
       controllerInstance.idOfQuery = queryTestInstance.Id;
       
       email.fromAddress = 'bhaktigujarathi@ymail.com';
       email.Subject = 'Testmail';
       email.plainTextBody = 'hi, [Query-> India]';
       email.fromName = 'Bhakti Gujju';
       Test.setMock(HttpCalloutMock.class, new MockTestEmail_ObjectTriggerHandler());
       
       Test.startTest();
       EmailRecieverClass EmailRecieverClassObject = new EmailRecieverClass();
       EmailRecieverClassObject.handleInboundEmail(email, envelope);
       controllerInstance.getresponseListToDisplay();
       Test.stopTest();
       
       
       
       List<Response_Item__c> responseAssertTestListInstance = [SELECT id, For_Query__c
                                                                FROM Response_Item__c
                                                                WHERE For_Query__c =:queryTestInstance.Id];
       System.assertNotEquals(responseAssertTestListInstance.size(), controllerInstance.responseListToDisplay.size());
    }
    
    //test list of queries on history page
    static testMethod void testQueriesOnHistoryPage() {
       List<Query__c> queryTestListInstance = new List<Query__c>();
       for(Integer i = 0; i < 5; i++) {
            Query__c queryTestInstance = new Query__c(Query_Text__c = 'query'+i);
            queryTestListInstance.add(queryTestInstance);
       }
       insert queryTestListInstance;
       ResponsesToQueryController controllerInstance = new ResponsesToQueryController();
       
       Test.startTest();
       controllerInstance.getqueryList();
       Test.stopTest();
       
       List<Query__c> queryAssertTestListInstance = [SELECT id, Query_Text__c
                                                     FROM Query__c
                                                     WHERE Query_Text__c LIKE 'query%'];
       System.assertEquals(queryAssertTestListInstance.size(),controllerInstance.queryList.size());
    }
    
    //test responses ohn history page
     static testMethod void testResponsesOnHistoryPage() {
       Query__c queryTestInstance = new Query__c(Query_Text__c = 'India');
       insert queryTestInstance;
       
       List<Response_Item__c> responseTestList = new List<Response_Item__c>();
       Response_Item__c resp0 = new Response_Item__c(For_Query__c = queryTestInstance.id, Response_Title__c = 'Amazon.com: Online Shopping for Electronics, Apparel, Computers ... ', Response_Link__c = 'http://www.amazon.com/', Response_Description__c= 'SimilarOnline retailer of books, movies, music and games along with electronics');
       responseTestList.add(resp0);
       Response_Item__c resp1 = new Response_Item__c(For_Query__c = queryTestInstance.id, Response_Title__c = 'Amazon.com &#124; Facebook', Response_Link__c = 'https://www.facebook.com/Amazon', Response_Description__c = 'SimilarAmazon.com. 26005525 likes · 162437 talking about this. Official Facebook page');
       responseTestList.add(resp1);
       insert responseTestList;
       
       ResponsesToQueryController controllerInstance = new ResponsesToQueryController();
       boolean test1 = controllerInstance.hasNext;
       boolean test2 = controllerInstance.hasPrevious;
       integer test3 = controllerInstance.pageNumber;
       controllerInstance.cancel();
       controllerInstance.next();
       controllerInstance.previous();
       controllerInstance.first();
       controllerInstance.last();
       
       Test.startTest();
       controllerInstance.showresults();
       Test.stopTest();
       
       List<Response_Item__c> responseTestListInstance = [SELECT id, For_Query__c
                                                          FROM Response_Item__c
                                                          WHERE For_Query__c =:queryTestInstance.id];
       System.assertEquals(2,responseTestListInstance.size()); 
    }
    
    //test batch class of
    static testMethod void testBatchReplyJob() {
       Messaging.InboundEmail email = new Messaging.InboundEmail();
       Messaging.InboundEnvelope envelope = new Messaging.InboundEnvelope();
       
       email.fromAddress = 'bhaktigujarathi@ymail.com';
       email.Subject = 'Testmail';
       email.plainTextBody = 'hi, [Query-> India]';
       email.fromName = 'Bhakti Gujju';
       Test.setMock(HttpCalloutMock.class, new MockTestEmail_ObjectTriggerHandler());
       EmailResponseBatch batchObj = new EmailResponseBatch();
       
       Test.startTest();
       EmailRecieverClass EmailRecieverClassObject = new EmailRecieverClass();
       EmailRecieverClassObject.handleInboundEmail(email, envelope);
       Database.executeBatch(batchObj);       
       Test.stopTest();
       
       List<Reply_To__c> replyTestListInstance = [SELECT id,
                                                         ContactCode__c, 
                                                         ContactCode__r.LastName,
                                                         Replied__c
                                                  FROM Reply_To__c
                                                  WHERE ContactCode__r.LastName = 'Bhakti Gujju'];
       System.assertEquals(true,replyTestListInstance[0].Replied__c);
    }
}