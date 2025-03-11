@isTest
public class Test_MSD_CORE_MIRSearchController {
   	static String productCode = 'TestProductCode';
    static String requestQuestion = 'TestQuestion';
    @TestSetup
    public static void testData(){
        String currentUserEmail = UserInfo.getUserEmail();
        Contact details = new Contact(FirstName = 'John', LastName = 'Doe', Email = currentUserEmail, Phone = '1234567890', MailingStreet = '123 Test St', MailingCity = 'TestCity', MailingState = 'TS', MailingPostalCode = '123456', MailingCountry = 'TestCountry');
        insert details;
    }
    
    @isTest 
    public static void testsearchMedcomms() {
        // Setup mock data
        String productName = 'TestProduct';
        String keyword = 'TestKeyword';
        
        // Create mock response for the HTTP callout
        HttpResponse mockResponse = new HttpResponse();
        mockResponse.setHeader('Content-Type', 'application/json');
        mockResponse.setBody('{"hits":{"total":1,"hits":[{"_source":{"product_name":"TestProduct","query_string":"TestKeyword"}}]}}');
        mockResponse.setStatusCode(200);
        
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator(mockResponse));
        
        // Call the method to test
        Test.startTest();
        String response = MSD_CORE_MIRSearchController.searchMedcomms(productName, keyword);
        Test.stopTest();
        
        // Verify results
        system.assertnotequals(null, response);
        system.assertequals('{"hits":{"total":1,"hits":[{"_source":{"product_name":"TestProduct","query_string":"TestKeyword"}}]}}', response);
    }
    private class MockHttpResponseGenerator implements HttpCalloutMock {
        private HttpResponse response;
        
        MockHttpResponseGenerator(HttpResponse response) {
            this.response = response;
        }
        
        public HttpResponse respond(HttpRequest req) {
            return response;
        }
    }
    
    @isTest 
    public static void testsubmitUncodedCase(){
        HttpResponse mockResponse = new HttpResponse();
        mockResponse.setHeader('Content-Type', 'application/json');
        mockResponse.setBody('{"message":"Success"}');
        mockResponse.setStatusCode(201);
        
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator_2(mockResponse));
        
        Test.startTest();
        String response = MSD_CORE_MIRSearchController.submitUncodedCase(productCode, requestQuestion);
        Test.stopTest();
        
        System.assertNotEquals(null, response);
        System.assertEquals('Request successful. Response: {"message":"Success"}', response);
    }
        
    private class MockHttpResponseGenerator_2 implements HttpCalloutMock {
        private HttpResponse response;
        
        MockHttpResponseGenerator_2(HttpResponse response) {
            this.response = response;
        }
        
        public HttpResponse respond(HttpRequest req) {
            return response;
    }
        
    }
    
    @isTest
    public static void testsubmitCodedCase(){
        HttpResponse mockResponse = new HttpResponse();
        mockResponse.setHeader('Content-Type', 'application/json');
        mockResponse.setBody('{"message":"Success"}');
        mockResponse.setStatusCode(201);
        
         Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator_3(mockResponse));
        
        Test.startTest();
        String response = MSD_CORE_MIRSearchController.submitCodedCase(productCode, requestQuestion, 'Test uri', 'string doc');
        Test.stopTest();
        
        System.assertNotEquals(null, response);
        System.assertEquals('Request successful. Response: {"message":"Success"}', response);
        
    }
    private class MockHttpResponseGenerator_3 implements HttpCalloutMock {
        private HttpResponse response;
        
        MockHttpResponseGenerator_3(HttpResponse response) {
            this.response = response;
        }
        
        public HttpResponse respond(HttpRequest req) {
            return response;
    }
        
    }
}