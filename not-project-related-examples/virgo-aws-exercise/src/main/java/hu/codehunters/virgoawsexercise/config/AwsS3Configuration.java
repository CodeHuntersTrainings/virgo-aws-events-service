package hu.codehunters.virgoawsexercise.config;

import com.amazonaws.auth.DefaultAWSCredentialsProviderChain;
import com.amazonaws.regions.Regions;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class AwsS3Configuration {

    @Bean
    public AmazonS3 amazonS3Client() {
        return AmazonS3ClientBuilder
                .standard()
                .withCredentials(DefaultAWSCredentialsProviderChain.getInstance())
                .withRegion(Regions.EU_CENTRAL_1)
                .build();
    }

}
