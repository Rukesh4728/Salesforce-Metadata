@isTest
private class LeadAPITest {
    @isTest
    static void testCreateContactSuccess() {
        // Create test data
        Contact testContact = new Contact(FirstName = 'Test', LastName = 'User', Email = 'testuser@example.com', Phone = '1234567890');
        String requestBody = JSON.serialize(testContact);
        
        // Mock REST request
        RestRequest req = new RestRequest();
        req.requestURI = '/services/apexrest/createContact';
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueOf(requestBody);
        RestContext.request = req;
        RestContext.response = new RestResponse();
        
        // Call the API method
        Test.startTest();
        LeadAPI.ResponseWrapper response = LeadAPI.createContact();
        Test.stopTest();
        
        // Validate inserted contact
        Contact insertedContact = [SELECT Id, FirstName, LastName, Email, Phone FROM Contact WHERE Id = :response.contactId LIMIT 1];
        
    }
    
    @isTest
    static void testCreateContactFailure() {
        // Mock REST request with invalid JSON
        RestRequest req = new RestRequest();
        req.requestURI = '/services/apexrest/createContact';
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueOf('{invalidJson');
        RestContext.request = req;
        RestContext.response = new RestResponse();
        
        // Call the API method
        Test.startTest();
        LeadAPI.ResponseWrapper response = LeadAPI.createContact();
        Test.stopTest();
    }
}