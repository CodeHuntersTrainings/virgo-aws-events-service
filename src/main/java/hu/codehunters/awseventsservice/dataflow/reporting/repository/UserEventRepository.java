package hu.codehunters.awseventsservice.dataflow.reporting.repository;

import org.springframework.context.annotation.Profile;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
@Profile("reporting")
public interface UserEventRepository extends JpaRepository<UserEventEntity, String> {
}
