// Define the web service class
global class OpportunityService {
    
    // Expose the method as a SOAP web service
    webService static String processOpportunity(String opportunityData) {
        try {
            System.debug('Received Opportunity Data: ' + opportunityData);
            return 'Success';
        } catch (Exception e) {
            System.debug('Error: ' + e.getMessage());
            return 'Failure';
        }
    }
}