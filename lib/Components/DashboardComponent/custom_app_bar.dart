import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  // final void Function()? logOut;

  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Dashboard"),
      actions: [
        // IconButton(onPressed: onPressed, icon: Icon(Icons.list)),
        //  IconButton(onPressed: logOut, icon: Icon(Icons.logout)),
        Icon(Icons.search),
        SizedBox(width: 12),
        Icon(Icons.notifications_none),
        SizedBox(width: 16),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
