import 'package:firebase_and_localstorage/repository/mock/mock_locations_repository.dart';
import 'package:firebase_and_localstorage/repository/mock/mock_rides_repository.dart';
import 'package:firebase_and_localstorage/service/locations_service.dart';
import 'package:firebase_and_localstorage/service/rides_service.dart';
import 'package:firebase_and_localstorage/ui/provider/ride_prefs_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'repository/local/local_ride_preferences_repository.dart';
import 'ui/screens/ride_pref/ride_pref_screen.dart';
import 'ui/theme/theme.dart';

void main() {
  // 1 - Initialize the services
  // RidePrefService.initialize(MockRidePreferencesRepository());
  LocationsService.initialize(MockLocationsRepository());
  RidesService.initialize(MockRidesRepository());

  // 2 - Run the UI with providers
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => RidesPrefsProvider(LocalRidePreferencesRepository())),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: Scaffold(body: RidePrefScreen()),
    );
  }
}