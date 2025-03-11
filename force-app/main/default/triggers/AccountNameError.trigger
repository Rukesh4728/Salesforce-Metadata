trigger AccountNameError on Account (before update) {
    for(Account acc: Trigger.new){
        Account oldrec=Trigger.oldmap.get(acc.Id);
        if(oldrec.Name!=acc.Name){
            acc.addError('Cannot change the name!!!');
        }
        
            
        }
    }