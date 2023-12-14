import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'routes/page_routes.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.teal.shade200,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: routers,
        theme: ThemeData(
          useMaterial3: true,
          // Define the default brightness and colors.
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.teal,
            // ···
            brightness: Brightness.light,
          ),
        ));
  }
}
