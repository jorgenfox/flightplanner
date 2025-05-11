import 'package:flutter/material.dart';
import '../models/FlightData.dart';
import '../FlightService.dart';

class LennudPage extends StatefulWidget {
  const LennudPage({super.key});

  @override
  _LennudPageState createState() => _LennudPageState();
}

class _LennudPageState extends State<LennudPage> {
  late Future<List<FlightData>> _flights;

  @override
  void initState() {
    super.initState();
    // Fetch flights from the server
    _flights = FlightService().fetchFlights();
  }

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
        future: _flights,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Viga andmete laadimisel: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Pole andmeid leitud"));
          }

          final flights = snapshot.data!;

          return ListView.builder(
            itemCount: flights.length,
            itemBuilder: (context, index) {
              final flight = flights[index];
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Alguspunkt: ${flight.departure}'),
                    Text('Sihtkoht: ${flight.destination}'),
                    Text('Kuupäev: ${flight.date}'),
                    Text('Hind: ${flight.price}'),
                    const SizedBox(height: 16),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
