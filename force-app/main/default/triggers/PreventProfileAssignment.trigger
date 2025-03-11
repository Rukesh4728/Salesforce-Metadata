trigger PreventProfileAssignment on User (before insert) {
    Id profilename=[select Id from Profile where Name='Sales Manager' LIMIT 1].Id;
    
    for(User us: Trigger.new){
        if(us.ProfileId==profilename){
            us.addError('You cannot assign Sales Manager profile!!!');
        }
    }
}