import 'SeatingPage.dart';
import 'package:flutter/material.dart';
import '../models/FlightData.dart';
import '../FlightService.dart';
import '../state/ticket_store.dart';

// Stateless widget for displaying available flights
class LennudPage extends StatelessWidget {
  final FlightData? filteredFlights;  // Filtered flights

  const LennudPage({super.key, required this.filteredFlights});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text("Flights"),
      ),
      body: FutureBuilder<List<FlightData>>(
        future: FlightService().fetchFlights(),
        builder: (context, snapshot) {
          // Display a loading indicator while fetching data
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Handle errors during data fetching
          if (snapshot.hasError) {
            return Center(
              child: Text('Error loading data: ${snapshot.error}'),
            );
          }

          // Handle case where no data is available
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No data found"));
          }

          // Filter flights based on search criteria
          final flightsToDisplay = (filteredFlights == null)
              ? snapshot.data! // Show all flights if no filter is applied
              : snapshot.data!.where((flight) {
            bool matchesDeparture = flight.departure == filteredFlights!.departure;
            bool matchesDestination = flight.destination == filteredFlights!.destination;
            bool matchesDate = flight.date == filteredFlights!.date;
            bool matchesPrice = double.tryParse(flight.price)! <= double.parse(filteredFlights!.price);
            return matchesDeparture && matchesDestination && matchesDate && matchesPrice;
          }).toList();

          return ListView.builder(
            itemCount: flightsToDisplay.length,
            itemBuilder: (context, index) {
              final flight = flightsToDisplay[index];

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  elevation: 5,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Departure: ${flight.departure}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Destination: ${flight.destination}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Date: ${flight.date}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Price: ${flight.price}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        // Button to select a flight and proceed to seat selection
                        TextButton(
                          onPressed: () {
                            TicketStore().selectedFlight = flight;
                            // Navigate to the seat selection page, passing flight data
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => istekohadPage(),
                              ),
                            );
                          },
                          child: Text(
                            'Select',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}