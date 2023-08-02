import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'location_repository.dart';

class LocationCubit extends Cubit<String?> {
  final LocationRepository _repository = LocationRepository();
  StreamSubscription<Position>? _positionStreamSubscription;
  bool isLocationStreamActive = false;
  bool hasPermission = false;

  LocationCubit() : super(null);

  Future<void> getLocationPermission() async {
    if (hasPermission) {
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      hasPermission = true;
    } else {
      print('Location permission not granted.');
      emit('Location permission not granted.');
    }
  }

  Future<void> startLocationStream() async {
    if (!hasPermission) {
      print('Location permission not granted.');
      emit('Location permission not granted.');
      return;
    }

    _positionStreamSubscription?.cancel();
    _positionStreamSubscription =
        _repository.getPositionStream().listen((Position position) {
      final latitude = position.latitude.toString();
      final longitude = position.longitude.toString();
      emit('Latitude: $latitude, Longitude: $longitude');
      print('New Latitude: $latitude, Longitude: $longitude');
    });
    print('Location stream started');
  }

  void stopLocationStream() {
    _positionStreamSubscription?.cancel();
    isLocationStreamActive = false;
    emit(null);
    print('Location stream stopped');
  }

  @override
  Future<void> close() {
    _positionStreamSubscription?.cancel();
    return super.close();
  }
}
