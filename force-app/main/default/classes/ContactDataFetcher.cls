public class ContactDataFetcher {
    @future(callout=true)
    public static void fetchAdditionalData(Id contactId) {
        try {
            // Mock API Endpoint (Replace with actual API)
            String apiUrl = 'https://jsonplaceholder.typicode.com/users/1';

            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint(apiUrl);
            request.setMethod('GET');
            request.setTimeout(60000); // 60 seconds timeout

            HttpResponse response = http.send(request);

            if (response.getStatusCode() == 200) {
                // Parse JSON Response
                Map<String, Object> responseData = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());

                // Extract Data
                String externalPhone = (String) responseData.get('phone');
                String externalCompany = (String) ((Map<String, Object>) responseData.get('company')).get('name');

                // Update Contact with External Data
                Contact contactToUpdate = new Contact(
                    Id = contactId,
                    Phone = externalPhone,
                    Description = 'Company: ' + externalCompany
                );

                update contactToUpdate;
            } else {
                System.debug('API Callout Failed: ' + response.getBody());
            }
        } catch (Exception e) {
            System.debug('Error in API Callout: ' + e.getMessage());
        }
    }
}