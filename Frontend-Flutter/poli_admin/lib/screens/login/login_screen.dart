import 'package:flutter/material.dart';
import 'package:poli_admin/base/backend/data_controller.dart';
import 'package:poli_admin/base/global_widgets/label_required.dart';
import 'package:poli_admin/base/global_widgets/loading_alert.dart';
import 'package:poli_admin/base/global_widgets/sucfail_alert.dart';
import 'package:poli_admin/base/global_widgets/the_button.dart';
import 'package:poli_admin/base/utils/app_media.dart';
import 'package:poli_admin/base/utils/app_routes.dart';
import 'package:poli_admin/base/utils/app_styles.dart';
import 'package:poli_admin/base/utils/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // late TextEditingController controller;
  String? email;
  String? password;
  String? token;
  bool isHidden = true;

  @override
  void initState() {
    super.initState();
    cekSession();
  }

  void cekSession() async {
    bool session = await DataController().cekToken();
    if (session) {
      Navigator.pushReplacementNamed(context, AppRoutes.dashboard);
    }
  }

  void togglePassword() {
    setState(() {
      isHidden = !isHidden;
    });
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  void doLogin() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      final context2 = context;

      showDialog(
          context: context,
          builder: (context) => LoadingAlert(),
          barrierDismissible: false);

      DataController dataController = DataController();
      ResponseRequestAPI response = await dataController.apiConnector(
          Config.apiEndpoints['login']!(),
          "post",
          {"username": email, "password": password});

      if (!context.mounted) return;
      Navigator.pop(context2);
      if (response.status == 200) {
        token = response.data;
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', token!);

        if (!context.mounted) return;
        showDialog(
          context: context2,
          builder: (context) => SucfailAlert(
            isSuccess: true,
            boldText: "Login Successful",
            italicText: "your credentials are correct",
          ),
        );

        await Future.delayed(Duration(seconds: 1));

        if (context.mounted) Navigator.pop(context2);

        if (context.mounted) {
          showDialog(
            context: context2,
            builder: (context) => LoadingAlert(),
            barrierDismissible: false,
          );
        }

        await DataController().fetchAllData();

        if (context.mounted) {
          Navigator.pop(context2);
          Navigator.pushReplacementNamed(context2, AppRoutes.dashboard);
        }
      } else {
        showDialog(
          context: context2,
          builder: (context) => SucfailAlert(
            isSuccess: false,
            boldText: "Login Failed",
            italicText: response.status == 401
                ? "please check your credentials"
                : response.message,
          ),
        );
      }
    }
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
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(12)),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(24.0),
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
                            Form(
                              key: formKey,
                              child: Column(
                                children: [
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
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter your username';
                                      }

                                      return null;
                                    },
                                    onChanged: (value) {
                                      email = value;
                                    },
                                    cursorColor: Colors.black,
                                    decoration: AppStyles.formBox,
                                    onSaved: (value) {},
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
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter your password';
                                      }

                                      return null;
                                    },
                                    onChanged: (value) {
                                      password = value;
                                    },
                                    cursorColor: Colors.black,
                                    obscureText: isHidden,
                                    decoration: AppStyles.formBox.copyWith(
                                        suffixIcon: IconButton(
                                            onPressed: () => togglePassword(),
                                            icon: Icon(isHidden
                                                ? Icons.visibility_off
                                                : Icons.visibility))),
                                    onSaved: (value) {},
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 0.04,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: InkWell(
                                  onTap: () {
                                    doLogin();
                                  },
                                  child: TheButton(
                                    text: 'Login',
                                    color: AppStyles.accentColor,
                                    textColor: Colors.black,
                                    hoverable: false,
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
            ),
          ),
        ],
      ),
    );
  }
}
