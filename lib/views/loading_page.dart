import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:highway_weight/controllers/auth_controller.dart';
import 'package:highway_weight/services/navigation_service.dart';
import 'package:highway_weight/styles/colors.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  final storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _redirectedToLastPath();
  }

  Future<void> _checkRole() async {
    if (mounted) {
      final authController = Provider.of<AuthController>(
        context,
        listen: false,
      );
      final role = await storage.read(key: 'role');
      final name = await storage.read(key: 'name');
      final id = await storage.read(key: 'userId');
      if (role != null) {
        authController.getStorage('role', role);
      }
      if (name != null) {
        authController.getStorage('user', name);
      }
      if (id != null) {
        authController.getStorage('id', id);
      }
    }
  }

  Future<void> _redirectedToLastPath() async {
    final authController = Provider.of<AuthController>(context, listen: false);
    await _checkRole();
    await Future.delayed(const Duration(milliseconds: 200));

    if (mounted) {
      final lastPath = await NavigationService.getLastPath();
      authController.getStorage('routeNow', lastPath);
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
