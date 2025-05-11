import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';

class TicketsScreen extends StatelessWidget {
  const TicketsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Piletid'),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
        elevation: 0,
      ),
      backgroundColor: Colors.lightBlue,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // tabide valimiseks
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFE0E0E0),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              children: [
                _TicketTab(text: 'Kehtivad', selected: true),
                _TicketTab(text: 'Aegunud', selected: false),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // piletikaart
          _TicketCard(),
        ],
      ),
    );
  }
}

// -------------------- ülemine riba --------------------
class _TicketTab extends StatelessWidget {
  final String text;
  final bool selected;

  const _TicketTab({required this.text, required this.selected});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: selected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: selected ? Colors.black : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}

// -------------------- pileti osa --------------------
class _TicketCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(21),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          // lennu info
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                _AirportCode(code: "TLL", city: "Tallinn"),
                Icon(Icons.flight_takeoff_rounded, color: Colors.blueAccent),
                _AirportCode(code: "ALC", city: "Alicante"),
              ],
            ),
          ),

          const Divider(),

          // reisija ja pileti info
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              children: [
                _InfoRow(
                  label1: "Reisija",
                  value1: "JÖRGEN",
                  label2: "Dokumendi nr",
                  value2: "1234567890",
                ),
                const SizedBox(height: 10),
                _InfoRow(
                  label1: "Pileti nr",
                  value1: "2323 4556 6789",
                  label2: "Tellimuse nr",
                  value2: "B2SG28",
                ),
                const SizedBox(height: 10),
                _InfoRow(
                  label1: "Maksevahend",
                  value1: "**** 2462",
                  label2: "Hind",
                  value2: "249.99€",
                ),
                const SizedBox(height: 10),
                _InfoRow(
                  label1: "Iste",
                  value1: "5D",
                  label2: "Iste",
                  value2: "9A",
                ),
              ],
            ),
          ),

          const Divider(),

          // Barcode
          Padding(
            padding: const EdgeInsets.all(16),
            child: BarcodeWidget(
              data: "https://boardingpass.fake/123456",
              barcode: Barcode.code128(),
              width: double.infinity,
              height: 70,
              drawText: false,
            ),
          ),
        ],
      ),
    );
  }
}

// -------------------- widgetid --------------------
class _AirportCode extends StatelessWidget {
  final String code;
  final String city;

  const _AirportCode({required this.code, required this.city});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          code,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Text(city, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label1;
  final String value1;
  final String label2;
  final String value2;

  const _InfoRow({
    required this.label1,
    required this.value1,
    required this.label2,
    required this.value2,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // vasak column
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label1,
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
            Text(value1, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        // parem column
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              label2,
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
            Text(value2, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }
}
