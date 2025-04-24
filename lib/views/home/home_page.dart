import 'package:flutter/material.dart';
import 'package:highway_weight/controllers/auth_controller.dart';
import 'package:highway_weight/controllers/general_lists_controller.dart';
import 'package:highway_weight/controllers/inspector_reports_controller.dart';
import 'package:highway_weight/controllers/main_reports_controller.dart';
import 'package:highway_weight/controllers/stations_controller.dart';
import 'package:highway_weight/views/home/home_general_reports.dart';
import 'package:highway_weight/views/home/home_hero.dart';
import 'package:highway_weight/views/home/home_inspector_reports.dart';
import 'package:highway_weight/views/home/home_main_reports.dart';
import 'package:highway_weight/views/home/home_map.dart';
import 'package:highway_weight/widgets/loading.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late StationsController stationsController;
  late MainReportsController mainReportsController;
  late GeneralReportsController generalReportsController;
  late InspectorReportsController inspectorReportsController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() {
      inspectorReportsController = Provider.of(context, listen: false);
      inspectorReportsController.fetchInspectorReport();

      generalReportsController = Provider.of(context, listen: false);
      generalReportsController.fetchGeneralReports();

      mainReportsController = Provider.of(context, listen: false);
      mainReportsController.fetchMainReports();

      stationsController = Provider.of(context, listen: false);
      stationsController.fetchStations();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthController>(context);
    final generalReportController = Provider.of<GeneralReportsController>(
      context,
    );
    final mainReportController = Provider.of<MainReportsController>(context);
    final inspectorReportController = Provider.of<InspectorReportsController>(
      context,
    );
    final stationsController = Provider.of<StationsController>(context);

    final List<GlobalKey> navBarKey = List.generate(4, (index) => GlobalKey());
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
        print("Current index: $index");
      } else {
        print("Context for key at index $index is null");
      }
    }

    if (generalReportController.isLoading ||
        stationsController.isLoading ||
        mainReportController.isLoading ||
        inspectorReportController.isLoading) {
      return const Loading();
    } else {
      return Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                HomeHero(
                  authController: authController,
                  onNavChange: onNavChange,
                ),
                HomeGeneralReports(
                  mainReportsController: mainReportController,
                  generalReportsController: generalReportController,
                  authController: authController,
                  key: navBarKey[0],
                ),
                HomeMainReports(
                  authController: authController,
                  mainListsController: mainReportController,
                  key: navBarKey[1],
                ),
                HomeInspectorReports(
                  authController: authController,
                  inspectorReportsController: inspectorReportController,
                  key: navBarKey[2],
                ),
                HomeMap(
                  stationsController: stationsController,
                  key: navBarKey[3],
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
