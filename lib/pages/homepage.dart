import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

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
        color: Colors.white, // Seadistame taustavärviks valge
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Keeps the column compact
          children: [
            // Alguspunkti sisendväli
            TextField(
              controller: _departureController,
              decoration: InputDecoration(
                labelText: 'Alguspunkt',
                filled: true,
                fillColor: Colors.grey[200], // Hall taust
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black), // Must piirjoon
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Sihtkoha sisendväli
            TextField(
              controller: _destinationController,
              decoration: InputDecoration(
                labelText: 'Sihtkoht',
                filled: true,
                fillColor: Colors.grey[200], // Hall taust
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black), // Must piirjoon
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Kuupäeva sisendväli
            TextField(
              controller: _dateController,
              decoration: InputDecoration(
                labelText: 'Kuupäev',
                filled: true,
                fillColor: Colors.grey[200], // Hall taust
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black), // Must piirjoon
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Hinna sisendväli
            TextField(
              controller: _priceController,
              decoration: InputDecoration(
                labelText: 'Hind',
                filled: true,
                fillColor: Colors.grey[200], // Hall taust
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black), // Must piirjoon
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),

            // Otsingunupp
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/lennudpage', arguments: {
                  'departure': _departureController.text,
                  'destination': _destinationController.text,
                  'date': _dateController.text,
                  'price': _priceController.text,
                });
              },
              child: const Text("Otsi Lende"),
            ),
          ],
        ),
      ),
    );
  }
}

