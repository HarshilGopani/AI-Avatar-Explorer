import 'package:ai_avatar_explorer_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/colors_value.dart';
import '../theme/dimens.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({
    super.key,
    required this.onTap,
    required this.text,
    this.height,
    this.width,
    this.backgroundColor,
    this.radius,
    this.style,
    this.side,
    this.iconAD = false,
    this.icon,
    this.assetName,
    this.iconSize,
    this.trailing,
    this.iconColor,
  });
  final String? assetName;
  final String? text;
  final double? iconSize;
  final double? height;
  final double? width;
  final Color? backgroundColor;
  final BorderRadiusGeometry? radius;
  final Function()? onTap;
  final TextStyle? style;
  final BoxBorder? side;
  final bool iconAD;
  final IconData? icon;
  final Color? iconColor;
  final Widget? trailing;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) => Column(
    children: [
      InkWell(
        onTap: widget.onTap,
        child: Container(
          width: widget.width ?? double.infinity,
          height: widget.height,
          decoration: BoxDecoration(
            color: widget.backgroundColor ?? ColorsValue.appColor,
            borderRadius: widget.radius ?? BorderRadius.circular(Dimens.twelve),
            border: widget.side,
          ),
          child:
              widget.iconAD
                  ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      widget.assetName == null
                          ? Icon(widget.icon, color: widget.iconColor)
                          : SvgPicture.asset(
                            widget.assetName!,
                            height: widget.iconSize,
                            width: widget.iconSize,
                            colorFilter: ColorFilter.mode(
                              widget.iconColor ?? ColorsValue.blackColor,
                              BlendMode.srcIn,
                            ),
                          ),
                      Dimens.boxWidth15,
                      Text(
                        widget.text!,
                        style: widget.style ?? Styles.whiteColorW60016,
                      ),
                    ],
                  )
                  : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.text!,
                        style: widget.style ?? Styles.whiteColorW60016,
                      ),
                      widget.trailing == null
                          ? const SizedBox()
                          : Dimens.boxWidth10,
                      widget.trailing ?? const SizedBox(),
                    ],
                  ),
        ),
      ),
    ],
  );
}
