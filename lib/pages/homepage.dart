import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flightplanner/core/bottom_nav_bar.dart';
import 'package:flightplanner/models/FlightData.dart';
import 'package:flightplanner/FlightService.dart';
import 'lennudpage.dart';

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
  double _price = 0.0; // Slider value
  late List<String> _departureCities; // List of departure cities
  late List<String> _destinationCities; // List of destination cities
  String? _selectedDepartureCity;
  String? _selectedDestinationCity;
  DateTime? _selectedDate; // To store the selected date

  @override
  void initState() {
    super.initState();
    _departureCities = []; // Initially empty
    _destinationCities = []; // Initially empty
    _fetchCities(); // Fetch the cities from the backend
  }

  // Fetch cities from backend or database
  Future<void> _fetchCities() async {
    try {
      final flightService = FlightService();
      final flights = await flightService.fetchFlights();
      setState(() {
        // Collect unique departure and destination cities
        _departureCities =
            flights.map((flight) => flight.departure).toSet().toList();
        _destinationCities =
            flights.map((flight) => flight.destination).toSet().toList();
        _selectedDepartureCity =
            _departureCities.isNotEmpty ? _departureCities[0] : null;
        _selectedDestinationCity =
            _destinationCities.isNotEmpty ? _destinationCities[0] : null;
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
      // appBar: AppBar(),
      backgroundColor: Colors.lightBlue,
      body: Column(
        mainAxisAlignment:
            MainAxisAlignment
                .spaceBetween, // Ensure content is at top and bottom
        children: [
          Expanded(
            child: Center(
              child: Text(
                "Flightplanner",
                style: TextStyle(
                  fontSize: 32,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Inter",
                  color: Colors.white,
                ),
              ),
            ), // Empty space to push the container down
          ),
          Container(
            width:
                350, // Set a fixed width for the form to not stretch too wide
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              // borderRadius: BorderRadius.only(
              //   topLeft: Radius.circular(30),
              //   topRight: Radius.circular(30),
              // ),
            ),
            child: Column(
              children: [
                // Departure Dropdown
                DropdownButtonFormField<String>(
                  value: _selectedDepartureCity,
                  isExpanded: true,
                  decoration: inputStyle(
                    "Alguspunkt",
                  ), // Reused inputStyle for consistent styling
                  items:
                      _departureCities.map((city) {
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
                  decoration: inputStyle(
                    "Sihtkoht",
                  ), // Reused inputStyle for consistent styling
                  items:
                      _destinationCities.map((city) {
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
                      decoration: inputStyle(
                        "Kuupäev",
                      ), // Reused inputStyle for consistent styling
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Price Slider
                Text(
                  'Maksimum hind: ${_price.toStringAsFixed(0)}€',
                  style: TextStyle(fontFamily: "Inter"),
                ),
                SliderTheme(
                  data: SliderThemeData(
                    activeTrackColor: Colors.blue.shade300,
                    inactiveTrackColor: Colors.grey.shade100,
                    trackHeight: 8.0,
                    thumbColor: Colors.blue,
                    valueIndicatorColor: Colors.blue,
                  ),
                  child: Slider(
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
                        price: _price.toStringAsFixed(0),
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LennudPage(filteredFlights: flightData),
                        ),
                      );
                    } else {
                      // Show an error message if fields are incomplete
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Palun täitke kõik väljad!'),
                          backgroundColor: Colors.black45,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade400,
                  ),
                  child: const Text(
                    "Otsi Lende",
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Styling for text fields
  InputDecoration inputStyle(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(
        fontFamily: "Inter",
        fontSize: 13,
        color: Colors.grey.shade600,
      ),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black12),
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}
