import 'package:flutter/material.dart';
import 'package:poli_admin/base/global_widgets/label_required.dart';
import 'package:poli_admin/base/global_widgets/the_button.dart';
import 'package:poli_admin/base/utils/app_media.dart';
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
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(AppMedia.loginImage), fit: BoxFit.fill)),
          ),
        ),
        Expanded(
          flex: 5,
          child: Container(
            // padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(AppMedia.loginBG), fit: BoxFit.fill)),
            child: Center(
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(12),
                color: AppStyles.secondaryColor,
                child: Container(
                  width: screenWidth * 0.3,
                  height: screenHeight * 0.87,
                  padding: EdgeInsets.all(56),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(AppMedia.loginLogo),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'HOSPITEL BANTARANGIN',
                        style: AppStyles.subheadingText.copyWith(
                            color: AppStyles.backgroundColor,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: screenHeight * 0.07,
                      ),
                      Text(
                        'LOGIN',
                        style: AppStyles.subheadingText.copyWith(
                            color: AppStyles.backgroundColor,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: screenHeight * 0.03,
                      ),
                      LabelRequired(
                          text: 'Username',
                          style: AppStyles.normalText.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppStyles.backgroundColor)),
                      SizedBox(
                        height: screenHeight * 0.01,
                      ),
                      TextFormField(
                        cursorColor: Colors.black,
                        decoration: AppStyles.loginInput,
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
                              color: AppStyles.backgroundColor)),
                      SizedBox(
                        height: screenHeight * 0.01,
                      ),
                      TextFormField(
                        cursorColor: Colors.black,
                        obscureText: isHidden,
                        decoration: AppStyles.loginInput.copyWith(
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
                              child: TheButton(
                                  text: 'Login', color: AppStyles.accentColor)),
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
    );
  }
}
