import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:poli_admin/base/backend/data_controller.dart';
import 'package:poli_admin/base/global_widgets/confirm_alert.dart';
import 'package:poli_admin/base/global_widgets/icon_text.dart';
import 'package:poli_admin/base/utils/app_media.dart';
import 'package:poli_admin/base/utils/app_routes.dart';
import 'package:poli_admin/base/utils/app_styles.dart';
import 'package:poli_admin/screens/billing/billing_screen.dart';
import 'package:poli_admin/screens/billing/detail_billing.dart';
import 'package:poli_admin/screens/list_pasien/list_pasien_screen.dart';
import 'package:poli_admin/screens/list_pasien/registrasi_screen.dart';
import 'package:poli_admin/screens/riwayat_pembayaran/riwayat_screen.dart';

class SideNavbar extends StatefulWidget {
  const SideNavbar({
    super.key,
  });

  @override
  State<SideNavbar> createState() => _SideNavbarState();
}

class _SideNavbarState extends State<SideNavbar> {
  PageController pageController = PageController();
  SideMenuController sideMenu = SideMenuController();
  int _selectedIndex = 0;
  bool _isExpanded = false;
  late bool priv = false;

  List<Widget> pages = [];

  void toggleSidebar() {
    setState(() {
      _isExpanded = !_isExpanded;

      pages = [
        ListPasienScreen(
          toggleSidebar: toggleSidebar,
          isExpand: _isExpanded,
          navigateToPage: (index) => navigateToPage(index),
        ),
        BillingScreen(
            isExpand: _isExpanded,
            toggleSidebar: toggleSidebar,
            navigateToPage: (index) => navigateToPage(index)),
        RiwayatScreen(
          isExpand: _isExpanded,
          toggleSidebar: toggleSidebar,
        ),
        RegistrasiScreen(
          isExpand: _isExpanded,
          toggleSidebar: toggleSidebar,
          navigateToPage: (index) => navigateToPage(index),
        ),
        DetailBilling(
          isExpand: _isExpanded,
          toggleSidebar: toggleSidebar,
          navigateToPage: (index) => navigateToPage(index),
          id: "",
        ),
      ];
    });
  }

  void navigateToPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
    pageController.jumpToPage(index);
  }

  @override
  void initState() {
    super.initState();

    cekSession();
    listPriv();
    sideMenu.addListener((index) {
      setState(() {
        _selectedIndex = index;
      });
      pageController.jumpToPage(index);
    });

    pages = [
      ListPasienScreen(
        toggleSidebar: toggleSidebar,
        isExpand: _isExpanded,
        navigateToPage: (index) => navigateToPage(index),
      ),
      BillingScreen(
        isExpand: _isExpanded,
        toggleSidebar: toggleSidebar,
        navigateToPage: (index) => navigateToPage(index),
      ),
      RiwayatScreen(
        isExpand: _isExpanded,
        toggleSidebar: toggleSidebar,
      ),
      RegistrasiScreen(
        isExpand: _isExpanded,
        toggleSidebar: toggleSidebar,
        navigateToPage: (index) => navigateToPage(index),
      ),
      DetailBilling(
        isExpand: _isExpanded,
        toggleSidebar: toggleSidebar,
        navigateToPage: (index) => navigateToPage(index),
        id: "",
      ),
    ];
  }

  void cekSession() async {
    bool session = await DataController().cekToken();
    // print('session checked');
    if (!session) {
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    }
  }

  void listPriv() async {
    var temp = await DataController().cekPriv(6);

    setState(() {
      priv = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SideMenu(
            controller: sideMenu,
            alwaysShowFooter: true,
            style: SideMenuStyle(
              backgroundColor: AppStyles.primaryColor,
              openSideMenuWidth: 270,
              compactSideMenuWidth: 72,
              displayMode: _isExpanded
                  ? SideMenuDisplayMode.open
                  : SideMenuDisplayMode.compact,
              selectedColor: Colors.white,
              selectedTitleTextStyle: AppStyles.sidebarText.copyWith(
                  color: AppStyles.primaryColor, fontWeight: FontWeight.w600),
              selectedIconColor: AppStyles.primaryColor,
              unselectedIconColor: Colors.white,
              unselectedTitleTextStyle: AppStyles.sidebarText
                  .copyWith(color: Colors.white, fontWeight: FontWeight.w600),
              itemOuterPadding:
                  EdgeInsets.symmetric(horizontal: 0, vertical: 2),
              itemInnerSpacing: 12,
              itemBorderRadius: BorderRadius.circular(0),
            ),
            title: Column(
              children: [
                _isExpanded
                    ? Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              AppMedia.logoRS,
                              width: 45,
                              height: 45,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Hospitel\nBantarangin',
                              style: AppStyles.tambahanText.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      )
                    : Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        child: Image.asset(
                          AppMedia.logoRS,
                          width: 45,
                          height: 45,
                          fit: BoxFit.contain,
                        ),
                      ),
                Divider(
                  thickness: 2,
                  color: Colors.white,
                )
              ],
            ),
            footer: Padding(
              padding: EdgeInsets.all(16),
              child: InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) => ConfirmAlert(
                            icon: FluentIcons.error_circle_12_regular,
                            boldText: 'Apakah anda yakin\ningin keluar?',
                            yesText: 'keluar',
                            yesFunc: () async {
                              await DataController().userLogout();

                              if (!context.mounted) return;
                              Navigator.pushReplacementNamed(
                                  context, AppRoutes.login);
                            },
                            color: AppStyles.redColor,
                          ));
                },
                child: _isExpanded
                    ? SizedBox(
                        width: _isExpanded ? 2000 : 0,
                        child: Opacity(
                          opacity: _isExpanded ? 1.0 : 0.0,
                          child: IconText(
                              icon: Icons.logout,
                              text: 'Logout',
                              isIcon: true,
                              style: AppStyles.sidebarText.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                              iconColor: Colors.white),
                        ),
                      )
                    : IconText(
                        icon: Icons.logout,
                        isIcon: false,
                        iconColor: Colors.white),
              ),
            ),
            items: [
              SideMenuItem(
                  title: 'List Pasien',
                  onTap: (index, _) {
                    sideMenu.changePage(index);
                  },
                  icon: Icon(_selectedIndex == 0
                      ? FluentIcons.contact_card_16_filled
                      : FluentIcons.contact_card_16_regular)),
              priv
                  ? SideMenuItem(
                      title: 'List Tagihan',
                      onTap: (index, _) {
                        sideMenu.changePage(index);
                      },
                      icon: Icon(_selectedIndex == 1
                          ? FluentIcons.receipt_16_filled
                          : FluentIcons.receipt_16_regular))
                  : SideMenuItem(builder: (context, displayMode) {
                      return SizedBox.shrink();
                    }),
              SideMenuItem(
                  title: 'Riwayat Pembayaran',
                  onTap: (index, _) {
                    sideMenu.changePage(index);
                  },
                  icon: Icon(_selectedIndex == 2
                      ? FluentIcons.history_16_filled
                      : FluentIcons.history_16_regular)),
            ],
          ),
          VerticalDivider(
            width: 0,
          ),
          Expanded(
              child: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: pageController,
            children: pages,
          ))
        ],
      ),
    );
  }
}
