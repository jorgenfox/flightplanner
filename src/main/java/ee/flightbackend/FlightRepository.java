package ee.flightbackend;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import ee.flightbackend.FlightEntity;

@Repository
public interface FlightRepository extends JpaRepository<FlightEntity, Long>{
}
