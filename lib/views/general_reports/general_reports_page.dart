import 'package:flutter/material.dart';
import 'package:highway_weight/controllers/general_lists_controller.dart';
import 'package:highway_weight/controllers/stations_controller.dart';
import 'package:highway_weight/styles/colors.dart';
import 'package:highway_weight/views/general_reports/general_report_form.dart';
import 'package:highway_weight/widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';

class GeneralReportsPage extends StatelessWidget {
  const GeneralReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final generalListsController = Provider.of<GeneralListsController>(context, listen: false);
    final stationsController = Provider.of<StationsController>(context);
    
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
              GeneralReportForm(
                generalListsController: generalListsController,
                stationsController: stationsController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
