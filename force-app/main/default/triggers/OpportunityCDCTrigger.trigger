trigger OpportunityCDCTrigger on OpportunityChangeEvent (after insert) {
    List<OpportunityChangeEvent> opportunityeventlist = Trigger.new;
    
    for(OpportunityChangeEvent oce: opportunityeventlist){
        
    }
}