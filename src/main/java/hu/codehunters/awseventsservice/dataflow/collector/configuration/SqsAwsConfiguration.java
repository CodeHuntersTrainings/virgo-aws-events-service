package hu.codehunters.awseventsservice.dataflow.collector.configuration;

import com.amazonaws.auth.DefaultAWSCredentialsProviderChain;
import com.amazonaws.client.builder.AwsClientBuilder;
import com.amazonaws.services.sqs.AmazonSQS;
import com.amazonaws.services.sqs.AmazonSQSClient;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;

@Configuration
@Profile("collector")
public class SqsAwsConfiguration {

    @Bean
    public AmazonSQS amazonSqsClient(@Value(value = "${events-service.flows.collector.sqs.url}") String sqsUrl) {
        return AmazonSQSClient.builder()
                .withCredentials(DefaultAWSCredentialsProviderChain.getInstance())
                //TODO: the region can be a configuration value
                .withEndpointConfiguration(new AwsClientBuilder.EndpointConfiguration(sqsUrl, "eu-central-1"))
                .build();
    }

}
