trigger TaskCreationOncase on Case (after insert) {
    list<Task> tsk=new list<Task>();
    
    for(Case cs: Trigger.new){
        Task t=new Task();
        t.Subject='Follow up on Case Resolution';
        t.Status='Not Started';
        t.Priority='Normal';
        t.WhatId=cs.Id;
        t.OwnerId=cs.OwnerId;
        tsk.add(t);
    }
    insert tsk;

}