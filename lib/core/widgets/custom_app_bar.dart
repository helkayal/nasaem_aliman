import 'package:flutter/material.dart';
import 'package:nasaem_aliman/core/utils/responsive_utils.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.title, this.actions = const []});

  final String title;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(
          ResponsiveUtils.tabletAwareHeight(context, 10),
        ),
        child: SizedBox(height: ResponsiveUtils.tabletAwareHeight(context, 5)),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
    kToolbarHeight +
        ResponsiveUtils.responsiveHeight(
          10,
        ), // Static fallback for preferredSize
  );
}
