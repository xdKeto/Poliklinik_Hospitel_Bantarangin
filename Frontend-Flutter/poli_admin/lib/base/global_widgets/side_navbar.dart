import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:poli_admin/base/global_widgets/icon_text.dart';
import 'package:poli_admin/base/utils/app_media.dart';
import 'package:poli_admin/base/utils/app_routes.dart';
import 'package:poli_admin/base/utils/app_styles.dart';
import 'package:poli_admin/screens/billing/billing_screen.dart';
import 'package:poli_admin/screens/billing/detail_billing.dart';
import 'package:poli_admin/screens/list_pasien/list_pasien_screen.dart';
import 'package:poli_admin/screens/list_pasien/registrasi_screen.dart';

class SideNavbar extends StatefulWidget {
  const SideNavbar({super.key});

  @override
  State<SideNavbar> createState() => _SideNavbarState();
}

class _SideNavbarState extends State<SideNavbar> {
  int _selectedParent = 0;
  bool isExpanded = true;
  Map<int, int> _selectedChild = {0: 0, 1: 0};

  void toggleSidebar() {
    setState(() {
      print(isExpanded);
      isExpanded = !isExpanded;
    });
  }

  void navigateToChild(int parentIndex, int childIndex) {
    setState(() {
      _selectedParent = parentIndex;
      _selectedChild[parentIndex] = childIndex;
    });
  }

  Widget _getScreen() {
    if (_selectedParent == 0) {
      return _selectedChild[0] == 0
          ? ListPasienScreen(
              onMenuPressed: toggleSidebar,
              isExpanded: isExpanded,
              navigateToChild: (childIndex) => navigateToChild(0, childIndex),
            )
          : RegistrasiScreen(
              onMenuPressed: toggleSidebar,
              isExpanded: isExpanded,
              // navigateToChild: (childIndex) => navigateToChild(0, childIndex),
            );
    } else {
      return _selectedChild[1] == 0
          ? BillingScreen(
              onMenuPressed: toggleSidebar,
              isExpanded: isExpanded,
              navigateToChild: (childIndex) => navigateToChild(1, childIndex),
            )
          : DetailBilling(
              onMenuPressed: toggleSidebar,
              isExpanded: isExpanded,
              // navigateToChild: (childIndex) => navigateToChild(1, childIndex),
            );
    }
  }

  @override
  Widget build(BuildContext context) {
    // final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            useIndicator: true,
            indicatorColor: Colors.white,
            indicatorShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            extended: isExpanded,
            backgroundColor: AppStyles.primaryColor,
            unselectedIconTheme: IconThemeData(color: Colors.white, opacity: 1),
            unselectedLabelTextStyle:
                AppStyles.sidebarText.copyWith(color: Colors.white),
            selectedIconTheme: IconThemeData(color: AppStyles.primaryColor),
            selectedLabelTextStyle: AppStyles.sidebarText.copyWith(
              color: AppStyles.primaryColor,
            ),
            leading: Column(
              children: [
                isExpanded
                    ? Padding(
                        padding: EdgeInsets.only(bottom: 16.0, top: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              AppMedia.logoRS,
                              width: 45,
                              height: 45,
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Hospitel\nBantarangin',
                              style: AppStyles.tambahanText.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.only(bottom: 16, top: 8),
                        child: Image.asset(
                          AppMedia.logoRS,
                          width: 45,
                          height: 45,
                          fit: BoxFit.contain,
                        )),
                Divider(
                  thickness: 8,
                  color: Colors.red,
                  height: 16,
                )
              ],
            ),
            trailing: Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, AppRoutes.login);
                    },
                    child: isExpanded
                        ? IconText(
                            icon: Icons.logout,
                            text: 'Logout',
                            isIcon: true,
                            style: AppStyles.sidebarText.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                            iconColor: Colors.white)
                        : IconText(
                            icon: Icons.logout,
                            isIcon: false,
                            iconColor: Colors.white),
                  )
                ],
              ),
            ),
            destinations: [
              NavigationRailDestination(
                icon: Icon(FluentIcons.contact_card_16_regular),
                selectedIcon: Icon(FluentIcons.contact_card_16_filled),
                label: Container(
                  width: 150,
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: _selectedParent == 0
                        ? Colors.white
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Text(
                    "List Pasien",
                  ),
                ),
              ),
              NavigationRailDestination(
                icon: Icon(FluentIcons.receipt_16_regular),
                selectedIcon: Icon(FluentIcons.receipt_16_filled),
                label: Container(
                  width: 150,
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: _selectedParent == 1
                        ? Colors.white
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Text(
                    "Tagihan",
                  ),
                ),
              ),
            ],
            selectedIndex: _selectedParent,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedParent = index;
                _selectedChild[_selectedParent] = 0;
              });
            },
          ),
          Expanded(child: _getScreen()),
        ],
      ),
    );
  }
}
