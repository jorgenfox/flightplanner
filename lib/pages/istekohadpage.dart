import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(SeatBookingApp());

class SeatBookingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: istekohadpage());
  }
}

class istekohadpage extends StatefulWidget {
  @override
  _istekohadpageState createState() => _istekohadpageState();
}

class _istekohadpageState extends State<istekohadpage> {
  final int maxSelectableSeats = 2;
  final int rows = 31;
  final int cols = 5;
  final Color availableColor = Colors.green;
  final Color selectedColor = Colors.blue;
  final Color bookedColor = Colors.grey;
  final Color exitRowColor = Colors.amber.shade700;
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
    if (row < 5 || row == 14) return row == 14 ? 15.0 : 40.0;
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
          width: 18,
          height: 18,
          margin: EdgeInsets.only(right: 6),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        Text(label, style: TextStyle(fontSize: 13)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Istmed'),
        elevation: 0,
        // backgroundColor: Colors.lightBlue,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 14.0),
            child: Container(
              padding: EdgeInsets.all(
                10,
              ), // Optional padding around the legend items
              decoration: BoxDecoration(
                color: Colors.white, // Background color of the container
                borderRadius: BorderRadius.circular(
                  20,
                ), // Set the border radius here
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
              ),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 15,
                runSpacing: 10,
                children: [
                  buildLegendItem(availableColor, 'Vaba'),
                  buildLegendItem(selectedColor, 'Valitud'),
                  buildLegendItem(exitRowColor, 'Rohkem jalaruumi'),
                  buildLegendItem(businessClassColor, 'Äriklass'),
                  buildLegendItem(bookedColor, 'Broneeritud'),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: rows,
              itemBuilder: (context, row) {
                final isExitRow = row == 14;
                return Padding(
                  padding: EdgeInsets.only(
                    top: isExitRow ? 22.0 : 4.0,
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
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        );
                      }

                      Color color;
                      switch (status) {
                        case SeatStatus.available:
                          color =
                              row == 14
                                  ? exitRowColor
                                  : row < 5
                                  ? businessClassColor
                                  : availableColor;
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
                        padding: const EdgeInsets.all(4.0),
                        child: GestureDetector(
                          onTap: () => toggleSeat(row, col),
                          child: Material(
                            elevation: 2,
                            borderRadius: BorderRadius.circular(6),
                            color: color,
                            child: Container(
                              width: 64,
                              height: 64,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      getSeatLabel(row, col),
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    if (price != null)
                                      Text(
                                        '+€${price.toInt()}',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.white70,
                                        ),
                                      ),
                                  ],
                                ),
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
            duration: Duration(milliseconds: 200),
            child:
                hasSelectedSeats()
                    ? Container(
                      key: ValueKey('bottom_bar'),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 6),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Lisatasu: €${getTotalExtraCost().toStringAsFixed(0)}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.lightBlue,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () {
                              // TODO: Implement seat confirmation logic
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
