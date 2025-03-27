import 'package:flutter/material.dart';
import 'package:poli_admin/base/global_widgets/side_navbar.dart';
import 'package:poli_admin/base/utils/app_routes.dart';
import 'package:poli_admin/screens/login/login_screen.dart';

void main() {
  // debugPaintSizeEnabled = true;
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
        AppRoutes.dashboard: (context) => SideNavbar()
      },
    );
  }
}
