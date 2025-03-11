public with sharing class WeatherService {
    public static void fetchWeatherForContact(Id contactId) {
        
        try {
            // Fetch Contact details
            Contact con = [SELECT Id, MailingCity FROM Contact WHERE Id = :contactId LIMIT 1];
          
            if (String.isEmpty(con.MailingCity)) {  
                return;
            }

            // OpenWeather API details
            String apiKey = '780c8daa78e233902ffda8fe1078b096';  // Replace with your actual API Key
            String url = 'https://api.openweathermap.org/data/2.5/weather?q=' + EncodingUtil.urlEncode(con.MailingCity, 'UTF-8') + '&appid=' + apiKey + '&units=metric';
            // HTTP Callout
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint(url);
            request.setMethod('GET');
            request.setTimeout(10000); // Set timeout in milliseconds

            HttpResponse response = http.send(request);
           
            if (response.getStatusCode() == 200) {
                // Parse JSON response
                Map<String, Object> weatherData = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                
                // Check if 'main' exists before casting
                if (weatherData.containsKey('main')) {
                    Map<String, Object> mainData = (Map<String, Object>) weatherData.get('main');
                    if (mainData.containsKey('temp')) {
                        Decimal temperature = (Decimal) mainData.get('temp');
                    
                        con.Description = 'Current Temperature: ' + temperature + '°C';
                        update con;

                    } else {
                        
                    }
                } else {
                    System.debug('"main" key not found in API response.');
                }
            } else {
                System.debug('Weather API call failed. Status: ' + response.getStatusCode() + ', Response: ' + response.getBody());
            }
        } catch (Exception e) {
            System.debug('Error fetching weather: ' + e.getMessage());
        }

        System.debug('Method fetchWeatherForContact completed.');
    }
}