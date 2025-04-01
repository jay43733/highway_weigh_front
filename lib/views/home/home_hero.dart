import 'package:flutter/material.dart';
import 'package:highway_weight/controllers/auth_controller.dart';
import 'package:highway_weight/styles/colors.dart';
import 'package:highway_weight/styles/text_styles.dart';
import 'package:highway_weight/widgets/custom_app_bar.dart';

class HomeHero extends StatelessWidget {
  final AuthController authController;
  final Function(int) onNavChange;
  const HomeHero({
    super.key,
    required this.authController,
    required this.onNavChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
      height: 500.0,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 40.0,
              vertical: 20.0,
            ),
            child: CustomAppBar(onNavBarChanged: onNavChange,)
          ),
          SizedBox(height: 40.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png', width: 160.0),
              SizedBox(height: 20.0),
              Text(
                "สำนักงานควบคุมน้ำหนักยานพาหนะ กรมทางหลวง",
                style: TextStyles.h3Semi.copyWith(
                  color: AppColors.brandPrimary,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                "OFFICE OF VEHICLE WEIGHT CONTROL",
                style: TextStyles.bodyReg.copyWith(
                  color: AppColors.whitePrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
