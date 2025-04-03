import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:highway_weight/constants/custom_scroll_behavior.dart';
import 'package:highway_weight/services/navigation_service.dart';
import 'package:highway_weight/styles/theme.dart';
import 'package:highway_weight/views/general_reports/general_reports_page.dart';
import 'package:highway_weight/views/home/home_page.dart';
import 'package:highway_weight/views/loading_page.dart';
import 'package:highway_weight/views/login/login_page.dart';

// Routing Management in App
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      title: "Highway Weigh",
      routerConfig: _router,
      scrollBehavior: CustomScrollBehavior(),
    );
  }
}

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const LoadingPage()),
    GoRoute(
      path: '/login',
      builder: (context, state) {
        NavigationService.savePath('/login');
        return const LoginPage();
      },
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) {
        NavigationService.savePath('/home');
        return const HomePage();
      },
    ),
    GoRoute(
      path: '/general_reports',
      builder: (context, state) {
        NavigationService.savePath("/general_reports");
        return const GeneralReportsPage();
      },
    ),
  ],
);
