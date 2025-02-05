import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:poli_admin/base/utils/app_media.dart';
import 'package:poli_admin/base/utils/app_styles.dart';
import 'package:poli_admin/screens/billing/billing_screen.dart';
import 'package:poli_admin/screens/list_pasien/list_pasien_screen.dart';

class SideNavbar extends StatefulWidget {
  const SideNavbar({super.key});

  @override
  State<SideNavbar> createState() => _SideNavbarState();
}

class _SideNavbarState extends State<SideNavbar> {
  int _selected = 0;
  bool isExpanded = true;

  void toggleSidebar() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  late final List<Widget> appScreens;

  @override
  void initState() {
    super.initState();
    appScreens = [
      ListPasienScreen(onMenuPressed: toggleSidebar),
      BillingScreen(onMenuPressed: toggleSidebar),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            useIndicator: true,
            indicatorColor: Colors.white,
            indicatorShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              side: BorderSide(color: Colors.white, width: 2),
            ),
            extended: isExpanded,
            backgroundColor: AppStyles.primaryColor,
            unselectedIconTheme: IconThemeData(color: Colors.white, opacity: 1),
            unselectedLabelTextStyle:
                AppStyles.sidebarText.copyWith(color: Colors.white),
            selectedIconTheme: IconThemeData(color: AppStyles.primaryColor),
            selectedLabelTextStyle: AppStyles.sidebarText.copyWith(
              color: Colors.white,
            ),
            leading: isExpanded
                ? Padding(
                    padding: EdgeInsets.only(bottom: 16.0, top: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          AppMedia.loginLogo,
                          width: 45,
                          height: 45,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Hospitel\nBantarangin',
                          style: AppStyles.tambahanText.copyWith(
                              color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.only(bottom: 16, top: 8),
                    child: Image.asset(
                      AppMedia.loginLogo,
                      width: 45,
                      height: 45,
                      fit: BoxFit.contain,
                    )),
            trailing: Column(
              children: [
                Divider(
                  color: Colors.white,
                  thickness: 4,
                ),
                SizedBox(
                  height: screenHeight * 0.67,
                ),
                GestureDetector(
                  onTap: () {
                    // print('logout');
                  },
                  child: isExpanded
                      ? Row(
                          children: [
                            Icon(
                              Icons.logout,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "Logout",
                              style: AppStyles.sidebarText.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        )
                      : Row(
                          children: [
                            Icon(
                              Icons.logout,
                              color: Colors.white,
                            ),
                          ],
                        ),
                )
              ],
            ),
            destinations: [
              NavigationRailDestination(
                icon: Icon(FluentIcons.contact_card_16_regular),
                selectedIcon: Icon(FluentIcons.contact_card_16_filled),
                label: Text(
                  "List Pasien",
                ),
              ),
              NavigationRailDestination(
                icon: Icon(FluentIcons.receipt_16_regular),
                selectedIcon: Icon(FluentIcons.receipt_16_filled),
                label: Text(
                  "Billing",
                ),
              ),
            ],
            selectedIndex: _selected,
            onDestinationSelected: (int index) {
              setState(() {
                _selected = index;
              });
            },
          ),
          Expanded(child: appScreens[_selected]),
        ],
      ),
    );
  }
}
