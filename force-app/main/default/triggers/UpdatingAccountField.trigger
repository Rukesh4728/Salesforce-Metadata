trigger UpdatingAccountField on Contact (after insert, after update, after delete) {
    set<Id> setids=new set<Id>();
        if((Trigger.IsAfter && Trigger.IsInsert) || (Trigger.IsAfter && Trigger.IsUpdate)){
                 for(Contact con:Trigger.new){
                      setids.add(con.AccountId);
        }
        }
    
        if((Trigger.IsAfter && Trigger.IsDelete)){
            for(Contact con:Trigger.old){
                setids.add(con.AccountId);
            }
            
        }
     
    list<AggregateResult> agg=[select AccountId, max(LastModifiedDate) LastContactedDate from Contact where AccountID IN: setids group by AccountId];
    map<Id, DateTime> newmap=new map<Id, DateTime>();
    
    for(AggregateResult ar:agg){
        newmap.put((Id)ar.get('AccountId'), (DateTime)ar.get('LastContactedDate'));
    }
    list<Account> lacc=new list<Account>();
    
    for(Contact con: Trigger.new){
        Account acc=new Account(Id=con.AccountId);
        if(newmap.containskey(con.AccountId)){
            acc.LastContacted__c=newmap.get(con.AccountId);
            lacc.add(acc);
        }
    }
    update lacc;
            

}