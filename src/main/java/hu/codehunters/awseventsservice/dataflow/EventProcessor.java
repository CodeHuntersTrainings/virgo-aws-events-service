package hu.codehunters.awseventsservice.dataflow;

import hu.codehunters.awseventsservice.service.model.Event;

public interface EventProcessor {
    void process(Event event);
}
