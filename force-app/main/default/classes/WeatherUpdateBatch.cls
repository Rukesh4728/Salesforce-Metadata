global class WeatherUpdateBatch implements Database.Batchable<sObject>, Database.AllowsCallouts {
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        String query = 'SELECT Id, MailingCity FROM Contact WHERE MailingCity != NULL';
        System.debug('Batch execution started.');
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext bc, List<Contact> contacts) {
        System.debug('Processing ' + contacts.size() + ' contacts.');

        for (Contact c : contacts) {
            System.debug('Fetching weather for Contact ID: ' + c.Id + ', City: ' + c.MailingCity);
            try {
                WeatherService.fetchWeatherForContact(c.Id);
            } catch (Exception e) {
                System.debug('Error fetching weather for Contact ID: ' + c.Id + '. Message: ' + e.getMessage());
            }
        }
    }

    global void finish(Database.BatchableContext bc) {
        System.debug('Weather update batch completed.');
    }
}