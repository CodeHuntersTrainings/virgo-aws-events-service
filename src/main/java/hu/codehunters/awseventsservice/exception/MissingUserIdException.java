package hu.codehunters.awseventsservice.exception;

public class MissingUserIdException extends IllegalArgumentException {
    public MissingUserIdException() {
    }

    public MissingUserIdException(String s) {
        super(s);
    }

    public MissingUserIdException(String message, Throwable cause) {
        super(message, cause);
    }

    public MissingUserIdException(Throwable cause) {
        super(cause);
    }
}
