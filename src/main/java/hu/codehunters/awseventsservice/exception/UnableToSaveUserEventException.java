package hu.codehunters.awseventsservice.exception;

public class UnableToSaveUserEventException extends RuntimeException {
    public UnableToSaveUserEventException() {
    }

    public UnableToSaveUserEventException(String s) {
        super(s);
    }

    public UnableToSaveUserEventException(String message, Throwable cause) {
        super(message, cause);
    }

    public UnableToSaveUserEventException(Throwable cause) {
        super(cause);
    }
}
