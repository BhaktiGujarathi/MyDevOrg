/***************************************************************************************************
 *  Title   : Batch Class to process the batch job of sending reply emails
 *  Class   : EmailResponseBatch
 *  Author  : Bhakti Gujarathi
***************************************************************************************************/

public with sharing class EmailResponseBatch implements Database.Batchable<sObject>{
    public List<Messaging.SingleEmailMessage> mails;
    //start method of batch to fetch the scopelist
    public Database.QueryLocator start(Database.BatchableContext batchCon) {
        return Database.getQueryLocator([SELECT Id, 
                                                Name,
                                                Replied__c,
                                                ContactCode__c,
                                                QueryCode__c
                                         FROM Reply_To__c
                                         WHERE CreatedDate = TODAY 
                                         AND Replied__c = false]);
    }
    
    //execute method to execute the actuall sending reply email job
    public void execute(Database.BatchableContext batchCon, List<Reply_To__c> replyToScopeList) {
         EmailTemplate emailTemplate = [SELECT Id, Body  
                                        FROM EmailTemplate 
                                        WHERE Name = 'Response Email'];
         mails = new List<Messaging.SingleEmailMessage>();
         //iterate over the scope list
         for(Reply_To__c  replyLoopInstance : replyToScopeList) {
              //create email instance
              Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
              //set the target who is supposed to recieve your email
              mail.setTargetObjectId(replyLoopInstance.ContactCode__c);
              //set the templateId to the VF Email Template
              mail.setTemplateId(emailTemplate.id);
              //set the object what is supposed to be sent in email
              mail.setWhatId(replyLoopInstance.QueryCode__c);
              replyLoopInstance.Replied__c = true;
              
              mails.add(mail);
         }
         //mail invocation
         update replyToScopeList; 
         Messaging.sendEmail(mails);
    }
    
    //finish method
    public void finish(Database.BatchableContext batchCon) {
        
    }
}