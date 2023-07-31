import 'dart:async';
import 'package:geolocator/geolocator.dart';

class LocationRepository {
  final LocationSettings _locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 1,
  );

  Stream<Position> getPositionStream() {
    return Geolocator.getPositionStream(locationSettings: _locationSettings);
  }
}
