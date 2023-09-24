package hu.codehunters.awseventsservice.dataflow.backup.service;

import cloud.localstack.docker.annotation.LocalstackDockerProperties;
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
@LocalstackDockerProperties(services = { "s3" })
@Profile("backup")
class StoreDataOnS3ServiceTest {

    private static final String BUCKET_NAME = "events-store";

    @Autowired
    private StoreDataOnS3Service storeDataOnS3Service;

    @Autowired
    private ObjectMapper objectMapper;

    @Autowired
    private AmazonS3 amazonS3;

    @BeforeEach
    void runBeforeEach() {
        //TODO: create bucket
    }

    @AfterEach
    void runAfterEach() {
        //TODO: delete bucket
    }

    @Test
    @Disabled //TODO: remove this
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

        String bucketName = " ??? "; //TODO: fill the bucket name

        String objectKey = "source=ebay/type=ad_created/ad-created-123456.json";

        Event input = objectMapper.readValue(eventAsString, Event.class);

        // When
        storeDataOnS3Service.process(input);

        // Then
        S3Object s3Object = null; //TODO: getObject ...
        Assertions.assertNotNull(s3Object);

        //TODO: delete object

    }

}