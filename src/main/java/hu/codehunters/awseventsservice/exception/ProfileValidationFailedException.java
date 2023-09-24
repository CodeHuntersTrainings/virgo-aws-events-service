package hu.codehunters.awseventsservice.exception;

public class ProfileValidationFailedException extends IllegalArgumentException {
    public ProfileValidationFailedException() {
    }

    public ProfileValidationFailedException(String s) {
        super(s);
    }

    public ProfileValidationFailedException(String message, Throwable cause) {
        super(message, cause);
    }

    public ProfileValidationFailedException(Throwable cause) {
        super(cause);
    }
}
