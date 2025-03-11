trigger PreventAccountDeletion1 on Account (before delete) {
    profile newprofile=[select Id from Profile where Name='System Administrator'];
    for(Account acc:Trigger.old){
        if(acc.CreatedBy.ProfileId==newprofile.Id){
            acc.addError('Accounts created by System Administrator cannot be deleted');
        }
        
    }

}