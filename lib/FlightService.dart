import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models/FlightData.dart';

// Service class for fetching flight data from the backend
class FlightService {
  static const String _baseUrl = 'http://192.168.0.20:8080/lennud';

  // Fetch flight data from the server
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