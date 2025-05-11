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

  factory FlightData.fromJson(Map<String, dynamic> json) {
    return FlightData(
      departure: json['departure'],
      destination: json['destination'],
      date: json['date'],
      price: json['price'],
    );
  }
}
