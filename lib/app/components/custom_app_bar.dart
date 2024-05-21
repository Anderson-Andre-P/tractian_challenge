import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSize {
  final String title;
  final bool hasDrawer;
  final List<IconData>? actionIcons;
  final List<VoidCallback>? onIconPressed;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actionIcons,
    this.onIconPressed,
    this.hasDrawer = false,
  });

  @override
  Size get preferredSize => const Size.fromHeight(52.0);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return AppBar(
      title: Text(
        title,
        style: theme.textTheme.displayMedium?.copyWith(
          fontSize: 23.sp,
          fontWeight: FontWeight.w900,
          color: Colors.white,
        ),
      ),
      leading: hasDrawer
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              color: theme.iconTheme.color,
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          : null,
      centerTitle: true,
      backgroundColor: const Color(0xFF17192D),
      actions: _buildActionIcons(),
    );
  }

  List<Widget> _buildActionIcons() {
    List<Widget> widgets = [];

    if (actionIcons != null && onIconPressed != null) {
      for (int i = 0; i < actionIcons!.length; i++) {
        widgets.add(
          IconButton(
            icon: Icon(actionIcons![i]),
            onPressed: onIconPressed![i],
            color: Get.theme.iconTheme.color,
          ),
        );
      }
    }

    return widgets;
  }

  @override
  Widget get child => throw UnimplementedError();
}
