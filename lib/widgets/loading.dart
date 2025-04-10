import 'package:flutter/material.dart';
import 'package:highway_weight/styles/colors.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png', width: 150, height: 150),
            const SizedBox(height: 32),
            const CircularProgressIndicator(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              color: AppColors.brandSecondary,
            ),
          ],
        ),
      ),
    );
  }
}
