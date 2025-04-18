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
    final stationsController = Provider.of<StationsController>(
      context,
      listen: false,
    );

    return Scaffold(
      body: Stack(
        children: [
          ListView(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.blackPrimary,
                  image: const DecorationImage(
                    image: AssetImage('assets/images/traffic1.jpg'),
                    colorFilter: ColorFilter.mode(
                      Colors.black54,
                      BlendMode.darken,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 20,
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
            ],
          ),

          Selector<GeneralReportsController, bool>(
            selector: (_, controller) => controller.isLoading,
            builder: (_, isLoading, __) {
              if (!isLoading) return const SizedBox.shrink();

              return Container(
                color: Colors.black.withValues(alpha: 0.4),
                child: const Center(child: Loading()),
              );
            },
          ),
        ],
      ),
    );
  }
}
