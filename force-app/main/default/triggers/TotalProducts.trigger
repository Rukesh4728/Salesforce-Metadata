trigger TotalProducts on OpportunityLineItem (after insert, after delete) {
    set<Id> oppids=new set<Id>();
    for(OpportunityLineItem oli: Trigger.new){
        oppids.add(oli.OpportunityId);
    }
    
    if(Trigger.IsAfter || Trigger.IsDelete){
        for(OpportunityLineItem oli:Trigger.old){
            oppids.add(oli.OpportunityId);
        }
    }
    
    list<AggregateResult> agg=[select OpportunityId, count(Product2Id) productcount from OpportunityLineItem where OpportunityId IN: oppids group by OpportunityId];
    map<Id, integer> pdcount=new map<Id, integer>();
    list<Opportunity> lopp=new list<Opportunity>();
    
    for(AggregateResult ar:agg){
        pdcount.put((Id)ar.get('OpportunityId'), (integer)ar.get('productcount'));
    }
    if(Trigger.IsAfter || Trigger.IsInsert){
        for(OpportunityLineItem oli:Trigger.new){
            if(pdcount.containskey(oli.OpportunityId)){
                Opportunity opp=new Opportunity(Id=oli.OpportunityId);
                opp.Total_Product_count__c=pdcount.get(oli.OpportunityId);
                lopp.add(opp);
        }
    }
    }
    
    if(Trigger.IsAfter || Trigger.IsDelete){
        for(OpportunityLineItem oli: Trigger.old){
            if(pdcount.containskey(oli.OpportunityId)){
                Opportunity opp=new Opportunity(Id=oli.OpportunityId);
                opp.Total_Product_count__c=pdcount.get(oli.OpportunityId);
                lopp.add(opp);
            }
        }
    }
    update lopp;
}