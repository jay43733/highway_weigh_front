import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:highway_weight/services/navigation_service.dart';
import 'package:highway_weight/styles/colors.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    _redirectedToLastPath();
  }

  Future<void> _redirectedToLastPath() async {
    await Future.delayed(const Duration(milliseconds: 200));

    if (mounted) {
      final lastPath = await NavigationService.getLastPath();
      context.go(lastPath);
    }
  }

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
