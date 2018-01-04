trigger ClosedOpportunityTrigger on Opportunity(before insert, before update) {
    List<task> taskList = new List<task>();
    for(opportunity opp : trigger.new){
        if(opp.StageName == 'Closed Won'){
            
            task t1 = new task();
            t1.WhatId = opp.id;
            t1.subject = 'Follow Up Test Task';
            taskList.add(t1);
        }
    }
    insert taskList;

}