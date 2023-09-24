package hu.codehunters.awseventsservice.service;

import hu.codehunters.awseventsservice.dataflow.EventProcessor;
import hu.codehunters.awseventsservice.service.model.Event;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Slf4j
@Service
public class EventProcessorService {

    private final EventProcessor eventProcessor;

    public EventProcessorService(EventProcessor eventProcessor) {
        this.eventProcessor = eventProcessor;
    }

    public void handleEvent(Event event) {
        eventProcessor.process(event);
    }

}
