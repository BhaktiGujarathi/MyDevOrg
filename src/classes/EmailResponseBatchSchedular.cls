global with sharing class EmailResponseBatchSchedular implements Schedulable {
    global void  execute(SchedulableContext scheduleCon) {
        System.schedule('JobOfReplyResponse'+system.now(),' 0 0 /12 * * ?',new EmailResponseBatchSchedular());
       Database.executebatch(new EmailResponseBatch());
       System.abortJob(scheduleCon.getTriggerId());
    }

}