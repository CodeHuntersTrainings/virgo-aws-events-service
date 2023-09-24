package hu.codehunters.awseventsservice.controller.dto;

import hu.codehunters.awseventsservice.service.model.Event;
import lombok.*;

@Value
@Builder
@AllArgsConstructor
@NoArgsConstructor(force = true, access = AccessLevel.PRIVATE)
public class EventDto {
    Event event;
}
