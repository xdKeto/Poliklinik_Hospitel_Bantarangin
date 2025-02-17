import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:poli_admin/base/global_widgets/label_required.dart';
import 'package:poli_admin/base/global_widgets/the_button.dart';
import 'package:poli_admin/base/utils/app_media.dart';
import 'package:poli_admin/base/utils/app_routes.dart';
import 'package:poli_admin/base/utils/app_styles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isHidden = true;

  void togglePassword() {
    setState(() {
      isHidden = !isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: screenWidth * 0.35,
            top: 0,
            bottom: 0,
            child: Image.asset(
              AppMedia.loginImage,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            left: screenWidth * 0.55,
            right: 0,
            top: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32),
                  bottomLeft: Radius.circular(32),
                ),
                image: DecorationImage(
                  image: AssetImage(AppMedia.loginBG),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Material(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.transparent,
                  child: Container(
                    width: screenWidth * 0.3,
                    height: screenHeight * 0.87,
                    padding: EdgeInsets.all(24),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(12)),
                    child: Column(
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
                          height: 5,
                        ),
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
                        SizedBox(
                          height: screenHeight * 0.05,
                        ),
                        LabelRequired(
                            text: 'Username',
                            style: AppStyles.normalText.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppStyles.textColor)),
                        SizedBox(
                          height: screenHeight * 0.01,
                        ),
                        TextFormField(
                          cursorColor: Colors.black,
                          decoration: AppStyles.formBox,
                          onChanged: (value) {},
                        ),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        LabelRequired(
                            text: 'Password',
                            style: AppStyles.normalText.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppStyles.textColor)),
                        SizedBox(
                          height: screenHeight * 0.01,
                        ),
                        TextFormField(
                          cursorColor: Colors.black,
                          obscureText: isHidden,
                          decoration: AppStyles.formBox.copyWith(
                              suffixIcon: IconButton(
                                  onPressed: () => togglePassword(),
                                  icon: Icon(isHidden
                                      ? Icons.visibility_off
                                      : Icons.visibility))),
                          onChanged: (value) {},
                        ),
                        SizedBox(
                          height: screenHeight * 0.04,
                        ),
                        Row(
                          children: [
                            Expanded(
<<<<<<< HEAD
                                child: TheButton(
                              text: 'Login',
                              color: AppStyles.accentColor,
                              onTapFunc: () {
                                GoRouter.of(context).go('/home/list-pasien');
=======
                                child: InkWell(
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                    context, AppRoutes.homeScreen('pasien'));
>>>>>>> f56544f7a71d942398a3e7b997fc6a4d2ea549d5
                              },
                              child: TheButton(
                                text: 'Login',
                                color: AppStyles.accentColor,
                              ),
                            )),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
