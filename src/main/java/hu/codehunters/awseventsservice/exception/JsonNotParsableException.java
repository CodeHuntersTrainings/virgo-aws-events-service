package hu.codehunters.awseventsservice.exception;

public class JsonNotParsableException extends IllegalArgumentException {
    public JsonNotParsableException() {
    }

    public JsonNotParsableException(String s) {
        super(s);
    }

    public JsonNotParsableException(String message, Throwable cause) {
        super(message, cause);
    }

    public JsonNotParsableException(Throwable cause) {
        super(cause);
    }
}
