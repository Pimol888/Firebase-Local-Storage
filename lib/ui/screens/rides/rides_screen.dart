import 'package:firebase_and_localstorage/model/ride/ride.dart';
import 'package:firebase_and_localstorage/model/ride/ride_filter.dart';
import 'package:firebase_and_localstorage/model/ride/ride_pref.dart';
import 'package:firebase_and_localstorage/service/rides_service.dart';
import 'package:firebase_and_localstorage/ui/provider/ride_prefs_provider.dart';
import 'package:firebase_and_localstorage/ui/screens/rides/widgets/ride_pref_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/theme.dart';
import '../../../utils/animations_util.dart';
import 'widgets/ride_pref_modal.dart';
import 'widgets/rides_tile.dart';

///
///  The Ride Selection screen allow user to select a ride, once ride preferences have been defined.
///  The screen also allow user to re-define the ride preferences and to activate some filters.
///


class RidesScreen extends StatelessWidget {
  RidesScreen({super.key});

  


  void onBackPressed(BuildContext context) {
    // 1 - Back to the previous view
    Navigator.of(context).pop();
  }

  onRidePrefSelected(BuildContext context,RidePreference newRidePref) async {
     final ridePrefProvider = context.read<RidesPrefsProvider>();
     ridePrefProvider.setCurrentPreference(newRidePref);
  }

  void onPreferencePressed(BuildContext context) async {

    final ridePrefProvider = context.read<RidesPrefsProvider>();
    RidePreference? currentPreference = ridePrefProvider.currentPreference; 

    // Open a modal to edit the ride preferences
    RidePreference? newPreference = await Navigator.of(
      context,
    ).push<RidePreference>(
      AnimationUtils.createTopToBottomRoute(
        RidePrefModal(initialPreference: currentPreference),
      ),
    );

    if (newPreference != null) {
      // 1 - Update the current preference
      ridePrefProvider.setCurrentPreference(newPreference);

      // 2 -   Update the state   -- TODO MAKE IT WITH STATE MANAGEMENT
    }
  }

  void onFilterPressed() {}

  @override
  Widget build(BuildContext context) {

  /// init provider
  final ridePredProvider = context.watch<RidesPrefsProvider>();

  RidePreference currentPreference =  ridePredProvider.currentPreference!;

  RideFilter currentFilter = RideFilter();

  List<Ride>  matchingRides = RidesService.instance.getRidesFor(currentPreference, currentFilter);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: BlaSpacings.m,
          right: BlaSpacings.m,
          top: BlaSpacings.s,
        ),
        child: Column(
          children: [
            // Top search Search bar
            RidePrefBar(
              ridePreference: currentPreference,
              onBackPressed: onBackPressed,
              onPreferencePressed: onPreferencePressed,
              onFilterPressed: onFilterPressed,
            ),

            Expanded(
              child: ListView.builder(
                itemCount: matchingRides.length,
                itemBuilder: (ctx, index) =>
                    RideTile(ride: matchingRides[index], onPressed: () {}),
              ),
            ),
          ],
        ),
      ),
    );
  }
}