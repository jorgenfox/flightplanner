package ee.flightbackend;
import ee.flightbackend.FlightEntity;
import ee.flightbackend.FlightRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController

@CrossOrigin
public class FlightController {

    @Autowired
    private FlightRepository flightRepository;

    @PostMapping("lennud")
    public List<FlightEntity> addFlights(@RequestBody FlightEntity flight) {
        flightRepository.save(flight);
        return flightRepository.findAll();
    }

    @GetMapping("lennud")
    public List<FlightEntity> getFlights() {
        return flightRepository.findAll();
    }
}
