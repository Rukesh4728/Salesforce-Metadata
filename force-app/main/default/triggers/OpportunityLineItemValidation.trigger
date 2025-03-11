trigger OpportunityLineItemValidation on Opportunity (after update) {
    set<Id> setid=new set<Id>();
    for(Opportunity opp:Trigger.new){
        Opportunity oldopp=Trigger.oldmap.get(opp.Id);
        if(oldopp.stagename!=opp.stagename){
            setid.add(opp.Id);
        }
    }
    
    list<AggregateResult> agg=[select OpportunityId, count(Product2Id) productcount from OpportunityLineItem where OpportunityId IN: setid group by OpportunityId];
    map<Id, integer> aggmap=new map<Id, integer>();
    
    for(AggregateResult ar: agg){
        aggmap.put((Id)ar.get('OpportunityId'), (integer)ar.get('productcount'));
    }
    
    for(Opportunity opp: Trigger.new){
        if(aggmap.containskey(opp.Id) && aggmap.get(opp.Id)>2){
            opp.addError('Total products must be less than 2');
        }
    }
}