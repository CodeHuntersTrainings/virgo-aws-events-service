package hu.codehunters.awseventsservice.dataflow.backup.service;

import cloud.localstack.Localstack;
import cloud.localstack.docker.LocalstackDockerExtension;
import cloud.localstack.docker.annotation.LocalstackDockerProperties;
import com.amazonaws.auth.DefaultAWSCredentialsProviderChain;
import com.amazonaws.client.builder.AwsClientBuilder;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.S3Object;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import hu.codehunters.awseventsservice.service.model.Event;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.context.TestConfiguration;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Import;
import org.springframework.context.annotation.Primary;
import org.springframework.context.annotation.Profile;


@ExtendWith(LocalstackDockerExtension.class)
@LocalstackDockerProperties(services = { "s3" })
@SpringBootTest
@Profile("backup")
@Import(StoreDataOnS3ServiceTest.S3TestConfiguration.class)
class StoreDataOnS3ServiceTest {

    @TestConfiguration
    static class S3TestConfiguration {

        @Bean
        @Primary
        public AmazonS3 amazonS3Client() {
            return AmazonS3ClientBuilder
                    .standard()
                    .withCredentials(DefaultAWSCredentialsProviderChain.getInstance())
                    .withEndpointConfiguration(new AwsClientBuilder.EndpointConfiguration(
                            Localstack.INSTANCE.getEndpointS3(),
                            "us-east-1"
                            ))
                    //.withCredentials(new AWSStaticCredentialsProvider(new BasicAWSCredentials("access-key", "secret-key")))
                    .build();
        }

    }

    private static final String BUCKET_NAME = "events-store";

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
        amazonS3.deleteObject(BUCKET_NAME, s3Object.getKey());

    }

}

