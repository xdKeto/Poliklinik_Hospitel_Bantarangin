import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:poli_suster/base/global_widgets/icon_text.dart';
import 'package:poli_suster/base/utils/app_styles.dart';
import 'package:tab_container/tab_container.dart';

class HomeTabs extends StatefulWidget {
  const HomeTabs({super.key});

  @override
  State<HomeTabs> createState() => _HomeTabsState();
}

class _HomeTabsState extends State<HomeTabs>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TabContainer(
        borderRadius: BorderRadius.circular(6),
        tabBorderRadius: BorderRadius.circular(6),
        tabMaxLength: 250,
        curve: Curves.easeIn,
        transitionBuilder: (child, animation) {
          animation = CurvedAnimation(curve: Curves.easeIn, parent: animation);
          return SlideTransition(
            position: Tween(
              begin: const Offset(0.2, 0.0),
              end: const Offset(0.0, 0.0),
            ).animate(animation),
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        },
        color: Colors.white,
        tabs: [
          IconText(
              icon: FluentIcons.clipboard_bullet_list_16_regular,
              isIcon: true,
              iconColor: AppStyles.primaryColor,
              text: 'Rincian Pasien',
              style: AppStyles.subheadingText.copyWith(
                  color: AppStyles.primaryColor, fontWeight: FontWeight.w600)),
          IconText(
              icon: Icons.history,
              isIcon: true,
              iconColor: AppStyles.primaryColor,
              text: 'Riwayat Screening',
              style: AppStyles.subheadingText.copyWith(
                  color: AppStyles.primaryColor, fontWeight: FontWeight.w600)),
          IconText(
              icon: FluentIcons.clipboard_arrow_right_16_regular,
              isIcon: true,
              iconColor: AppStyles.primaryColor,
              text: 'Input Screening',
              style: AppStyles.subheadingText.copyWith(
                  color: AppStyles.primaryColor, fontWeight: FontWeight.w600)),
        ],
        children: [
          Center(
            child: Text('Rincian'),
          ),
          Center(
            child: Text('Riwayat'),
          ),
          Center(
            child: Text('Input'),
          ),
        ],
      ),
    );
  }
}
