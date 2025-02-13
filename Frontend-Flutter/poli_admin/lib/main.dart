import 'package:flutter/material.dart';
import 'package:poli_admin/base/global_widgets/side_navbar.dart';
import 'package:poli_admin/base/utils/app_routes.dart';
import 'package:poli_admin/screens/login/login_screen.dart';

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
      // home: SideNavbar(),
      home: LoginScreen(),
      initialRoute: "/login",
      routes: {
        AppRoutes.homeScreen('pasien'): (context) {
          final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>?;
          return SideNavbar(
              param: 'pasien', isExpand: args?['isExpand'] ?? false);
        },
        AppRoutes.homeScreen('billing'): (context) {
          final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>?;
          return SideNavbar(
              param: 'billing', isExpand: args?['isExpand'] ?? false);
        },
        AppRoutes.homeScreen('riwayat'): (context) {
          final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>?;
          return SideNavbar(
              param: 'riwayat', isExpand: args?['isExpand'] ?? false);
        },
        AppRoutes.login: (context) => LoginScreen(),
      },
    );
  }
}
