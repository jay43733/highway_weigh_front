import 'package:flutter/material.dart';
import 'package:highway_weight/controllers/general_lists_controller.dart';
import 'package:highway_weight/controllers/stations_controller.dart';
import 'package:highway_weight/styles/colors.dart';
import 'package:highway_weight/views/update_general_reports/update_general_report_form.dart';
import 'package:highway_weight/widgets/custom_app_bar.dart';
import 'package:highway_weight/widgets/loading.dart';
import 'package:provider/provider.dart';

class UpdateGeneralReportsPage extends StatelessWidget {
  const UpdateGeneralReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final generalReportsController = Provider.of<GeneralReportsController>(
      context,
      listen: false,
    );
    print("Loading ... ${generalReportsController.isLoading}");
    final stationsController = Provider.of<StationsController>(context);

    if (generalReportsController.isLoading) {
      return const Loading();
    }

    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.blackPrimary,
            image: DecorationImage(
              image: AssetImage('assets/images/traffic1.jpg'),
              colorFilter: ColorFilter.mode(
                Colors.black.withValues(alpha: 0.7),
                BlendMode.darken,
              ),
              filterQuality: FilterQuality.high,
              opacity: 0.8,
              fit: BoxFit.cover,
            ),
          ),
          height: 1000,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40.0,
                  vertical: 20.0,
                ),
                child: CustomAppBar(),
              ),
              UpdateGeneralReportForm(
                generalReportsController: generalReportsController,
                stationsController: stationsController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
