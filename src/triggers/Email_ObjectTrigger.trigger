/***************************************************************************************************
 *  Title     : Trigger to be fired after insert of email record
 *  Trigger   : Email_ObjectTrigger
 *  Author    : Bhakti Gujarathi
***************************************************************************************************/

trigger Email_ObjectTrigger on Email_Object__c (after insert) {
    //check if isAfter & isInsert
    if(trigger.isafter && trigger.isInsert) {
        //call to the method in handler class 
        Email_ObjectTriggerHandler.temp(trigger.new);
    }
}