global class schcallweather implements Schedulable {
    global void execute(SchedulableContext SC) {
        System.debug('Scheduling WeatherUpdateBatch...');
        try {
            Database.executeBatch(new WeatherUpdateBatch(), 1);
            System.debug('WeatherUpdateBatch executed successfully.');
        } catch (Exception e) {
            System.debug('Error scheduling batch job: ' + e.getMessage());
        }
    }
}