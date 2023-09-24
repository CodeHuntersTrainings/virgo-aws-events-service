CREATE TABLE IF NOT EXISTS codehunters.user_events (
    eventId text PRIMARY KEY,
    eventType text,
    eventDatetime timestamp,
    userId text,
    data text
);