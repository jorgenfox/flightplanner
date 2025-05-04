import 'package:flightplanner/pages/homepage.dart';
import 'package:flightplanner/pages/ticketpage.dart';
import 'package:flightplanner/pages/lennudpage.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final appScreens = [
    const HomePage(),
    const LennudPage(),
    //const TicketPage(),
    const Text("Profile")
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: appScreens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          showSelectedLabels: false,
          selectedItemColor: Colors.blueGrey,
          unselectedItemColor: const Color(0xFF526400),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(FluentIcons.home_12_regular),
                activeIcon: Icon(FluentIcons.home_12_filled),
                label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(FluentIcons.search_12_regular),
                activeIcon: Icon(FluentIcons.search_12_filled),
                label: "Search"),
            BottomNavigationBarItem(
                icon: Icon(FluentIcons.ticket_diagonal_16_regular),
                activeIcon: Icon(FluentIcons.ticket_diagonal_16_filled),
                label: "Tickets"),
            BottomNavigationBarItem(
                icon: Icon(FluentIcons.person_5_20_regular),
                activeIcon: Icon(FluentIcons.person_5_20_filled),
                label: "Profile"),
          ]),
    );
  }
}