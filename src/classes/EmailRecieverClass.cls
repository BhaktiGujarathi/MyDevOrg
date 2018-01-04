/***************************************************************************************************
 *  Title   : Class for handling the email service implementing InboundEmailHandler
 *  Class   : EmailRecieverClass
 *  Author  : Bhakti Gujarathi
***************************************************************************************************/

global class EmailRecieverClass implements Messaging.InboundEmailHandler {
    //method to handle the incoming emails
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, 
                                                            Messaging.InboundEnvelope envelope) {
        
        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
        String stringBody= ''; 
        String stringToQuery;
       // List<Query__c> queryList = new List<Query__c>();   
        stringBody = email.plainTextBody;
        //create a list to hold email records
        List<Email_Object__c> emailList = new List<Email_Object__c>();
        //junction object of contact and query
        Reply_To__c replyInstance = new Reply_To__c();
        
        try {
            //if emailBody is not blank  
            //do
            if(String.isNotBlank(email.plainTextBody)) {
                //it contains a substring for query in given format
                if((String.isNotBlank(email.plainTextBody.substringBeforeLast(']').substringAfter('[Query->')))) {
                        //if query string length does not exceeds
                        if(email.plainTextBody.substringBeforeLast(']').substringAfter('[Query->').length() < 1000) {
                
                            //create a new email instance
                            Email_Object__c emailInstance = new Email_Object__c(
                                                             Body_Of_Email__c = email.plainTextBody, 
                                                             Subject_Of_Email__c = email.Subject, 
                                                             Sender_Of_Email__c = email.fromAddress);
                            //fetch relevant contact instance
                            List<Contact> contactList = [SELECT Id, Name 
                                                         FROM Contact 
                                                         WHERE Email =:email.fromAddress];
                            //check if contact exists   
                            if (contactList.size() == 0) {
                                //if not create new one
                                Contact contactNewInstance = new Contact(LastName = email.fromName,
                                                                         Email = email.fromAddress);
                                insert contactNewInstance;
                                //assign parent id to the junction objectRecord
                                replyInstance.ContactCode__c = contactNewInstance.Id;
                            }
                            else {
                                //assign parent id to the junction objectRecord
                                replyInstance.ContactCode__c = contactList[0].Id;
                            }
                
                            //get the query string from email body
                            stringToQuery = email.plainTextBody;
                            stringToQuery = stringToQuery.substringBeforeLast(']');
                            stringToQuery = stringToQuery.substringAfter('[Query->');
                            
                            //fetch relevant query instance
                            List<Query__c> queryList = [SELECT Id, Query_Text__c
                                                        FROM Query__c
                                                        WHERE Query_Text__c =:stringToQuery];
                            //check if query record exists
                            if(queryList.size() == 0)  {
                                //if not create a new one
                                Query__c queryInstance = new Query__c(); 
                                queryInstance.Query_Text__c = stringToQuery;
                                
                                insert queryInstance;
                                //assign parent id to the junction object record
                                replyInstance.QueryCode__c = queryInstance.Id;
                            }
                            else {
                                //assign parent id to the junction objectRecord
                                replyInstance.QueryCode__c = queryList[0].Id;
                            }
                            result.success = true;
                            emailList.add(emailInstance);
                            insert emailList;
                            replyInstance.Replied__c = false;
                            insert replyInstance;
                        }
                        else { //length of query string exceeds
                            result.success= false;
                            result.message = 'Length of query exceeded!!!';
                        }
                }
                else { //if queryString is empty
                    result.success= false;
                    result.message = 'Query String Empty!! \n Query format is [Query->Your Query]';
                }
            }
            else { //if email body is empty
                result.success= false;
                result.message = 'Email Body Is empty!!! \n Query format is [Query->Your Query]';
            } 
        }
        catch (Exception exceptionInstance) { //catchs hte exception thrown by try block
            result.message =  exceptionInstance.getMessage();
        }
        return result;
    }
}