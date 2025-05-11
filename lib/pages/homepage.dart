import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flightplanner/core/bottom_nav_bar.dart';
import 'package:flightplanner/models/FlightData.dart';
import 'package:flightplanner/FlightService.dart';

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
  double _price = 0.0;  // Slider value
  late List<String> _departureCities;  // List of departure cities
  late List<String> _destinationCities;  // List of destination cities
  String? _selectedDepartureCity;
  String? _selectedDestinationCity;
  DateTime? _selectedDate;  // To store the selected date

  @override
  void initState() {
    super.initState();
    _departureCities = [];  // Initially empty
    _destinationCities = [];  // Initially empty
    _fetchCities();  // Fetch the cities from the backend
  }

  // Fetch cities from backend or database
  Future<void> _fetchCities() async {
    try {
      final flightService = FlightService();
      final flights = await flightService.fetchFlights();
      setState(() {
        // Collect unique departure and destination cities
        _departureCities = flights.map((flight) => flight.departure).toSet().toList();
        _destinationCities = flights.map((flight) => flight.destination).toSet().toList();
        _selectedDepartureCity = _departureCities.isNotEmpty ? _departureCities[0] : null;
        _selectedDestinationCity = _destinationCities.isNotEmpty ? _destinationCities[0] : null;
      });
    } catch (e) {
      print('Error fetching cities: $e');
    }
  }

  // Show date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('yyyy-MM-dd').format(_selectedDate!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Lennuotsing")),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Departure Dropdown
            DropdownButtonFormField<String>(
              value: _selectedDepartureCity,
              isExpanded: true,
              decoration: InputDecoration(
                labelText: "Alguspunkt", // Label for departure
                filled: true,
                fillColor: Colors.grey[200],
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
              items: _departureCities.map((city) {
                return DropdownMenuItem<String>(
                  value: city,
                  child: Text(city),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedDepartureCity = newValue;
                });
              },
            ),
            const SizedBox(height: 16),

            // Destination Dropdown
            DropdownButtonFormField<String>(
              value: _selectedDestinationCity,
              isExpanded: true,
              decoration: InputDecoration(
                labelText: "Sihtkoht", // Label for destination
                filled: true,
                fillColor: Colors.grey[200],
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
              items: _destinationCities.map((city) {
                return DropdownMenuItem<String>(
                  value: city,
                  child: Text(city),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedDestinationCity = newValue;
                });
              },
            ),
            const SizedBox(height: 16),

            // Date Field with Date Picker
            GestureDetector(
              onTap: () => _selectDate(context),
              child: AbsorbPointer(
                child: TextField(
                  controller: _dateController,
                  decoration: inputStyle("Kuupäev"),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Price Slider
            Text('Hind: ${_price.toStringAsFixed(0)}€'),
            Slider(
              value: _price,
              min: 0,
              max: 1000,
              divisions: 1000,
              label: _price.toStringAsFixed(0),
              onChanged: (double value) {
                setState(() {
                  _price = value;
                });
              },
            ),
            const SizedBox(height: 16),

            // Search Button
            ElevatedButton(
              onPressed: () {
                if (_selectedDepartureCity != null &&
                    _selectedDestinationCity != null &&
                    _dateController.text.isNotEmpty) {
                  final flightData = FlightData(
                    departure: _selectedDepartureCity!,
                    destination: _selectedDestinationCity!,
                    date: _dateController.text,
                    price: _price.toStringAsFixed(0), // Convert the price to string
                  );
                  widget.onSearch(flightData);
                } else {
                  // Show an error message if fields are incomplete
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Palun täitke kõik väljad!')),
                  );
                }
              },
              child: const Text("Otsi Lende"),
            ),
          ],
        ),
      ),
    );
  }

  // Styling for text fields
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
