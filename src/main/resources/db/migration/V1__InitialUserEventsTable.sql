CREATE TABLE IF NOT EXISTS user_events (
    event_id text PRIMARY KEY,
    event_type text,
    event_datetime timestamp,
    user_id text,
    data text
);