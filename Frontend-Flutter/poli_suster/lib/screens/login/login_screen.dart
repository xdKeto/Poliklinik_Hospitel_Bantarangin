import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:poli_suster/base/backend/data_controller.dart';
import 'package:poli_suster/base/global_widgets/label_required.dart';
import 'package:poli_suster/base/global_widgets/loading_alert.dart';
import 'package:poli_suster/base/global_widgets/sucfail_alert.dart';
import 'package:poli_suster/base/global_widgets/the_button.dart';
import 'package:poli_suster/base/utils/app_media.dart';
import 'package:poli_suster/base/utils/app_routes.dart';
import 'package:poli_suster/base/utils/app_styles.dart';
import 'package:poli_suster/base/utils/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? username;
  String? password;
  String? token;
  int? idPoli;
  bool isHidden = true;
  String? selectedValue;
  final List<String> listPoli = [];
  DataController dataController = DataController();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      await dataController.fetchPoli();

      setState(() {
        if (dataController.poliAktif.isNotEmpty) {
          listPoli.clear();
          for (var poli in dataController.poliAktif) {
            listPoli.add(poli.namaPoli);
          }
        }
      });
    } catch (e) {
      print("error fetching data in login screen: $e");
    }
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  void doLogin() async {
    print(username);
    print(password);
    print(idPoli);

    if (formKey.currentState!.validate()) {
      print("sampe sini?");
      formKey.currentState!.save();

      final context2 = context;

      showDialog(
          context: context,
          builder: (context) => LoadingAlert(),
          barrierDismissible: false);

      ResponseRequestAPI response = await dataController.apiConnector(
          Config.apiEndpoints["login"]!(),
          "post",
          {"username": username, "password": password, "id_poli": idPoli});

      if (!context.mounted) return;
      Navigator.pop(context2);
      if (response.status == 200) {
        token = response.data["token"];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', token!);

        final expiredTime =
            DateTime.now().add(Duration(hours: 12)).millisecondsSinceEpoch;
        await prefs.setInt('auth_token_expiration', expiredTime);

        if (!context.mounted) return;

        showDialog(
            context: context2,
            builder: (context) => SucfailAlert(
                isSuccess: true,
                boldText: "Login Successful",
                italicText: "welcome, suster"));

        await Future.delayed(Duration(seconds: 1));
        if (context.mounted) Navigator.pop(context2);

        if (context.mounted) {
          showDialog(
            context: context2,
            builder: (context) => LoadingAlert(),
            barrierDismissible: false,
          );
        }

        await dataController.fetchFirstData();

        if (context.mounted) {
          Navigator.pop(context2);
          Navigator.pushReplacementNamed(context2, AppRoutes.home);
        }
      } else {
        showDialog(
            context: context2,
            builder: (context) => SucfailAlert(
                isSuccess: false,
                boldText: "Login Failed",
                italicText: response.message));
      }
    }
  }

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
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(12)),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                        return "Please enter your username";
                                      }

                                      return null;
                                    },
                                    onChanged: (value) {
                                      username = value;
                                    },
                                    cursorColor: Colors.black,
                                    decoration: AppStyles.formBox,
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
                                        return "Please enter your password";
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
                                  ),
                                  SizedBox(
                                    height: screenHeight * 0.02,
                                  ),
                                  LabelRequired(
                                      text: 'Poliklinik',
                                      style: AppStyles.normalText.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: AppStyles.textColor)),
                                  SizedBox(
                                    height: screenHeight * 0.01,
                                  ),
                                  DropdownButtonFormField2<String>(
                                    isExpanded: true,
                                    decoration: AppStyles.formBox.copyWith(
                                        contentPadding: EdgeInsets.zero),
                                    hint: Text('-- Pilih Poliklinik --'),
                                    items: listPoli
                                        .map((item) => DropdownMenuItem<String>(
                                            value: item, child: Text(item)))
                                        .toList(),
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Pilih Poliklinik';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      try {
                                        final poli = dataController.poliAktif
                                            .firstWhere((poli) =>
                                                poli.namaPoli == value);
                                        setState(() {
                                          idPoli = poli.idPoli;
                                        });
                                      } catch (e) {
                                        print("Error setting idPoli: $e");
                                      }
                                    },
                                    onSaved: (newValue) {
                                      selectedValue = newValue.toString();
                                    },
                                    buttonStyleData: ButtonStyleData(
                                        padding: EdgeInsets.only(right: 8)),
                                    iconStyleData: const IconStyleData(
                                      icon: Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.black45,
                                      ),
                                      iconSize: 24,
                                    ),
                                    dropdownStyleData: DropdownStyleData(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    menuItemStyleData: const MenuItemStyleData(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                    ),
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
