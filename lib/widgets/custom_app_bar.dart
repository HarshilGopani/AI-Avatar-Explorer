import 'package:ai_avatar_explorer_app/theme/theme.dart';
import 'package:ai_avatar_explorer_app/utilts/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({
    super.key,
    required this.onTapBack,
    required this.title,
    this.isBackVisible = true,
    this.isCenter = false,
    this.actions,
    this.leadingWidth,
  });

  void Function()? onTapBack;
  String title;
  bool isBackVisible;
  bool isCenter;
  List<Widget>? actions;
  double? leadingWidth;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorsValue.whiteColor,
      centerTitle: isCenter ? true : false,
      automaticallyImplyLeading: false,
      leadingWidth: leadingWidth,
      leading: Visibility(
        visible: isBackVisible,
        child: Padding(
          padding: Dimens.edgeInsets15,
          child: InkWell(
            onTap: onTapBack,
            child: SvgPicture.asset(
              AssetConstants.ic_back_arrow,
              colorFilter: ColorFilter.mode(
                ColorsValue.blackColor,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ),
      titleSpacing: Dimens.zero,
      title: Text(title, style: Styles.txtBlackColorW70024),
      actions: actions,
    );
  }

  static final _appBar = AppBar();

  @override
  Size get preferredSize => CustomAppBar._appBar.preferredSize;
}
