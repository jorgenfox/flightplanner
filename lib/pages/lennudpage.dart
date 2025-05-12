import 'istekohadpage.dart';
import 'package:flutter/material.dart';
import '../models/FlightData.dart';
import '../FlightService.dart';
import '../state/ticket_store.dart';



class LennudPage extends StatelessWidget {
  final FlightData? filteredFlights;  // Filtreeritud lennud

  const LennudPage({super.key, required this.filteredFlights});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text("Lennud"),
      ),
      body: FutureBuilder<List<FlightData>>(
        future: FlightService().fetchFlights(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Viga andmete laadimisel: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Pole andmeid leitud"));
          }

          // Filtreerime andmed vastavalt sellele, mida on otsitud
          final flightsToDisplay = (filteredFlights == null)
              ? snapshot.data! // Kui pole otsingut, siis kõik lennud
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
                                'Alguspunkt: ${flight.departure}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Sihtkoht: ${flight.destination}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Kuupäev: ${flight.date}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Hind: ${flight.price}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        // Nupp "Select" paremal
                        TextButton(
                          onPressed: () {
                            TicketStore().selectedFlight = flight;
                            // Siin liigume IstekohadPage-le, edastades "flight" andmed
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
