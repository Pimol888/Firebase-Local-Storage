import 'package:firebase_and_localstorage/model/ride/ride.dart';
import 'package:firebase_and_localstorage/model/ride/ride_filter.dart';
import 'package:firebase_and_localstorage/model/ride/ride_pref.dart';

abstract class RidesRepository {
  List<Ride> getRidesFor(RidePreference ridePreference, RideFilter? rideFilter);
}