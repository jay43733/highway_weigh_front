import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:highway_weight/app.dart';
import 'package:highway_weight/constants/custom_scroll_behavior.dart';
import 'package:highway_weight/controllers/auth_controller.dart';
import 'package:highway_weight/controllers/general_lists_controller.dart';
import 'package:highway_weight/controllers/main_lists_controller.dart';
import 'package:highway_weight/controllers/stations_controller.dart';
import 'package:highway_weight/styles/theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter_web_plugins/url_strategy.dart';


// Run with fixed port for web:  flutter run -d chrome --web-port=8000

void main() {
  GoRouter.optionURLReflectsImperativeAPIs = true; // Config GoRouter to reflect changing path
  usePathUrlStrategy();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthController()),
        ChangeNotifierProvider(create: (_) => GeneralListsController()),
        ChangeNotifierProvider(create: (_) => StationsController()),
        ChangeNotifierProxyProvider<
          GeneralListsController,
          MainListsController
        >(
          create:
              (_) => MainListsController(
                generalListsController: GeneralListsController(),
              ),
          update:
              (_, generalListsController, previous) => MainListsController(
                generalListsController: generalListsController,
              ),
        ),
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
