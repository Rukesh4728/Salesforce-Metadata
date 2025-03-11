public with sharing class OpenWeatherMapService {
    private static final String API_URL = 'https://goweather.herokuapp.com/weather/Curitiba';
 
    @future(callout=true)
    public static void fetchWeatherData() {
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(API_URL);
        req.setMethod('GET');
 
        try {
            HttpResponse res = http.send(req);
            System.debug('API Response: ' + res.getBody());
 
            if (res.getStatusCode() == 200) {
                // Deserialize the response
                Map<String, Object> jsonResponse = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
                // Extract weather details
                decimal temperature =  (decimal) jsonResponse.get('temperature');
                decimal humidity = (decimal) jsonResponse.get('humidity');
                // Check if the weather data already exists for today
                Date today = Date.today();
                List<Weather_Data__c> existingRecords = [SELECT Id FROM Weather_Data__c WHERE CreatedDate = TODAY LIMIT 1];
                if (!existingRecords.isEmpty()) {
                    // Update the existing record
                    Weather_Data__c report = existingRecords[0];
                    report.Name = 'New Weather Record';
                    report.Temperature__c = temperature;
                    report.Humidity__c = humidity;
                    update report;
                } else {
                    // Insert a new record
                    Weather_Data__c report = new Weather_Data__c(
                        Name = 'New Record',
                        Temperature__c = temperature,
                        Humidity__c = humidity
                    );
                    insert report;
                }
                System.debug('Weather data updated successfully.');
            } else {
                System.debug('Weather API call failed with status code: ' + res.getStatusCode());
            }
        } catch (Exception e) {
            System.debug('Error in Weather API Callout: ' + e.getMessage());
        }
    }
}