import 'package:flutter/material.dart';
import 'package:poli_suster/base/global_widgets/home_tabs.dart';
import 'package:poli_suster/base/utils/app_styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  height: 50,
                  child: Row(
                    children: [
                      Text(
                        'Welcome, [nama suster]',
                        style: AppStyles.headingText.copyWith(
                            color: AppStyles.primaryColor,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      VerticalDivider(
                        color: AppStyles.primaryColor,
                        thickness: 2,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          // height: 40,
                          // width: 40,
                          decoration:
                              AppStyles.buttonBox2(AppStyles.primaryColor, 12),
                          padding: EdgeInsets.all(8),
                          child: Center(
                              child: Icon(
                            Icons.logout,
                            color: AppStyles.primaryColor,
                          )),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: AppStyles.whiteBox
                      .copyWith(color: AppStyles.primaryColor),
                  height: 90,
                  child: Row(
                    children: [
                      Text(
                        'Nomor antrian saat ini',
                        style: AppStyles.subheadingText.copyWith(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      VerticalDivider(
                        color: Colors.white,
                        thickness: 2,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Container(
                        decoration:
                            AppStyles.buttonBox(AppStyles.accentColor, 8),
                        padding: EdgeInsets.all(8),
                        child: Center(
                          child: Text(
                            '023',
                            style: AppStyles.headingText.copyWith(
                                fontSize: 40,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 24,
            ),
            HomeTabs()
          ],
        ),
      ),
    );
  }
}
