import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models/FlightData.dart';

class FlightService {
  static const String _baseUrl = 'http://localhost:8080/lennud';

  // Funktsioon lennuandmete pärimiseks
  Future<List<FlightData>> fetchFlights() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((flight) => FlightData.fromJson(flight)).toList();
      } else {
        throw Exception('Failed to load flights');
      }
    } catch (e) {
      throw Exception('Error fetching flights: $e');
    }
  }
}
