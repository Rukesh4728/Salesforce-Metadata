trigger OpportunityEventTrigger on Opportunity_Event__e (after insert) {
    List<Opportunity_Event__e> eventList = Trigger.new;
    System.enqueueJob(new SendOpportunityDetails(eventList));
}