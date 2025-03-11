trigger PreventCaseClosure on Case (before update) {
    set<Id> caseids=new set<Id>();
    
    for(Case cs: Trigger.new){
        Case oldcase=Trigger.oldmap.get(cs.Id);
        if(oldcase.Status!='Closed'){
            caseids.add(cs.Id); 
        } 
    }
    
    list<Task> tsk=[select Id, Status, WhatId from Task where WhatId IN: caseids and Status!='Completed'];
    set<Id> casewithopentask=new set<Id>();
    for(Task t: tsk){
        casewithopentask.add(t.WhatId);
    }
     
    for(Case cs:Trigger.new){
        if(casewithopentask.contains(cs.Id)){
            cs.addError('Case cannot be closed as there is an open task');
        }
    }

}