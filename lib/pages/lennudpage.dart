import 'package:flutter/material.dart';
import 'package:flightplanner/core/bottom_nav_bar.dart';

class Flight {
  final String airline;
  final String departureTime;
  final String arrivalTime;
  final double price;

  Flight({required this.airline, required this.departureTime, required this.arrivalTime, required this.price});
}

class LennudPage extends StatelessWidget {
  final ValueNotifier<FlightData?> flightDataNotifier;

  const LennudPage({super.key, required this.flightDataNotifier});

  @override
  Widget build(BuildContext context) {
    final flights = [
      Flight(airline: "Ryanair", departureTime: "08:00", arrivalTime: "11:00", price: 49.99),
      Flight(airline: "Lufthansa", departureTime: "12:00", arrivalTime: "15:00", price: 89.99),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Lennud")),
      body: ValueListenableBuilder<FlightData?>(
        valueListenable: flightDataNotifier,
        builder: (context, data, child) {
          if (data == null) {
            return const Center(child: Text("Pole veel otsingut tehtud."));
          }
          return ListView.builder(
            itemCount: flights.length,
            itemBuilder: (context, index) {
              final flight = flights[index];
              return ListTile(
                title: Text("${flight.airline} - €${flight.price}"),
                subtitle: Text("${flight.departureTime} - ${flight.arrivalTime}"),
                onTap: () {
                  // Navigate to seat selection or booking
                },
              );
            },
          );
        },
      ),
    );
  }
}
