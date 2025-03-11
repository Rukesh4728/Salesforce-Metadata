public class WeatherDataScheduler implements Schedulable {
    public void execute(SchedulableContext ctx) {
        OpenWeatherMapService.fetchWeatherData();
    }
}