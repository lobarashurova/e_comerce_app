import 'package:auto_route/auto_route.dart';
import 'package:e_comerce_app/common/extensions/text_extensions.dart';
import 'package:e_comerce_app/common/extensions/theme_extensions.dart';
import 'package:e_comerce_app/common/gen/assets.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BaseAppBar({
    super.key,
    this.title,
    this.actions,
    this.centerTitle = true,
    this.leading,
    this.hasIcon = false,
  });

  final String? title;
  final bool centerTitle;
  final List<Widget>? actions;
  final Widget? leading;
  final bool hasIcon;

  @override
  Widget build(BuildContext context) {
    final canPop = context.router.canPop();
    return AppBar(
      elevation: 1,
      iconTheme: IconThemeData(color: context.colors.label),
      leading: leading ?? (canPop ? appBarLeading(context) : null),
      centerTitle: centerTitle,
      title: hasIcon
          ? Assets.icons.delete.svg(width: 96, height: 28)
          : (title ?? '').w(600).s(16).c(context.colors.onPrimary),
      actions: actions,
      backgroundColor: context.colors.primary2,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(52);
}

Widget appBarLeading(BuildContext context) {
  return IconButton(
    onPressed: () => context.router.maybePop(),
    iconSize: 36,
    icon: Icon(CupertinoIcons.chevron_left, color: context.colors.onPrimary),
  );
}
