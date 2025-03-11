trigger ExpirationDateUpdate on Opportunity (after update) {
    map<Id,date> newmap=new map<Id,date>();
    for(Opportunity opp: Trigger.new){
        Opportunity oldrec=Trigger.oldmap.get(opp.Id);
        if(oldrec.CloseDate!=opp.CloseDate){
            newmap.put(opp.Id, opp.CloseDate);
        }
    }
    
    list<Quote> lqt=[select OpportunityId, ExpirationDate from Quote where OpportunityId IN: newmap.keyset()] ;
    list<Quote> newqt=new list<Quote>();
    for(Quote qt:lqt){
        if(newmap.containskey(qt.OpportunityId)){
            qt.ExpirationDate=newmap.get(qt.OpportunityId);
            newqt.add(qt);
        }
    }
    update newqt;

}