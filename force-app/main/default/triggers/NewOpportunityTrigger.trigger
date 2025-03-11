trigger NewOpportunityTrigger on Opportunity (after insert) {
    List<Opportunity_Event__e> events = new List<Opportunity_Event__e>();

    for (Opportunity opp : Trigger.new) {
        Opportunity_Event__e event = new Opportunity_Event__e(
            OpportunityId__c = opp.Id,
            Name__c = opp.Name,
            CloseDate__c = opp.CloseDate,
            StageName__c = opp.StageName
            
        );
        events.add(event);
    }

    if (!events.isEmpty()) {
        EventBus.publish(events);
    }
}