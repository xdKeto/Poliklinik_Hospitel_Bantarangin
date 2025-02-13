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
      home: LoginScreen(),
      initialRoute: AppRoutes.login,
      onGenerateRoute: (settings) {
        final args = settings.arguments as Map<String, dynamic>?;

        // Extract only the base route path (without query params)
        final uri = Uri.parse(settings.name!);
        final basePath = uri.path;

        Widget page;
        switch (basePath) {
          case AppRoutes.homePasien:
            page = SideNavbar(
                param: 'pasien', isExpand: args?['isExpand'] ?? false);
            break;
          case AppRoutes.homeBilling:
            page = SideNavbar(
                param: 'billing', isExpand: args?['isExpand'] ?? false);
            break;
          case AppRoutes.homeRiwayat:
            page = SideNavbar(
                param: 'riwayat', isExpand: args?['isExpand'] ?? false);
            break;
          case AppRoutes.login:
            page = LoginScreen();
            break;
          default:
            return null;
        }

        // Return a route with no animation
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => page,
          transitionDuration: Duration.zero, // No animation duration
          reverseTransitionDuration: Duration.zero, // No animation duration
        );
      },
    );
  }
}
