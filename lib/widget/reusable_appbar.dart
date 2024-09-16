import 'package:flutter/material.dart';
import 'package:getx_todo/utils/constants.dart';

class ReusableAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const ReusableAppBar({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      titleSpacing: 3.0,
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(color: cafe_noir,fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
