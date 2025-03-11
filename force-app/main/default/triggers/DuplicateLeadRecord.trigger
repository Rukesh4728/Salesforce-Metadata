trigger DuplicateLeadRecord on Lead (before insert, before update) {
    set<string> setids=new set<string>();
    for(Lead newld: Trigger.new){
        setids.add(newld.Name);
    }
    
    list<Lead> newlist=[select Id, Name from Lead where Name IN: setids];
    set<string> oldidset=new set<string>();
    for(Lead oldld:newlist){
        oldidset.add(oldld.Name);
    }
    
    for(Lead newld: Trigger.new){
        if(newld.Name!=null && oldidset.contains(newld.Name)){
            newld.addError('Duplicate record cannot be entered!!!');
        }
    }

}