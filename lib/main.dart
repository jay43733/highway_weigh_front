import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:highway_weight/app.dart';
import 'package:highway_weight/constants/custom_scroll_behavior.dart';
import 'package:highway_weight/controllers/auth_controller.dart';
import 'package:highway_weight/controllers/general_reports_controller.dart';
import 'package:highway_weight/controllers/inspector_reports_controller.dart';
import 'package:highway_weight/controllers/main_reports_controller.dart';
import 'package:highway_weight/controllers/stations_controller.dart';
import 'package:highway_weight/controllers/users_controller.dart';
import 'package:highway_weight/styles/theme.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

// Run with fixed port for web: flutter run -d chrome --web-port=8000

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting(
    'th_TH',
    null,
  ); // Initialize date formatting for Thai locale

  GoRouter.optionURLReflectsImperativeAPIs =
      true; // Config GoRouter to reflect changing path
  usePathUrlStrategy();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UsersController()),
        ChangeNotifierProvider(create: (_) => AuthController()),
        ChangeNotifierProvider(create: (_) => GeneralReportsController()),
        ChangeNotifierProvider(create: (_) => MainReportsController()),
        ChangeNotifierProvider(create: (_) => InspectorReportsController()),
        ChangeNotifierProvider(create: (_) => StationsController()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const App(),
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      title: 'Highway Weigh',
      scrollBehavior: CustomScrollBehavior(),
    );
  }
}
