package hu.codehunters.awseventsservice.dataflow.reporting.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import hu.codehunters.awseventsservice.dataflow.EventProcessor;
import hu.codehunters.awseventsservice.dataflow.reporting.repository.UserEventEntity;
import hu.codehunters.awseventsservice.dataflow.reporting.repository.UserEventRepository;
import hu.codehunters.awseventsservice.exception.MissingUserIdException;
import hu.codehunters.awseventsservice.exception.UnableToSaveUserEventException;
import hu.codehunters.awseventsservice.service.model.Event;
import hu.codehunters.awseventsservice.service.model.EventType;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Profile;
import org.springframework.stereotype.Component;

import java.util.EnumSet;

@Slf4j
@Component
@Profile("reporting")
public class PersistDataInDatabaseService implements EventProcessor {

    private static final String userIdFieldName = "userId";

    private static final EnumSet<EventType> ACCEPTED_EVENTS = EnumSet.of(
            EventType.USER_CREATED,
            EventType.USER_DELETED
    );

    private final ObjectMapper objectMapper;

    private final UserEventRepository repository;

    public PersistDataInDatabaseService(ObjectMapper objectMapper,
                                        UserEventRepository repository) {
        this.objectMapper = objectMapper;
        this.repository = repository;
    }

    @Override
    public void process(Event event) {
        if (!ACCEPTED_EVENTS.contains(event.getEventType())) {
            //We simply ignore the irrelevant messages
            log.warn("Unsupported Event Type in Reporting Data Flow");
            return;
        }

        if (!event.getData().containsKey(userIdFieldName)) {
            log.error("Unable to process event {} in Reporting, userId missing.", event.getEventId());
            throw new MissingUserIdException("Unable to process event in Reporting, userId missing.");
        }

        saveDataToRds(event);

        log.info("Number of all data in the database: {}", repository.count());
    }

    private void saveDataToRds(Event event) {
        try {
            UserEventEntity userEventEntity = UserEventEntity.of(
                    event.getEventId(),
                    event.getEventType().name(),
                    event.getTimestamp(),
                    (String) event.getData().get(userIdFieldName),
                    objectMapper.writeValueAsString(event.getData())
            );

            repository.save(userEventEntity);

        } catch (JsonProcessingException e) {
            log.error("Unable to save event {} in Reporting, parsing data to JSON failed.", event.getEventId());
            throw new UnableToSaveUserEventException("Unable to save event in Reporting, parsing data to JSON failed.", e);
        }
    }

}
