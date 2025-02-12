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
import 'package:poli_admin/screens/riwayat_pembayaran/detail_riwayat.dart';
import 'package:poli_admin/screens/riwayat_pembayaran/riwayat_screen.dart';

class SideNavbar extends StatefulWidget {
  final String param;
  const SideNavbar({super.key, required this.param});

  @override
  State<SideNavbar> createState() => _SideNavbarState();
}

class _SideNavbarState extends State<SideNavbar>
    with SingleTickerProviderStateMixin {
  late int _selectedParent;
  bool isExpanded = false;
  final Map<int, int> _selectedChild = {0: 0, 1: 0, 2: 0};

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _selectedParent = widget.param == 'pasien'
        ? 0
        : widget.param == 'billing'
            ? 1
            : 2;
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
  }

  void toggleSidebar() {
    setState(() {
      isExpanded = !isExpanded;
      if (isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
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
            );
    } else if (_selectedParent == 1) {
      return _selectedChild[1] == 0
          ? BillingScreen(
              onMenuPressed: toggleSidebar,
              isExpanded: isExpanded,
              navigateToChild: (childIndex) => navigateToChild(1, childIndex),
            )
          : DetailBilling(
              onMenuPressed: toggleSidebar,
              isExpanded: isExpanded,
            );
    } else {
      return RiwayatScreen(
          onMenuPressed: toggleSidebar,
          isExpanded: isExpanded,
          navigateToChild: (childIndex) => navigateToChild(2, childIndex));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            width: isExpanded ? 270 : 72,
            child: NavigationRail(
              useIndicator: true,
              indicatorColor: Colors.white,
              indicatorShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              extended: isExpanded,
              backgroundColor: AppStyles.primaryColor,
              unselectedIconTheme:
                  IconThemeData(color: Colors.white, opacity: 1),
              unselectedLabelTextStyle:
                  AppStyles.sidebarText.copyWith(color: Colors.white),
              selectedIconTheme: IconThemeData(color: AppStyles.primaryColor),
              selectedLabelTextStyle: AppStyles.sidebarText.copyWith(
                  color: AppStyles.primaryColor, fontWeight: FontWeight.w600),
              minExtendedWidth: 150,
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
                              Opacity(
                                opacity: isExpanded ? 1.0 : 0.0,
                                child: Text(
                                  'Hospitel\nBantarangin',
                                  style: AppStyles.tambahanText.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                  softWrap: false,
                                  overflow: TextOverflow.ellipsis,
                                ),
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
                    thickness: 2,
                    color: Colors.white,
                    // height: 16,
                  )
                ],
              ),
              trailing: Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, AppRoutes.login);
                        },
                        child: isExpanded
                            ? AnimatedBuilder(
                                animation: _animationController,
                                builder: (context, child) {
                                  double width = isExpanded ? 2000 : 0;
                                  return SizedBox(
                                    width: width,
                                    child: Opacity(
                                      opacity: isExpanded ? 1.0 : 0.0,
                                      child: IconText(
                                          icon: Icons.logout,
                                          text: 'Logout',
                                          isIcon: true,
                                          style: AppStyles.sidebarText.copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600),
                                          iconColor: Colors.white),
                                    ),
                                  );
                                },
                              )
                            : IconText(
                                icon: Icons.logout,
                                isIcon: false,
                                iconColor: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
              destinations: [
                NavigationRailDestination(
                  icon: Icon(FluentIcons.contact_card_16_regular),
                  selectedIcon: Icon(FluentIcons.contact_card_16_filled),
                  label: AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      double width = isExpanded ? 200 : 0;
                      return SizedBox(
                        width: width,
                        child: Opacity(
                          opacity: isExpanded ? 1.0 : 0.0,
                          child: Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: _selectedParent == 0
                                  ? Colors.white
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: Text(
                              "List Pasien",
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                NavigationRailDestination(
                  icon: Icon(FluentIcons.receipt_16_regular),
                  selectedIcon: Icon(FluentIcons.receipt_16_filled),
                  label: AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      double width = isExpanded ? 200 : 0;
                      return SizedBox(
                        width: width,
                        child: Opacity(
                          opacity: isExpanded ? 1.0 : 0.0,
                          child: Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: _selectedParent == 1
                                  ? Colors.white
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: Text(
                              "Tagihan",
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                NavigationRailDestination(
                  icon: Icon(FluentIcons.history_16_regular),
                  selectedIcon: Icon(FluentIcons.history_16_filled),
                  label: AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      double width = isExpanded ? 250 : 0;
                      return SizedBox(
                        width: width,
                        child: Opacity(
                          opacity: isExpanded ? 1.0 : 0.0,
                          child: Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: _selectedParent == 2
                                  ? Colors.white
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: Text(
                              "Riwayat Pembayaran",
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
              selectedIndex: _selectedParent,
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedParent = index;
                  _selectedChild[_selectedParent] = 0;
                  Navigator.pushNamed(
                      context,
                      AppRoutes.homeScreen(_selectedParent == 0
                          ? 'pasien'
                          : _selectedParent == 1
                              ? 'billing'
                              : 'riwayat'));
                });
              },
            ),
          ),
          Expanded(child: _getScreen()),
        ],
      ),
    );
  }
}
