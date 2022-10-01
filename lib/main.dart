import 'package:flutter/material.dart';
import 'package:meow_travel_flutter/travel_app_home_screen.dart';
import 'package:meow_travel_flutter/utils/router_now.dart';

import 'login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: RouterNow.navigatorKey,
      home: const TravelAppHomeScreen(),
      routes: <String, WidgetBuilder>{'router/login': (_) => const Login()},
    );
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return int.parse(hexColor, radix: 16);
  }
}
