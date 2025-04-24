import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:highway_weight/controllers/stations_controller.dart';
import 'package:highway_weight/styles/colors.dart';
import 'package:highway_weight/styles/text_styles.dart';
import 'package:highway_weight/widgets/popup_modal.dart';

class HomeMap extends StatelessWidget {
  final StationsController stationsController;
  const HomeMap({super.key, required this.stationsController});

  @override
  Widget build(BuildContext context) {
    final sortedStations = List.of(stationsController.stations);
    final selectedStations = sortedStations.indexWhere(
      (station) =>
          station.lat == stationsController.currentLocation.latitude &&
          station.long == stationsController.currentLocation.longitude,
    );
    if (selectedStations != -1) {
      final currentStation = sortedStations.removeAt(selectedStations);
      sortedStations.insert(0, currentStation);
    }

    return Container(
      decoration: BoxDecoration(
        color: AppColors.blackPrimary,
        image: DecorationImage(
          image: AssetImage('assets/images/traffic2.jpg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            AppColors.blackPrimary.withValues(alpha: 0.8),
            BlendMode.darken,
          ),
          opacity: 0.6,
          filterQuality: FilterQuality.high,
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 60.0),
      child: Column(
        children: [
          Text(
            "Stations",
            style: TextStyles.h3Semi.copyWith(color: AppColors.whitePrimary),
          ),
          SizedBox(height: 24.0),

          SizedBox(
            height: 500,
            width: 1200,
            child: GoogleMap(
              scrollGesturesEnabled: false,
              onMapCreated: (GoogleMapController controller) {
                stationsController.setMapController(controller);
              },
              initialCameraPosition: CameraPosition(
                target: stationsController.currentLocation,
                zoom: 13,
              ),
              markers:
                  stationsController.stations.asMap().entries.map((entries) {
                    return Marker(
                      onTap: () {
                        stationsController.cameraToPosition(
                          entries.value.lat,
                          entries.value.long,
                        );
                      },
                      markerId: MarkerId(entries.key.toString()),
                      icon: BitmapDescriptor.defaultMarker,
                      position: LatLng(entries.value.lat, entries.value.long),
                      infoWindow: InfoWindow(title: entries.value.name),
                    );
                  }).toSet(),
            ),
          ),

          SizedBox(height: 20.0),

          Container(
            width: 1200.0,
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Wrap(
              runAlignment: WrapAlignment.spaceBetween,
              alignment: WrapAlignment.start,
              runSpacing: 20.0,
              spacing: 20.0,
              children:
                  sortedStations.map((item) {
                    return OutlinedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            stationsController.currentLocation.latitude ==
                                        item.lat &&
                                    stationsController
                                            .currentLocation
                                            .longitude ==
                                        item.long
                                ? WidgetStatePropertyAll(AppColors.blackPure)
                                : WidgetStatePropertyAll(Colors.transparent),
                      ),
                      onPressed: () {
                        stationsController.cameraToPosition(
                          item.lat,
                          item.long,
                        );
                        PopupModal.showModal(
                          context,
                          title: "Yeah",
                          boldText: "${LatLng(item.lat, item.long)}",
                          caption: "Yeah",
                        );
                      },
                      child: Text(
                        item.name,
                        style: TextStyles.ctaLabelSemi.copyWith(
                          color: AppColors.whitePrimary,
                        ),
                      ),
                    );
                  }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 80.0,
              right: 80.0,
              top: 60.0,
              bottom: 10.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Divider(
                    color: AppColors.whitePrimary,
                    indent: 20.0,
                    endIndent: 10.0,
                    thickness: 0.5,
                  ),
                ),
                Text(
                  'Published by Network Link Co., Ltd',
                  style: TextStyles.labelReg.copyWith(
                    color: AppColors.whitePrimary,
                  ),
                ),
                Expanded(
                  child: Divider(
                    color: AppColors.whitePrimary,
                    indent: 10.0,
                    endIndent: 20.0,
                    thickness: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
