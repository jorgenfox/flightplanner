// lib/core/bottom_nav_bar.dart

import 'package:flutter/material.dart';
import 'package:flightplanner/pages/homepage.dart';
import 'package:flightplanner/pages/lennudpage.dart';
import 'package:flightplanner/pages/istekohadpage.dart';
import 'package:flightplanner/pages/ticketpage.dart';
import 'package:flightplanner/models/FlightData.dart';

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
      LennudPage(), // LennudPage kasutamine
      istekohadpage(),
      TicketsScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() {
          _currentIndex = index;
        }),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Otsing"),
          BottomNavigationBarItem(icon: Icon(Icons.flight), label: "Lennud"),
          BottomNavigationBarItem(icon: Icon(Icons.event_seat), label: "Istekohad"),
          BottomNavigationBarItem(icon: Icon(Icons.airplane_ticket), label: 'Piletid'),
        ],
      ),
    );
  }
}
