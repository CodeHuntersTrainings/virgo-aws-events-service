package hu.codehunters.awseventsservice.dataflow.backup.service;

import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.PutObjectRequest;
import com.amazonaws.services.s3.model.PutObjectResult;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import hu.codehunters.awseventsservice.dataflow.EventProcessor;
import hu.codehunters.awseventsservice.service.model.Event;
import hu.codehunters.awseventsservice.service.model.EventType;
import io.micrometer.core.instrument.Counter;
import io.micrometer.core.instrument.MeterRegistry;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Profile;
import org.springframework.stereotype.Component;

import java.io.ByteArrayInputStream;
import java.util.Optional;

@Slf4j
@Component
@Profile("backup")
public class StoreDataOnS3Service implements EventProcessor {

    private final ObjectMapper objectMapper;

    private final AmazonS3 amazonS3Client;

    private final String s3BucketName;

    private final Counter storedDataCounter;

    public StoreDataOnS3Service(ObjectMapper objectMapper,
                                AmazonS3 amazonS3Client,
                                @Value(value = "${events-service.flows.backup.bucket-name}") String s3BucketName,
                                MeterRegistry meterRegistry) {
        this.objectMapper = objectMapper;
        this.amazonS3Client = amazonS3Client;
        this.s3BucketName = s3BucketName;

        storedDataCounter = meterRegistry.counter("events.s3.stored");
    }

    @Override
    public void process(Event event) {
        storeEventAsJson(event);
    }

    private void storeEventAsJson(Event event) {
        convertToJson(event).ifPresent(jsonData -> {
            try {
                String key = generateS3Key(event.getSource(), event.getEventType(), event.getEventId()).toLowerCase();
                storeJsonOnS3(jsonData, key);
            } catch (Exception e) {
                //If we cannot send it, we ignore it ...
                log.warn("Unable to store Event {} to S3", event.getEventId(), e);
                throw new RuntimeException(e); //TODO: improve error handling
            }
        });
    }

    private String generateS3Key(String source, EventType eventType, String eventId) {
        return String.format("source=%s/type=%s/%s.json",
                source, eventType, eventId);
    }

    private Optional<String> convertToJson(Event event) {
        try {
            return Optional.of(objectMapper.writeValueAsString(event));

        } catch (JsonProcessingException e) {
            log.warn("Unable to construct JSON from event {}", event.getEventId());
            return Optional.empty();
        }
    }

    private void storeJsonOnS3(String json, String key) {
        byte[] contentBytes = json.getBytes();
        ObjectMetadata metadata = new ObjectMetadata();
        metadata.setContentLength(contentBytes.length);
        metadata.setContentType("application/json");

        PutObjectRequest request = new PutObjectRequest(
                s3BucketName,
                key,
                new ByteArrayInputStream(contentBytes),
                metadata
        );

        PutObjectResult putObjectResult = amazonS3Client.putObject(request);

        log.info("Event versionID={} has been sent to S3", putObjectResult.getMetadata().getVersionId());

        storedDataCounter.increment();
    }

}
