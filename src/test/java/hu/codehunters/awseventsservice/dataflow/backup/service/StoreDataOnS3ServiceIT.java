package hu.codehunters.awseventsservice.dataflow.backup.service;

import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.S3Object;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import hu.codehunters.awseventsservice.service.model.Event;
import org.junit.jupiter.api.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.context.annotation.Profile;


@SpringBootTest
@Profile("backup")
class StoreDataOnS3ServiceIT {

    private static final String BUCKET_NAME = "czirjak-test-events-store";

    @Autowired
    private StoreDataOnS3Service storeDataOnS3Service;

    @Autowired
    private ObjectMapper objectMapper;

    @Autowired
    private AmazonS3 amazonS3;

    @BeforeEach
    void runBeforeEach() {
        amazonS3.createBucket(BUCKET_NAME);
    }

    @AfterEach
    void runAfterEach() {
        amazonS3.deleteBucket(BUCKET_NAME);
    }

    @Test
    @Disabled
    void given_event_when_processed_then_must_be_put_on_s3() throws JsonProcessingException {
        // Given
        String eventAsString = """
                {
                  "eventType": "AD_CREATED",
                  "timestamp": "2023-08-10T15:30:00Z",
                  "version": "v1",
                  "eventId": "ad-created-123456",
                  "source": "ebay",
                  "traceId": "1234-abc-1234",
                  "data": {
                    "adId": "123",
                    "category": "house",
                    "userId": "user123",
                    "description": "This is a description ..."
                  }
                }
                """;

        String objectKey = "source=ebay/type=ad_created/ad-created-123456.json";

        Event input = objectMapper.readValue(eventAsString, Event.class);

        // When
        storeDataOnS3Service.process(input);

        // Then
        S3Object s3Object = amazonS3.getObject(BUCKET_NAME, objectKey);
        Assertions.assertNotNull(s3Object);

        // Cleanup
        amazonS3.deleteObject(BUCKET_NAME, objectKey);

    }

}