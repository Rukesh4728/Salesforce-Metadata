trigger TotalOppAmount on Account (after update) {
    set<Id> setids=new set<Id>();
    for(Account acc:Trigger.new){
        setids.add(acc.Id);
    }
    
    list<AggregateResult> agg=[select AccountId, sum(Amount) totalamount from Opportunity where AccountId IN: setids group by AccountId];
    Map<Id, Decimal> newmap=new Map<Id, Decimal>();
    
    list<Account> lacc=new list<Account>();
    
    for(AggregateResult ar:agg){
        newmap.put((Id)ar.get('AccountId'), (Decimal)ar.get('totalamount'));
    }
    
    for(Account acc:Trigger.new){
        if(newmap.containskey(acc.Id)){
            acc.TotalOpportunitiesAmount__c=newmap.get(acc.Id);
            lacc.add(acc);
        }
    }
    update lacc;

}