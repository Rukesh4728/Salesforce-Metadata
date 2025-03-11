public class SendOpportunityDetails implements Queueable, Database.AllowsCallouts {
    private List<Opportunity_Event__e> events;

    public SendOpportunityDetails(List<Opportunity_Event__e> events) {
        this.events = events;
    }

    public void execute(QueueableContext context) {
        for (Opportunity_Event__e event : events) {
            HttpRequest req = new HttpRequest();
            req.setEndpoint('https://jsonplaceholder.typicode.com/posts'); // Mock API
            req.setMethod('POST');
            req.setHeader('Content-Type', 'application/json');

            // Convert event data to JSON
            String jsonBody = JSON.serialize(new Map<String, Object>{
                'OpportunityId' => event.OpportunityId__c,
                'Name' => event.Name__c,
                'CloseDate' => event.CloseDate__c,
                'StageName' => event.StageName__c
            });

            req.setBody(jsonBody);

            Http http = new Http();
            try {
                HttpResponse res = http.send(req);
                System.debug('Response: ' + res.getBody());
            } catch (Exception e) {
                System.debug('Error: ' + e.getMessage());
            }
        }
    }
}