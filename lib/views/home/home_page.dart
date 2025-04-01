import 'package:flutter/material.dart';
import 'package:highway_weight/controllers/auth_controller.dart';
import 'package:highway_weight/controllers/general_lists_controller.dart';
import 'package:highway_weight/controllers/main_lists_controller.dart';
import 'package:highway_weight/controllers/stations_controller.dart';
import 'package:highway_weight/views/home/home_general_reports.dart';
import 'package:highway_weight/views/home/home_hero.dart';
import 'package:highway_weight/views/home/home_main_reports.dart';
import 'package:highway_weight/views/home/home_map.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthController>(context);
    final generalReportController = Provider.of<GeneralListsController>(
      context,
    );
    final mainReportController = Provider.of<MainListsController>(context);
    final stationsController = Provider.of<StationsController>(context);

    final List<GlobalKey> navBarKey = List.generate(3, (index) => GlobalKey());
    void onNavChange(int index) {
      if (index < 0 || index >= navBarKey.length) {
        print("Invalid index: $index");
        return;
      }
      final key = navBarKey[index];
      final currentContext = key.currentContext;
      if (currentContext != null) {
        Scrollable.ensureVisible(
          currentContext,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        print("Right index: $index");
      } else {
        print("Context for key at index $index is null");
      }
    }

    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            HomeHero(authController: authController, onNavChange: onNavChange),
            HomeGeneralReports(
              generalListsController: generalReportController,
              key: navBarKey[0],
            ),
            HomeMainReports(
              mainListsController: mainReportController,
              key: navBarKey[1],
            ),
            HomeMap(
              stationsController: stationsController,
              key: navBarKey[2],
            ),
          ],
        ),
      ),
    );
  }
}
