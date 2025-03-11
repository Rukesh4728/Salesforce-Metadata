trigger Accountstatus on Account (before insert, before update) {
    
    for(Account acc:Trigger.new){
        if(acc.Status__c=='Active'){
            acc.Description='Thank you';
        }
        
    }

}