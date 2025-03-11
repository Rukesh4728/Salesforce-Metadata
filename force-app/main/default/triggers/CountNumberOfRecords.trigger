trigger CountNumberOfRecords on Contact (after insert, after update) {
    set<Id> setids=new set<Id>();
    for(Contact con: Trigger.new){
        setids.add(con.AccountId);
    }
    
    list<AggregateResult> agg=[select AccountId, Count(Id) totalcount from Contact where AccountId IN: setids and Phone!=null group by AccountId ];
    map<Id, integer> countmap=new map<Id, integer>();
    list<Contact> lcon=new list<Contact>();
    for(AggregateResult ar:agg){
        countmap.put((Id)ar.get('AccountId'), (integer)ar.get('totalcount'));
    }
    
    for(Contact con:Trigger.new){
        if(countmap.containskey(con.AccountId)){
            con.Total_Count__c=countmap.get(con.AccountId);
            lcon.add(con);
        }
    }
    update lcon;

}