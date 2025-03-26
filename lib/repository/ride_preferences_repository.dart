import 'package:firebase_and_localstorage/model/ride/ride_pref.dart';

abstract class RidePreferencesRepository {
  Future<List<RidePreference>> getPastPreferences();

  Future<void> addPreference(RidePreference preference);
}