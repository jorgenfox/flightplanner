import 'package:flutter/material.dart';
import 'package:flightplanner/core/bottom_nav_bar.dart';

class LennudPage extends StatelessWidget {
  final ValueNotifier<FlightData?> flightDataNotifier;

  const LennudPage({super.key, required this.flightDataNotifier});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Lennud")),
      body: ValueListenableBuilder<FlightData?>(
        valueListenable: flightDataNotifier,
        builder: (context, data, child) {
          if (data == null) {
            return const Center(child: Text("Pole veel otsingut tehtud."));
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text('Alguspunkt: ${data.departure}'),
                Text('Sihtkoht: ${data.destination}'),
                Text('Kuupäev: ${data.date}'),
                Text('Hind: ${data.price}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
