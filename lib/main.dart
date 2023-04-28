import 'package:banana/modular.dart';
import 'package:banana/utils/variable_static.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart'
    hide ModularWatchExtension;

void main() {
  runApp(
    ModularApp(
      module: BananaModular(),
      debugMode: false,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Banana',
      scaffoldMessengerKey: NavigationService.navigatorKey,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: Colors.purple,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(     
        useMaterial3: true,
        primaryColor: Colors.purple,
        brightness: Brightness.light,
      ),
      routerDelegate: Modular.routerDelegate,
      routeInformationParser: Modular.routeInformationParser,
    );
  }
}
