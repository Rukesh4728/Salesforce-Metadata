trigger PreventAccountUpdate on Account (before update) {
    for(Account acc: Trigger.new){
        if(acc.CreatedDate<system.today()-7){
            acc.addError('You cannot update a record which is less than 7 days old!!!');
            
        }
    }

}