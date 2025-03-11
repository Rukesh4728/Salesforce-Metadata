trigger DuplicateCandidateRecords on Contact (before insert, before update) {
    
    for(Contact c:Trigger.new){
        integer recordscount=[select count() from Contact where Name=:c.Name];
        if(recordscount>0){
            c.addError('Duplicate values cannot be entered!!!');
        }
    }

}