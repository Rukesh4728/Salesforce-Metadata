trigger OpportunityTrigger on Opportunity (before insert, before update) {
    if(Trigger.isInsert || Trigger.isUpdate){
        OpportunityTrigger.Opportunityhandler(Trigger.new);
    }

}