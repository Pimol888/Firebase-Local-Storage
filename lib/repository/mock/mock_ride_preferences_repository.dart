import 'package:firebase_and_localstorage/dummy_data/dummy_data/dummy_data.dart';
import 'package:firebase_and_localstorage/model/ride/ride_pref.dart';
import '../ride_preferences_repository.dart';

class MockRidePreferencesRepository extends RidePreferencesRepository {
  final List<RidePreference> _pastPreferences = fakeRidePrefs;

  @override
  Future<List<RidePreference>> getPastPreferences() async{
    await Future.delayed(Duration(seconds: 2));
    return _pastPreferences;
  }

  @override
  Future<void> addPreference(RidePreference preference) async {
    await Future.delayed(Duration(seconds: 2));
    _pastPreferences.add(preference);
  }
}