import 'package:flutter/material.dart';
import 'package:poli_admin/base/utils/app_styles.dart';

class GlobalTopBar extends StatelessWidget implements PreferredSize {
  final String title;
  final VoidCallback onMenuPressed;
  final bool isExpanded;
  const GlobalTopBar(
      {super.key,
      required this.onMenuPressed,
      required this.title,
      required this.isExpanded});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
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
            isExpanded ? Icons.close : Icons.menu,
            key: ValueKey(isExpanded),
          ),
        ),
        color: Colors.white,
        onPressed: onMenuPressed,
      ),
      actions: [
        Text(
          'Nama Admin',
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
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget get child => throw UnimplementedError();
}
