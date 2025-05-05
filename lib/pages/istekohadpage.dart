import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(SeatBookingApp());

class SeatBookingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Vali istekohad', home: istekohadpage());
  }
}

class istekohadpage extends StatefulWidget {
  @override
  _istekohadpageState createState() => _istekohadpageState();
}

class _istekohadpageState extends State<istekohadpage> {
  final int maxSelectableSeats = 2; // implementeerida, prg testimiseks ainult
  final int rows = 31;
  final int cols = 5;
  final Color availableColor = Colors.green;
  final Color selectedColor = Colors.blue;
  final Color bookedColor = Colors.grey;
  final Color exitRowColor = Colors.yellow.shade700;
  final Color businessClassColor = Colors.purple.shade400;

  List<String> selectedSeatLabels = [];
  List<List<SeatStatus>> seatMap = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    seatMap = List.generate(rows, (row) {
      return List.generate(cols, (col) {
        if (col == 2) return SeatStatus.aisle;
        bool isBooked = _random.nextDouble() < 0.25;
        return isBooked ? SeatStatus.booked : SeatStatus.available;
      });
    });
  }

  void toggleSeat(int row, int col) {
    final currentStatus = seatMap[row][col];
    final label = getSeatLabel(row, col);

    if (currentStatus == SeatStatus.booked || currentStatus == SeatStatus.aisle)
      return;

    setState(() {
      if (currentStatus == SeatStatus.selected) {
        seatMap[row][col] = SeatStatus.available;
        selectedSeatLabels.remove(label);
      } else if (selectedSeatLabels.length < maxSelectableSeats) {
        seatMap[row][col] = SeatStatus.selected;
        selectedSeatLabels.add(label);
      }
    });
  }

  bool hasSelectedSeats() {
    return seatMap.any((row) => row.contains(SeatStatus.selected));
  }

  double? getSeatPrice(int row) {
    if (row < 5 || row == 14) return row == 14 ? 35.0 : 55.0;
    return null;
  }

  double getTotalExtraCost() {
    double total = 0.0;

    for (int row = 0; row < seatMap.length; row++) {
      for (int col = 0; col < seatMap[row].length; col++) {
        if (seatMap[row][col] == SeatStatus.selected) {
          final price = getSeatPrice(row);
          if (price != null) total += price;
        }
      }
    }

    return total;
  }

  String getSeatLabel(int row, int col) {
    final letters = ['A', 'B', '', 'C', 'D'];
    return '${row + 1}${letters[col]}';
  }

  Widget buildLegendItem(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 20,
          height: 20,
          margin: EdgeInsets.only(right: 6),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.black26),
          ),
        ),
        Text(label, style: TextStyle(fontSize: 12)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Vali istekohad')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 10,
              runSpacing: 8,
              children: [
                buildLegendItem(bookedColor, 'Broneeritud'),
                buildLegendItem(availableColor, 'Vaba'),
                buildLegendItem(selectedColor, 'Valitud'),
                buildLegendItem(exitRowColor, 'Rohkem jalaruumi'),
                buildLegendItem(businessClassColor, 'Äriklass'),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: rows,
              itemBuilder: (context, row) {
                final isExitRow = row == 14;
                return Padding(
                  padding: EdgeInsets.only(
                    top: isExitRow ? 24.0 : 4.0,
                    bottom: 4.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(cols, (col) {
                      final status = seatMap[row][col];

                      if (col == 2) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: SizedBox(
                            width: 36,
                            child: Center(
                              child: Text(
                                '${row + 1}',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey.shade400,
                                ),
                              ),
                            ),
                          ),
                        );
                      }

                      Color color;
                      switch (status) {
                        case SeatStatus.available:
                          if (row == 14) {
                            color = exitRowColor; // Exit row
                          } else if (row < 5) {
                            color = businessClassColor; // Business class
                          } else {
                            color = availableColor;
                          }
                          break;
                        case SeatStatus.selected:
                          color = selectedColor;
                          break;
                        case SeatStatus.booked:
                          color = bookedColor;
                          break;
                        default:
                          color = Colors.transparent;
                      }

                      final price = getSeatPrice(row);

                      return Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: GestureDetector(
                          onTap: () => toggleSeat(row, col),
                          child: Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    getSeatLabel(row, col),
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                  if (price != null)
                                    Text(
                                      '+€${price.toInt()}',
                                      style: TextStyle(
                                        fontSize: 8,
                                        color: Colors.white,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                );
              },
            ),
          ),
          AnimatedSwitcher(
            duration: Duration(milliseconds: 150),
            child:
                hasSelectedSeats()
                    ? Container(
                      key: ValueKey('bottom_bar'),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${selectedSeatLabels.join(", ")}', //TODO
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            'Lisatasu: €${getTotalExtraCost().toStringAsFixed(0)}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Handle confirm logic
                            },
                            child: Text('Kinnita kohad'),
                          ),
                        ],
                      ),
                    )
                    : SizedBox.shrink(key: ValueKey('empty')),
          ),
        ],
      ),
    );
  }
}

enum SeatStatus { available, selected, booked, aisle }

/*
CONFIRM BUTTON

Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => TicketPage(seats: selectedSeatLabels),
  ),
);

FOR RECEIVEING DART FILE

class TicketPage extends StatelessWidget {
  final List<String> seats;

  const TicketPage({required this.seats});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Your Tickets')),
      body: Center(
        child: Text('Seats: ${seats.join(", ")}'),
      ),
    );
  }
}


*/
