package hu.codehunters;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.LambdaLogger;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.amazonaws.services.lambda.runtime.events.S3Event;

public class S3EventHandler implements RequestHandler<S3Event, S3ObjectPublishedEvent> {

    @Override
    public S3ObjectPublishedEvent handleRequest(S3Event s3Event, Context context) {
        LambdaLogger logger = context.getLogger();
        logger.log("S3Event has been received, key=" + s3Event.getRecords().get(0).getS3().getObject().getKey());

        return new S3ObjectPublishedEvent(
                s3Event.getRecords().get(0).getEventTime().toInstant(),
                s3Event.getRecords().get(0).getS3().getBucket().getName(),
                s3Event.getRecords().get(0).getS3().getObject().getKey()
        );
    }

}
