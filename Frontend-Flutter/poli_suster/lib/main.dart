import 'package:flutter/material.dart';
import 'package:poli_suster/base/utils/app_routes.dart';
import 'package:poli_suster/screens/home_screen.dart';
import 'package:poli_suster/screens/login/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Poliklinik Hospitel Bantarangin',
        // home: LoginScreen(),
        initialRoute: AppRoutes.login,
        routes: {
          AppRoutes.login: (context) => LoginScreen(),
          AppRoutes.home: (context) => HomeScreen(),
        },
        );
  }
}
