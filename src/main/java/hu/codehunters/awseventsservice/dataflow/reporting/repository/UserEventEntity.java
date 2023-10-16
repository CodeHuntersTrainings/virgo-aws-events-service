package hu.codehunters.awseventsservice.dataflow.reporting.repository;


import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.Instant;


@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "user_events")
public class UserEventEntity {

    @Id
    @Column(name = "event_id")
    private String eventId;

    @Column(name = "event_type")
    private String eventType;

    @Column(name = "event_datetime")
    private Instant timestamp;

    @Column(name = "user_id")
    private String userId;

    @Column(name = "data")
    private String data;

    public static UserEventEntity of(String eventId,
                                     String eventType,
                                     Instant timestamp,
                                     String userId,
                                     String data) {
        UserEventEntity entity = new UserEventEntity();
        entity.setEventId(eventId);
        entity.setEventType(eventType);
        entity.setTimestamp(timestamp);
        entity.setUserId(userId);
        entity.setData(data);

        return entity;
    }
}
