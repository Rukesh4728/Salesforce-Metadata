trigger TaskOnOpportunity on Opportunity (after delete) {
    list<Task> tsk=new list<Task>();
    for(Opportunity opp:Trigger.old){
        Task ts=new Task();
        ts.Subject='Followup on deleted opportunity';
        ts.Priority='Normal';
        ts.Status='Not started';
        ts.WhatId=opp.Id;
        ts.OwnerId=opp.OwnerId;
        tsk.add(ts);
    }
    insert tsk;

}