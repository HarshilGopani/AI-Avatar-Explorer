import 'package:ai_avatar_explorer_app/theme/theme.dart';
import 'package:flutter/material.dart';

class CustomMultiButton extends StatelessWidget {
  String? firstbtnText, secondbtnTxt;
  VoidCallback? firstOnPressed, secondOnPressed;
  TextStyle? firstStyle, secondStyle;
  Color? bordercolor;
  Color? buttoncolor;
  Color? secondbtnColor;
  bool? ispadding = false;
  bool? isspace = false;
  double? height;

  CustomMultiButton({
    super.key,
    required this.firstbtnText,
    required this.secondbtnTxt,
    required this.firstOnPressed,
    required this.secondOnPressed,
    this.buttoncolor,
    this.secondbtnColor,
    this.bordercolor,
    this.firstStyle,
    this.secondStyle,
    this.ispadding,
    this.isspace,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: firstOnPressed,
            child: Container(
              alignment: Alignment.center,
              height: Dimens.fourtyEight,
              decoration: BoxDecoration(
                color: buttoncolor ?? Colors.transparent,
                borderRadius: BorderRadius.circular(Dimens.sixteen),
                border: Border.all(
                  width: Dimens.one,
                  color: bordercolor ?? ColorsValue.blackColor,
                ),
              ),
              child: Text(
                firstbtnText ?? "",
                style: firstStyle ?? Styles.txtBlackColorW60016,
              ),
            ),
          ),
        ),
        isspace == true ? Dimens.box0 : Dimens.boxWidth10,
        Expanded(
          child: InkWell(
            onTap: secondOnPressed,
            child: Container(
              alignment: Alignment.center,
              height: Dimens.fourtyEight,
              decoration: BoxDecoration(
                color: secondbtnColor ?? ColorsValue.appColor,
                borderRadius: BorderRadius.circular(Dimens.sixteen),
              ),
              child: Text(
                secondbtnTxt ?? "",
                style: secondStyle ?? Styles.whiteColorW60016,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
