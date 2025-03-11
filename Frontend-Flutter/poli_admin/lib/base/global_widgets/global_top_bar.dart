import 'package:flutter/material.dart';
import 'package:poli_admin/base/backend/data_controller.dart';
import 'package:poli_admin/base/utils/app_styles.dart';

class GlobalTopBar extends StatelessWidget implements PreferredSize {
  final String title;
  final VoidCallback? toggleSidebar;
  final bool isExpand;

  const GlobalTopBar({
    super.key,
    required this.title,
    this.toggleSidebar,
    required this.isExpand,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // print(name);
    return FutureBuilder(
      future: DataController().namaAdming(),
      builder: (context, snapshot) {
        return AppBar(
          title: Text(
            title,
            style: AppStyles.subheadingText.copyWith(color: Colors.white),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: AppStyles.primaryColor,
          leading: IconButton(
            icon: AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              transitionBuilder: (child, animation) => FadeTransition(
                opacity: animation,
                child: ScaleTransition(scale: animation, child: child),
              ),
              child: Icon(
                isExpand ? Icons.close : Icons.menu,
                key: ValueKey(isExpand),
              ),
            ),
            color: Colors.white,
            onPressed: toggleSidebar,
          ),
          actions: [
            Text(
              DataController().nama ?? "Nama",
              style: AppStyles.sidebarText.copyWith(
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 8,
            ),
            CircleAvatar(
              radius: screenWidth * 0.01,
              backgroundImage: const NetworkImage(
                'https://static.vecteezy.com/system/resources/thumbnails/009/292/244/small/default-avatar-icon-of-social-media-user-vector.jpg',
              ) as ImageProvider,
            ),
            SizedBox(
              width: 24,
            ),
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget get child => throw UnimplementedError();
}
