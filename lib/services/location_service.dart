import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';

class LocationService with ChangeNotifier {
  Position? currentPosition;
  StreamSubscription<Position>? _positionStream;

  LocationService() {
    _startLocationStream();
  }

  Future<bool> checkAndRequestPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
      return false;
    }

    return true;
  }

  void _startLocationStream() async {
    if (await checkAndRequestPermission()) {
      _positionStream = Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 10,
        ),
      ).listen((Position position) {
        currentPosition = position;
        notifyListeners();
      });
    }
  }

  void stopLocationUpdates() {
    _positionStream?.cancel();
  }

  Future<Position?> getLastKnownPosition() async {
    return await Geolocator.getLastKnownPosition();
  }

  @override
  void dispose() {
    stopLocationUpdates();
  }
}