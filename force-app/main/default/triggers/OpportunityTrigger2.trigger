trigger OpportunityTrigger2 on Opportunity (after update) {
    OpportunityTriggernew.myopportunityhandler(Trigger.new);

}