import '../models/FlightData.dart';

class TicketStore {
  static final TicketStore _instance = TicketStore._internal();

  factory TicketStore() {
    return _instance;
  }

  TicketStore._internal();

  FlightData? selectedFlight;
  String? selectedSeat;
}
