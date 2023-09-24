package hu.codehunters.awseventsservice.controller;

import hu.codehunters.awseventsservice.controller.dto.EventDto;
import hu.codehunters.awseventsservice.service.EventProcessorService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@RequestMapping("events")
public class EventController {

    private final EventProcessorService eventProcessorService;

    public EventController(EventProcessorService eventProcessorService) {
        this.eventProcessorService = eventProcessorService;
    }

    @PostMapping
    public ResponseEntity<Void> storeEvent(@RequestBody EventDto input) {
        log.info("Event received: {}", input.getEvent().getEventId());

        eventProcessorService.handleEvent(input.getEvent());
        return ResponseEntity.ok().build();
    }
}