import 'package:flutter/material.dart';
import 'package:poli_admin/base/utils/app_styles.dart';

class GlobalTopBar extends StatelessWidget implements PreferredSize {
  final String title;
<<<<<<< HEAD

  const GlobalTopBar(
      {super.key,
      required this.title,});
=======
  final VoidCallback? toggleSidebar;
  final bool isExpand;

  const GlobalTopBar({
    super.key,
    required this.title,
    this.toggleSidebar,
    required this.isExpand,
  });
>>>>>>> a3db70518278aadc69b9fab306d1ffca0e6d4826

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
<<<<<<< HEAD
          // child: Icon(
          //   isExpanded ? Icons.close : Icons.menu,
          //   key: ValueKey(isExpanded),
          // ),
          child: Icon(Icons.menu),
        ),
        color: Colors.white,
        onPressed: () {},
=======
          child: Icon(
            isExpand ? Icons.close : Icons.menu,
            key: ValueKey(isExpand),
          ),
        ),
        color: Colors.white,
        onPressed: toggleSidebar,
>>>>>>> a3db70518278aadc69b9fab306d1ffca0e6d4826
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
