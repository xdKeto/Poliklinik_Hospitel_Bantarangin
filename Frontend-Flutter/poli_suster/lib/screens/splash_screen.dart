import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:poli_suster/base/backend/data_controller.dart';
import 'package:poli_suster/base/utils/app_media.dart';
import 'package:poli_suster/base/utils/app_routes.dart';
import 'package:poli_suster/base/utils/app_styles.dart';

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

    Future.delayed(Duration(seconds: 5)).then((_) {
      checkLoginStatus();
    });
  }

  Future<void> checkLoginStatus() async {
    final token = await dataController.getToken();
    final expired = await dataController.getExpiration();
    final idPoli = await dataController.getLoggedInPoli();

    if (token != null && DateTime.now().millisecondsSinceEpoch < expired) {
      try {
        await dataController.fetchFirstData(idPoli);
        Navigator.pushReplacementNamed(context, AppRoutes.home);
      } catch (e) {
        Navigator.pushReplacementNamed(context, AppRoutes.login);
        throw Exception(e);
      }
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppMedia.splashBG),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                AppMedia.loginLogo,
                width: 130,
                height: 130,
                fit: BoxFit.contain,
                filterQuality: FilterQuality.high,
              ),
              SizedBox(
                height: 4,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'HOSPITEL BANTARANGIN',
                    style: AppStyles.loginHeadText.copyWith(
                        color: AppStyles.textColor,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'GENERAL HOSPITAL',
                    style: AppStyles.loginHeadText.copyWith(
                        color: AppStyles.textColor,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              LoadingAnimationWidget.fourRotatingDots(
                  color: AppStyles.primaryColor, size: 64)
            ],
          ),
        ),
      ),
    );
  }
}
