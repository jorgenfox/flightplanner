import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';

// Stateless widget for the ticket page
class TicketPage extends StatelessWidget {
  const TicketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tickets'),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
        elevation: 0,
      ),
      backgroundColor: Colors.lightBlue,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Tab bar for selecting ticket status
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFE0E0E0),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              children: [
                _TicketTab(text: 'Valid', selected: true),
                _TicketTab(text: 'Expired', selected: false),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Ticket card displaying flight details
          _TicketCard(),
        ],
      ),
    );
  }
}

// Widget for ticket status tabs
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

// Widget for displaying a ticket card
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
          // Flight information
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

          // Passenger and ticket details
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              children: [
                _InfoRow(
                  label1: "Passenger",
                  value1: "JÖRGEN",
                  label2: "Document No.",
                  value2: "1234567890",
                ),
                const SizedBox(height: 10),
                _InfoRow(
                  label1: "Ticket No.",
                  value1: "2323 4556 6789",
                  label2: "Order No.",
                  value2: "B2SG28",
                ),
                const SizedBox(height: 10),
                _InfoRow(
                  label1: "Payment Method",
                  value1: "**** 2462",
                  label2: "Price",
                  value2: "249.99€",
                ),
                const SizedBox(height: 10),
                _InfoRow(
                  label1: "Seat",
                  value1: "5D",
                  label2: "Seat",
                  value2: "9A",
                ),
              ],
            ),
          ),

          const Divider(),

          // Barcode for boarding pass
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

// Widget for displaying airport code and city
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

// Widget for displaying a row of ticket information
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
        // Left column
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
        // Right column
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