package hu.codehunters.virgoawsexercise.controller;

import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.PutObjectRequest;
import com.amazonaws.services.s3.model.PutObjectResult;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.ByteArrayInputStream;
import java.util.UUID;

@Slf4j
@RestController
@RequestMapping(path = "s3")
public class S3RestController {

    private final AmazonS3 amazonS3Client;

    public S3RestController(AmazonS3 amazonS3Client) {
        this.amazonS3Client = amazonS3Client;
    }

    @PostMapping
    public void createS3Object() {
        String objectContent = """
            {
              "eventType": "AD_CREATED",
              "timestamp": "2023-08-10T15:30:00Z",
              "version": "v1"
            }
            """;

        byte[] contentBytes = objectContent.getBytes();
        ObjectMetadata metadata = new ObjectMetadata();
        metadata.setContentLength(contentBytes.length);
        metadata.setContentType("application/json");

        PutObjectRequest request = new PutObjectRequest(
                "czirjak-s3-exercise",
                UUID.randomUUID().toString(),
                new ByteArrayInputStream(contentBytes), metadata);

        PutObjectResult putObjectResult = amazonS3Client.putObject(request);

        log.info("Data versionID={} has been sent to S3", putObjectResult.getMetadata().getVersionId());
    }

}
