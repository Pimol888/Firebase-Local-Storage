import 'package:firebase_and_localstorage/dummy_data/dto/locatio_dto.dart';

class RidePreferencesDTO {
  final LocationDTO departure;
  final DateTime departureDate;
  final LocationDTO arrival;
  final int requestedSeats;

  const RidePreferencesDTO({
    required this.departure,
    required this.departureDate,
    required this.arrival,
    required this.requestedSeats,
  });

   /// Converts a JSON map into a RidePreferencesDTO object
  factory RidePreferencesDTO.fromJson(Map<String, dynamic> json) {
    return RidePreferencesDTO(
      departure: LocationDTO.fromJson(json['departure']),
      departureDate: DateTime.parse(json['departureDate']), 
      arrival: LocationDTO.fromJson(json['arrival']),
      requestedSeats: json['requestedSeats'] as int,
    );
  }

  /// Converts the RidePreferencesDTO object into a JSON map
   Map<String, dynamic> toJson() {
    return {
      'departure': LocationDTO.toJson(departure),
      'departureDate': departureDate.toIso8601String(), 
      'arrival': LocationDTO.toJson(arrival),
      'requestedSeats': requestedSeats,
    };
  }
}