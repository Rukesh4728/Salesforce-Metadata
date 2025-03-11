@isTest
private class ContactRestAPITest {
    
    @isTest
    static void testCreateContact() {
        Test.startTest();

        // Prepare Mock Request Data
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/createContact/';
        req.httpMethod = 'POST';

        // Add Parameters to Simulate API Call
        req.addParameter('firstName', 'John');
        req.addParameter('lastName', 'Doe');
        req.addParameter('email', 'john.doe@example.com');

        // Assign request and response to the REST context
        RestContext.request = req;
        RestContext.response = res;

        // Call the API Method
        String response = ContactRestAPI.createContact('John', 'Doe', 'john.doe@example.com');

        // Query Contact to Check if Created
        List<Contact> createdContacts = [SELECT Id, FirstName, LastName, Email FROM Contact WHERE Email = 'john.doe@example.com' LIMIT 1];

        // Print Debug Logs
        System.debug('Created Contact: ' + createdContacts);
        System.debug('Response: ' + response);
        System.debug('Status Code: ' + res.statusCode);

        Test.stopTest();
    }

    @isTest
    static void testCreateContact_ErrorHandling() {
        Test.startTest();

        // Simulate an Error (by passing null values)
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/createContact/';
        req.httpMethod = 'POST';

        req.addParameter('firstName', null);
        req.addParameter('lastName', null);
        req.addParameter('email', null);

        RestContext.request = req;
        RestContext.response = res;

        // Call the API Method with Invalid Data
        String response = ContactRestAPI.createContact(null, null, null);

        // Print Debug Logs
        System.debug('Error Response: ' + response);
        System.debug('Error Status Code: ' + res.statusCode);

        Test.stopTest();
    }
}