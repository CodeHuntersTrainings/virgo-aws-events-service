package hu.codehunters.awseventsservice.service;

import hu.codehunters.awseventsservice.exception.ProfileValidationFailedException;
import jakarta.annotation.PostConstruct;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import org.springframework.core.env.Environment;

import java.util.Arrays;
import java.util.List;
import java.util.Set;

@Slf4j
@Service
public class ProfileValidator {

    private static final int MAX_NR_OF_PROFILES = 1;

    private final Environment environment;

    private final Set<String> allowedProfiles = Set.of(
            "backup",
            "collector",
            "reporting"
    );

    public ProfileValidator(Environment environment) {
        this.environment = environment;
    }

    @PostConstruct
    public void postConstruct() {
        validateProfile();
    }

    public void validateProfile() {
        List<String> activeProfiles = Arrays.asList(environment.getActiveProfiles());

        if (activeProfiles.size() != MAX_NR_OF_PROFILES) {
            log.error("Exactly one profile must be active, active profiles {}", activeProfiles);
            throw new ProfileValidationFailedException();
        }

        String activeProfile = activeProfiles.get(0);

        if (!allowedProfiles.contains(activeProfile)) {
            log.error("Invalid profile: {}", activeProfile);
            throw new ProfileValidationFailedException();
        }

    }
}
