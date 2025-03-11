trigger TotalOpportunitiesperday on Account (before update) {
    set<Id> setids=new set<Id>();
    for(Account acc: Trigger.new){
        setids.add(acc.Id);
    }
    
    list<AggregateResult> agg=[select count(Id) totalopportunities, AccountId from Opportunity where AccountId IN: setids and CreatedDate=today group by AccountId];
    map<Id, integer> newmap=new map<Id, integer>();
    
    for(AggregateResult ar: agg){
        newmap.put((Id)ar.get('AccountId'), (integer)ar.get('totalopportunities'));
    }
    
    for(Account acc:Trigger.new){
        if((newmap.containskey(acc.Id))&&(newmap.get(acc.Id)>4)){
            acc.addError('Number of opportunities must be less than 5');
        }
    }

}