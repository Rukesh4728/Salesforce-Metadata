trigger PreventAccountDeletion on Account (before delete) {
   for(Account acc:Trigger.old){
        if(acc.Rating=='Hot'){
            acc.addError('Accounts with a rating of hot cannot be deleted');
        }
    }

}