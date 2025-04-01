import 'dart:async';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:highway_weight/models/stations_model.dart';

class StationsController extends ChangeNotifier {
  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  bool isMapReady = false;


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

  Future<void> cameraToPosition(LatLng position) async {
    try {
      final GoogleMapController controller = await _mapController.future;
      CameraPosition _newCameraPosition = CameraPosition(
        target: position,
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
      currentLocation = position;
      print("Place focused: $currentLocation");
      notifyListeners();
    } catch (e) {
      print("❌ Error animating camera: $e");
    }
  }

  List<StationsModel> stationLists = [
    StationsModel(
      name: 'Grand Palace, Bangkok',
      latLng: LatLng(13.7500, 100.4913),
    ),
    StationsModel(name: 'Wat Arun, Bangkok', latLng: LatLng(13.7436, 100.4889)),
    StationsModel(
      name: 'Chiang Mai Old City',
      latLng: LatLng(18.7883, 98.9853),
    ),
    StationsModel(name: 'Phuket Patong Beach', latLng: LatLng(7.8966, 98.2956)),
    StationsModel(
      name: 'Ayutthaya Historical Park',
      latLng: LatLng(14.3559, 100.5660),
    ),
    StationsModel(
      name: 'Erawan Shrine, Bangkok',
      latLng: LatLng(13.7453, 100.5396),
    ),
    StationsModel(name: 'Railay Beach, Krabi', latLng: LatLng(8.0117, 98.8373)),
    StationsModel(
      name: 'Doi Inthanon, Chiang Mai',
      latLng: LatLng(18.5883, 98.4878),
    ),
    StationsModel(
      name: 'Sukhothai Historical Park',
      latLng: LatLng(17.0154, 99.8200),
    ),
    StationsModel(
      name: 'Khao Yai National Park',
      latLng: LatLng(14.4378, 101.3722),
    ),
    StationsModel(
      name: 'Wat Phra Kaew, Chiang Rai',
      latLng: LatLng(19.9086, 99.8320),
    ),
    StationsModel(
      name: 'Bridge on the River Kwai, Kanchanaburi',
      latLng: LatLng(14.0420, 99.5039),
    ),
    StationsModel(
      name: 'Chatuchak Weekend Market, Bangkok',
      latLng: LatLng(13.8007, 100.5520),
    ),
    StationsModel(
      name: 'Sanctuary of Truth, Pattaya',
      latLng: LatLng(12.9723, 100.8842),
    ),
    StationsModel(
      name: 'Sam Phan Bok, Ubon Ratchathani',
      latLng: LatLng(15.9962, 105.3885),
    ),
    StationsModel(
      name: 'Wat Mahathat, Nakhon Si Thammarat',
      latLng: LatLng(8.4304, 99.9631),
    ),
    StationsModel(
      name: 'Koh Phi Phi Leh, Krabi',
      latLng: LatLng(7.6786, 98.7657),
    ),
    StationsModel(
      name: 'Damnoen Saduak Floating Market, Ratchaburi',
      latLng: LatLng(13.5186, 99.9580),
    ),
    StationsModel(
      name: 'Phimai Historical Park, Nakhon Ratchasima',
      latLng: LatLng(15.2201, 102.4931),
    ),
    StationsModel(
      name: 'Wat Phra That Doi Suthep, Chiang Mai',
      latLng: LatLng(18.8049, 98.9215),
    ),
    StationsModel(name: 'Thai CC Tower', latLng: LatLng(13.7186, 100.5215)),
  ];


  String getStationName(LatLng position){
    final result = stationLists.firstWhere((item)=>item.latLng == position);
    return result.name;
  }
}
