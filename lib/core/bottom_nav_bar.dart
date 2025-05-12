import 'package:flutter/material.dart';
import 'package:flightplanner/pages/homepage.dart';
import 'package:flightplanner/pages/lennudpage.dart';
import 'package:flightplanner/pages/istekohadpage.dart';
import 'package:flightplanner/pages/ticketpage.dart';
import 'package:flightplanner/pages/accountpage.dart';
import 'package:flightplanner/models/FlightData.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;
  final ValueNotifier<FlightData?> flightDataNotifier = ValueNotifier(null);

  // Getter, mis loob ekraanid dünaamiliselt
  List<Widget> get _screens => [
    HomePage(
      onSearch: (data) {
        flightDataNotifier.value = data;
        setState(() {
          _currentIndex = 1; // mine LennudPage ekraanile
        });
      },
    ),
    ValueListenableBuilder<FlightData?>(
      valueListenable: flightDataNotifier,
      builder: (context, flightData, child) {
        // Kui flightData on null, näita lihtsalt tühi konteiner või placeholder
        if (flightData == null) {
          return  LennudPage(filteredFlights: null);
        }
        return LennudPage(filteredFlights: flightData);
      },
    ),
    istekohadPage(),
    TicketsScreen(),
    AccountPage(),
  ];

  @override
  void initState() {
    super.initState();
    // Ei ole vaja siin _screens määrata, kuna getter teeb selle töö
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: const TextStyle(fontFamily: "Inter", fontSize: 15),
        type: BottomNavigationBarType.shifting,
        elevation: 0,
        currentIndex: _currentIndex,
        onTap: (index) => setState(() {
          _currentIndex = index;
        }),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Otsing",
            backgroundColor: Colors.lightBlue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.flight),
            label: "Lennud",
            backgroundColor: Colors.lightBlue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_seat),
            label: "Istekohad",
            backgroundColor: Colors.lightBlue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.airplane_ticket),
            label: 'Piletid',
            backgroundColor: Colors.lightBlue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Konto',
            backgroundColor: Colors.lightBlue,
          ),
        ],
      ),
    );
  }
}
