import 'package:flutter/material.dart';
import 'package:flightplanner/pages/homepage.dart';
import 'package:flightplanner/pages/lennudpage.dart';
import 'package:flightplanner/pages/istekohadpage.dart';

class FlightData {
  final String departure;
  final String destination;
  final String date;
  final String price;

  FlightData({
    required this.departure,
    required this.destination,
    required this.date,
    required this.price,
  });
}

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;
  final ValueNotifier<FlightData?> flightDataNotifier = ValueNotifier(null);

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      HomePage(
        onSearch: (data) {
          flightDataNotifier.value = data;
          setState(() {
            _currentIndex = 1; // switch to LennudPage
          });
        },
      ),
      LennudPage(flightDataNotifier: flightDataNotifier),
      istekohadpage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap:
            (index) => setState(() {
              _currentIndex = index;
            }),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Otsing"),
          BottomNavigationBarItem(icon: Icon(Icons.flight), label: "Lennud"),
          BottomNavigationBarItem(icon: Icon(Icons.event_seat),label: "Istekohad"), //Testimiseks siin
        ],
      ),
    );
  }
}
