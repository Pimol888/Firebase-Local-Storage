// TODO Implement this library.
import 'dart:convert';
import 'package:firebase_and_localstorage/dummy_data/dto/ride_prefs_dto.dart';
import 'package:firebase_and_localstorage/model/ride/ride_pref.dart';
import 'package:firebase_and_localstorage/repository/ride_preferences_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalRidePreferencesRepository extends RidePreferencesRepository {
  static const String _preferencesKey = "ride_preferences";

  @override
  Future<void> addPreference(RidePreference preference) async {
    final pref = await SharedPreferences.getInstance();
    
    // Fetch existing preferences
    List<RidePreference> preferences = await getPastPreferences();
    
    if(preferences.contains(preference)){
      preferences.remove(preference);
    }    

    preferences.add(preference);
    
    List<RidePreferencesDTO> preferencesDTO = preferences.map((item) => RidePreference.toDto(item)).toList();
    
    await pref.setStringList(_preferencesKey, 
      preferencesDTO.map((dto) => jsonEncode(dto.toJson())).toList()
    );
  }

  @override
  Future<List<RidePreference>> getPastPreferences() async {

    final pref = await SharedPreferences.getInstance();
    final prefsList = pref.getStringList(_preferencesKey) ?? []; 
    List<RidePreference> temp =  prefsList.map((json) => RidePreference.fromDto(RidePreferencesDTO.fromJson(jsonDecode(json)))
    ).toList();

    return temp.reversed.toList();
  }
}