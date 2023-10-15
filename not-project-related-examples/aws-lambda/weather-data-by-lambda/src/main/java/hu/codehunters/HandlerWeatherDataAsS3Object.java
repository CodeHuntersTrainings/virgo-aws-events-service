package hu.codehunters;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.LambdaLogger;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.amazonaws.services.lambda.runtime.events.S3Event;

import java.util.Map;

public class HandlerWeatherDataAsS3Object implements RequestHandler<S3Event, WeatherData> {

    private final Map<String, WeatherData> weatherDataByLocation = Map.of(
            "Hungary", new WeatherData(24, 120, 5D, 1),
            "Germany", new WeatherData(15, 99, 1D, 2),
            "Italy", new WeatherData(30, 70, 10D, 5)
    );

    @Override
    public WeatherData handleRequest(S3Event s3Event, Context context) {
        LambdaLogger logger = context.getLogger();
        logger.log("S3Event has been received, key=" + s3Event.getRecords().get(0).getS3().getObject().getKey());

        return weatherDataByLocation.get(s3Event.getRecords().get(0).getS3().getObject().getKey());
    }

}
