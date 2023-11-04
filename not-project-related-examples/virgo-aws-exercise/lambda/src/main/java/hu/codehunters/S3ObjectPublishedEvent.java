package hu.codehunters;

import org.joda.time.Instant;

import java.util.Objects;

public class S3ObjectPublishedEvent {

    private Instant timestamp;
    private String bucket;
    private String key;

    public S3ObjectPublishedEvent() {

    }

    public S3ObjectPublishedEvent(Instant timestamp, String bucket, String key) {
        this.timestamp = timestamp;
        this.bucket = bucket;
        this.key = key;
    }

    public Instant getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(Instant timestamp) {
        this.timestamp = timestamp;
    }

    public String getBucket() {
        return bucket;
    }

    public void setBucket(String bucket) {
        this.bucket = bucket;
    }

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        S3ObjectPublishedEvent that = (S3ObjectPublishedEvent) o;
        return Objects.equals(timestamp, that.timestamp) && Objects.equals(bucket, that.bucket) && Objects.equals(key, that.key);
    }

    @Override
    public int hashCode() {
        return Objects.hash(timestamp, bucket, key);
    }

    @Override
    public String toString() {
        return "S3ObjectPublishedEvent{" +
                "timestamp=" + timestamp +
                ", bucket='" + bucket + '\'' +
                ", key='" + key + '\'' +
                '}';
    }
}
