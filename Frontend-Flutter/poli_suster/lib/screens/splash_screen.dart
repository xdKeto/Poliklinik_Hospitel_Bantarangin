import 'package:flutter/material.dart';
import 'package:poli_suster/base/backend/data_controller.dart';
import 'package:poli_suster/base/utils/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  DataController dataController = DataController();

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 1)).then((_) {
      checkLoginStatus();
    });
  }

  Future<void> checkLoginStatus() async {
    final token = await dataController.getToken();
    final expired = await dataController.getExpiration();

    if (token != null && DateTime.now().millisecondsSinceEpoch < expired) {
      try {} catch (e) {
        Navigator.pushReplacementNamed(context, AppRoutes.login);
        throw Exception(e);
      }
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
