import 'dart:async';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:highway_weight/models/stations_model.dart';
import 'package:highway_weight/repositories/station_repository.dart';

class StationsController extends ChangeNotifier {
  final StationRepository _repository = StationRepository();
  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  bool isLoading = false;
  List<StationsModel> stations = [];
  bool isMapReady = false;

  Future<void> fetchStations() async {
    isLoading = true;
    notifyListeners();
    try {
      stations = await _repository.getAll();
    } catch (e) {
      isLoading = false;
      throw Exception("Failed to fetch $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  LatLng currentLocation = LatLng(13.7186, 100.5215);

  void setMapController(GoogleMapController controller) async {
    if (!_mapController.isCompleted) {
      _mapController.complete(controller);
      if (kIsWeb) {
        await Future.delayed(const Duration(milliseconds: 500));
      }
      isMapReady = true;
      notifyListeners();
    }
  }

  Future<void> cameraToPosition(double lat, double long) async {
    try {
      final GoogleMapController controller = await _mapController.future;
      CameraPosition _newCameraPosition = CameraPosition(
        target: LatLng(lat, long),
        zoom: 15,
      );
      if (kIsWeb) {
        try {
          await controller.animateCamera(
            CameraUpdate.newCameraPosition(_newCameraPosition),
          );
        } catch (e) {
          print("Initial camera update failed, retrying...: $e");
        }
      } else {
        await controller.animateCamera(
          CameraUpdate.newCameraPosition(_newCameraPosition),
        );
      }
      currentLocation = LatLng(lat, long);
      print("Place focused: $currentLocation");
      notifyListeners();
    } catch (e) {
      print("❌ Error animating camera: $e");
    }
  }

  String getStationName(int id) {
    final result = stations.firstWhere((item) => item.id == id);
    return result.name;
  }
}
