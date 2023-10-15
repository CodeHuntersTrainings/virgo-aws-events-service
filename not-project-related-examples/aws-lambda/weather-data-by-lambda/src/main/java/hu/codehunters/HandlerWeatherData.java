package hu.codehunters;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.LambdaLogger;
import com.amazonaws.services.lambda.runtime.RequestHandler;

import java.util.Map;

public class HandlerWeatherData implements RequestHandler<String, WeatherData> {

    private final Map<String, WeatherData> weatherDataByLocation = Map.of(
            "Hungary", new WeatherData(24, 120, 5D, 1),
            "Germany", new WeatherData(15, 99, 1D, 2),
            "Italy", new WeatherData(30, 70, 10D, 5)
    );

    @Override
    public WeatherData handleRequest(String location, Context context) {
        LambdaLogger logger = context.getLogger();
        logger.log("Requested location: " + location);

        return weatherDataByLocation.get(location);
    }

}
