package hu.codehunters.awseventsservice.dataflow.collector.service;

import com.amazonaws.services.sqs.AmazonSQS;
import com.amazonaws.services.sqs.model.SendMessageRequest;
import com.amazonaws.services.sqs.model.SendMessageResult;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import hu.codehunters.awseventsservice.dataflow.EventProcessor;
import hu.codehunters.awseventsservice.exception.JsonNotParsableException;
import hu.codehunters.awseventsservice.service.model.Event;
import io.micrometer.core.instrument.Counter;
import io.micrometer.core.instrument.MeterRegistry;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Profile;
import org.springframework.stereotype.Component;

@Slf4j
@Component
@Profile("collector")
public class PublishEventToQueueService implements EventProcessor {

    private final AmazonSQS amazonSqsClient;

    private final ObjectMapper objectMapper;

    private final String sqsUrl;

    private final String queue;

    public PublishEventToQueueService(AmazonSQS amazonSqsClient,
                                      ObjectMapper objectMapper,
                                      @Value(value = "${events-service.flows.collector.sqs.url}") String sqsUrl,
                                      @Value(value = "${events-service.flows.collector.sqs.queue}") String queue) {
        this.amazonSqsClient = amazonSqsClient;
        this.objectMapper = objectMapper;
        this.sqsUrl = sqsUrl;
        this.queue = queue;
    }

    @Override
    public void process(Event event) {
        sendEventToSqs(event);
    }

    private void sendEventToSqs(Event event) {
        try {
            SendMessageRequest sendMessageRequest = new SendMessageRequest()
                    .withQueueUrl(sqsUrl + queue)
                    .withMessageBody(objectMapper.writeValueAsString(event));

            SendMessageResult sendMessageResult = amazonSqsClient.sendMessage(sendMessageRequest);

            log.info("Message {} has been sent", sendMessageResult.getMessageId());

            //TODO: implement proper error handling
        } catch (JsonProcessingException e) {
            log.error("Unable to send Event {} to SQS", event.getEventId(), e);
            throw new JsonNotParsableException(e);

        } catch (Exception e) {
            //If we cannot send it, we ignore it ...
            log.warn("Unable to send Event {} to SQS", event.getEventId(), e);
        }
    }
}

// To receive messages: List<Message> messages = sqsClient.receiveMessage(queueUrl).getMessages();
// Every message has a body ..., a method can be wrapped into @Scheduled(fixedDelay = 5000)
