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
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            useIndicator: true,
            indicatorColor: Colors.white,
            extended: isExpanded,
            backgroundColor: AppStyles.primaryColor,
            unselectedIconTheme: IconThemeData(color: Colors.white, opacity: 1),
            unselectedLabelTextStyle: const TextStyle(
              color: Colors.white,
            ),
            selectedIconTheme: IconThemeData(color: AppStyles.primaryColor),
            destinations: const [
              NavigationRailDestination(
                indicatorColor: Colors.white,
                icon: Icon(Icons.home),
                label: Text("List Pasien"),
              ),
              NavigationRailDestination(
                indicatorColor: Colors.white,
                // indicatorShape: Border(),
                icon: Icon(Icons.bar_chart),
                label: Text("Billing"),
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
