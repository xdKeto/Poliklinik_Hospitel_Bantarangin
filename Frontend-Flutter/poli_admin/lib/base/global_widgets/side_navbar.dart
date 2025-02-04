import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poli_admin/base/utils/app_styles.dart';
import 'package:poli_admin/screens/billing/billing_screen.dart';
import 'package:poli_admin/screens/list_pasien/list_pasien_screen.dart';

class SideNavbar extends StatefulWidget {
  const SideNavbar({super.key});

  @override
  State<SideNavbar> createState() => _SideNavbarState();
}

class _SideNavbarState extends State<SideNavbar> {
  late List<CollapsibleItem> _items;
  bool _isCollapsed = true;
  late PageController _pageController;

  List<CollapsibleItem> get _generateItems {
    return [
      CollapsibleItem(
          text: 'List Pasien',
          onPressed: () {
            _navigateToPage(0);
          },
          icon: CupertinoIcons.person,
          isSelected: true),
      CollapsibleItem(
          text: 'Billing',
          onPressed: () {
            _navigateToPage(1);
          },
          icon: Icons.home)
    ];
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _items = _generateItems;
  }

  void _navigateToPage(int index) {
    setState(() {
      _pageController.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppStyles.primaryColor,
        leading: IconButton(
            onPressed: () {
              setState(() {
                _isCollapsed = !_isCollapsed;
              });
            },
            icon: Icon(
              Icons.menu,
              size: 28,
              color: Colors.white,
            )),
      ),
      body: Row(
        children: [
          CollapsibleSidebar(
              // itemPadding: 0,
              // badgeBackgroundColor: Colors.red,
              iconSize: 18,
              textStyle:
                  AppStyles.sidebarText.copyWith(fontWeight: FontWeight.w600),
              isCollapsed: _isCollapsed,
              items: _items,
              showTitle: false,
              showToggleButton: false,
              sidebarBoxShadow: [],
              backgroundColor: AppStyles.primaryColor,
              borderRadius: 0,
              screenPadding: 0,
              topPadding: 20,
              selectedIconColor: AppStyles.primaryColor,
              selectedTextColor: AppStyles.primaryColor,
              selectedIconBox: Colors.white,
              unselectedIconColor: Colors.white,
              unselectedTextColor: Colors.white,
              body: Container()),
          Expanded(
              child: PageView(
            controller: _pageController,
            children: [ListPasienScreen(), BillingScreen()],
          ))
        ],
      ),
    );
  }
}
