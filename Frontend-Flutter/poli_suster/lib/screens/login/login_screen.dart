import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:poli_suster/base/global_widgets/label_required.dart';
import 'package:poli_suster/base/global_widgets/the_button.dart';
import 'package:poli_suster/base/utils/app_media.dart';
import 'package:poli_suster/base/utils/app_routes.dart';
import 'package:poli_suster/base/utils/app_styles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isHidden = true;
  String? selectedValue;
  final List<String> listPoli = [
    "Poli Gigi",
    "Poli Anak",
    "Poli Umum",
    "Poli Obgyn "
  ];

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
                          decoration: AppStyles.formBox
                              .copyWith(contentPadding: EdgeInsets.zero),
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
                          onChanged: (value) {},
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
                            padding: EdgeInsets.symmetric(horizontal: 16),
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
                                Navigator.pushReplacementNamed(
                                    context, AppRoutes.home);
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
        ],
      ),
    );
  }
}
