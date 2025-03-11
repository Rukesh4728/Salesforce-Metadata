trigger OpportunityRollupTrigger on Opportunity (after insert, after update, after delete, after undelete) {

    // Set to store Account IDs that need to be updated
    Set<Id> accountIds = new Set<Id>();

    // Collect Account IDs from trigger events
    if (Trigger.isInsert || Trigger.isUpdate || Trigger.isUndelete) {
        for (Opportunity opp : Trigger.new) {
            accountIds.add(opp.AccountId);
        }
    }
    if (Trigger.isDelete || Trigger.isUpdate) {
        for (Opportunity opp : Trigger.old) {
            accountIds.add(opp.AccountId);
        }
    }

    // Query Accounts and roll up the total closed opportunity amounts
    List<Account> accountsToUpdate = new List<Account>();
    list<AggregateResult> agg=[SELECT AccountId, SUM(Amount) totalClosedAmount FROM Opportunity WHERE AccountId IN:accountIds AND StageName = 'Closed Won' group by AccountId];
    map<Id, decimal> newmap=new map<Id, decimal>();
    for(AggregateResult ar:agg){
        newmap.put((Id)ar.get('AccountId'), (decimal)ar.get('totalClosedAmount'));
    }
    
    if(Trigger.isInsert || Trigger.isUpdate || Trigger.isUndelete){
        for(Opportunity opp:Trigger.new){
            if(newmap.containskey(opp.AccountId)){
                Account acc=new Account(Id=opp.AccountId);
                acc.Total_closed__c=newmap.get(opp.AccountId);
                accountsToUpdate.add(acc);
            }
        }
        
        update accountsToUpdate;
    }
}