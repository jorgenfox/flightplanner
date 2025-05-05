import 'package:flutter/material.dart';
import 'package:flightplanner/core/bottom_nav_bar.dart';

class HomePage extends StatefulWidget {
  final Function(FlightData) onSearch;

  const HomePage({super.key, required this.onSearch});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _departureController = TextEditingController();
  final _destinationController = TextEditingController();
  final _dateController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Lennuotsing")),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _departureController,
              decoration: inputStyle("Alguspunkt"),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _destinationController,
              decoration: inputStyle("Sihtkoht"),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _dateController,
              decoration: inputStyle("Kuupäev"),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _priceController,
              decoration: inputStyle("Hind"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final flightData = FlightData(
                  departure: _departureController.text,
                  destination: _destinationController.text,
                  date: _dateController.text,
                  price: _priceController.text,
                );
                widget.onSearch(flightData);
              },
              child: const Text("Otsi Lende"),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration inputStyle(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.grey[200],
      border: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
      ),
    );
  }
}
