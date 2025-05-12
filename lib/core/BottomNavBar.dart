import 'package:flutter/material.dart';
import 'package:flightplanner/pages/HomePage.dart';
import 'package:flightplanner/pages/FlightsPage.dart';
import 'package:flightplanner/pages/SeatingPage.dart';
import 'package:flightplanner/pages/TicketPage.dart';
import 'package:flightplanner/pages/AccountPage.dart';
import 'package:flightplanner/models/FlightData.dart';

// Stateful widget for the bottom navigation bar
class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  // Tracks the currently selected tab index
  int _currentIndex = 0;
  // Notifier to pass flight data between pages
  final ValueNotifier<FlightData?> flightDataNotifier = ValueNotifier(null);

  // Getter to dynamically create the list of screens for navigation
  List<Widget> get _screens => [
    HomePage(
      onSearch: (data) {
        flightDataNotifier.value = data;
        setState(() {
          _currentIndex = 1; // Navigate to LennudPage when search is performed
        });
      },
    ),
    ValueListenableBuilder<FlightData?>(
      valueListenable: flightDataNotifier,
      builder: (context, flightData, child) {
        // Display an empty container or placeholder if no flight data is available
        if (flightData == null) {
          return LennudPage(filteredFlights: null);
        }
        return LennudPage(filteredFlights: flightData);
      },
    ),
    istekohadPage(),
    TicketPage(),
    AccountPage(),
  ];

  @override
  void initState() {
    super.initState();
    // No need to initialize _screens here as the getter handles it
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Display the currently selected screen
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: const TextStyle(fontFamily: "Inter", fontSize: 15),
        type: BottomNavigationBarType.shifting,
        elevation: 0,
        currentIndex: _currentIndex,
        onTap: (index) => setState(() {
          _currentIndex = index; // Update the selected tab index
        }),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Search",
            backgroundColor: Colors.lightBlue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.flight),
            label: "Flights",
            backgroundColor: Colors.lightBlue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_seat),
            label: "Seats",
            backgroundColor: Colors.lightBlue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.airplane_ticket),
            label: "Tickets",
            backgroundColor: Colors.lightBlue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Account",
            backgroundColor: Colors.lightBlue,
          ),
        ],
      ),
    );
  }
}