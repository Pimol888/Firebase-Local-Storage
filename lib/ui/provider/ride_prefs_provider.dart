import 'package:firebase_and_localstorage/model/ride/ride_pref.dart';
import 'package:firebase_and_localstorage/repository/ride_preferences_repository.dart';
import 'package:firebase_and_localstorage/ui/provider/async_value.dart';
import 'package:flutter/material.dart';

class RidesPrefsProvider extends ChangeNotifier {
  final RidePreferencesRepository repository;
  RidesPrefsProvider(this.repository);

  RidePreference? _currentPreference;

  ///cache
  AsyncValue<List<RidePreference>>? pastRidePref ;

  // Current preference
  RidePreference? get currentPreference {
    print('Get  current  pref : $_currentPreference');
    return _currentPreference;
  }

  Future<void> fetchPastPreferences() async {
    //1. hanlde loading
    pastRidePref = AsyncValue.loading();
    notifyListeners();
    try {
      //2. handle fetching
      List<RidePreference> pastPrefs = await getPastPreferences();
      //3.handle succes
      pastRidePref = AsyncValue.success(pastPrefs);
      //4. handle error
    } catch (e) {
      pastRidePref = AsyncValue.error(e);
    }
    notifyListeners();
  }

  void setCurrentPreference(RidePreference preference) {
    if (_currentPreference != preference) {
      _currentPreference = preference;
      print('Set current pref to $_currentPreference');
      addPreference(preference);
      notifyListeners();
    }
  }

  // Past preferences
  Future<List<RidePreference>> getPastPreferences() async {
    final temp = await repository.getPastPreferences();
    return temp.reversed.toList();
  }

  Future<void> addPreference(RidePreference preference) async{
    //option 2
     // update catch
    if(pastRidePref!.data!.contains(preference)){
      pastRidePref!.data!.remove(preference);
    }
    pastRidePref!.data!.add(preference);
    ///
    /// With this its will improve app performance by reduce fetching time
    ///
    
    //add preference repo 
    repository.addPreference(preference);
   
    notifyListeners();
    return;
  }
}