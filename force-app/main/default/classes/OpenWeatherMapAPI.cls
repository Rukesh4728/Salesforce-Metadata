public with sharing class OpenWeatherMapAPI {
    @AuraEnabled
    public static string getWeather(string city, string apiKey) {
        String endpoint = 'https://api.openweathermap.org/data/2.5/weather?q=' +  EncodingUtil.urlEncode(city, 'UTF-8') + '&appid=' + apiKey + '&units=metric';

        // Creating HTTP request
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint);
        request.setMethod('GET');

        try {
            // Sending request
            HttpResponse response = http.send(request);

            // Logging the response
            if (response.getStatusCode() == 200) {
                return response.getBody();
            } else {
                return '{"error": "' + response.getStatus() + ' - ' + response.getBody() + '"}';
            }
        } catch (Exception e) {
            return '{"error": "Exception: ' + e.getMessage() + '"}';
        }
    }
}