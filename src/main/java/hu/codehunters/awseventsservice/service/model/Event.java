package hu.codehunters.awseventsservice.service.model;

import lombok.*;

import java.time.Instant;
import java.util.Map;

@Value
@Builder
@AllArgsConstructor
@NoArgsConstructor(force = true, access = AccessLevel.PRIVATE)
public class Event {
    EventType eventType;
    Instant timestamp;
    String version;
    String eventId;
    String source;
    String traceId;
    Map<String, Object> data;
}

