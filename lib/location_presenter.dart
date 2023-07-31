import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'location_repository.dart';

class LocationPresenter {
  final LocationRepository _repository = LocationRepository();
  final StreamController<String?> _locationController =
      StreamController<String?>();

  Stream<String?> get locationStream => _locationController.stream;
  StreamSubscription<Position>? positionStreamSubscription;

  bool isLocationStreamActive = false;

  Future<void> getLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      if (!isLocationStreamActive) {
        startLocationStream();
        isLocationStreamActive = true;
      }
    } else {
      print('Location permission not granted.');
    }
  }

  void startLocationStream() {
    positionStreamSubscription =
        _repository.getPositionStream().listen((Position position) {
      final latitude = position.latitude.toString();
      final longitude = position.longitude.toString();
      _locationController.add('Latitude: $latitude, Longitude: $longitude');
      print('New Latitude: $latitude, Longitude: $longitude');
    });
    print('Location stream started');
  }

  void stopLocationStream() {
    positionStreamSubscription?.cancel();
    isLocationStreamActive = false;
    _locationController.add(null);
    print('Location stream stopped');
  }

  void dispose() {
    _locationController.close();
  }
}
