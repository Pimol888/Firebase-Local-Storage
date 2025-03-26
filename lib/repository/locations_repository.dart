import 'package:firebase_and_localstorage/model/location/locations.dart';

abstract class LocationsRepository {
  List<Location> getLocations();
}