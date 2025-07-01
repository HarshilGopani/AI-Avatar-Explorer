import 'package:ai_avatar_explorer_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../theme/colors_value.dart';

// ignore: must_be_immutable
class CustomCountryTextField extends StatelessWidget {
  CustomCountryTextField({
    super.key,
    required this.text,
    required this.hintText,
    this.validation,
    this.initialvalue,
    this.onInputChanged,
    this.isShowText = false,
    this.isCompulsoryText = false,
    this.keyboardAction,
    this.textStyle,
    this.oninitialValidation,
    this.textEditingController,
    this.radius,
  });
  final String text;
  final String hintText;
  final String? Function(String?)? validation;
  final PhoneNumber? initialvalue;
  final Function(PhoneNumber)? onInputChanged;
  final Function(bool)? oninitialValidation;
  final TextEditingController? textEditingController;
  final bool isShowText;
  final bool isCompulsoryText;
  TextInputAction? keyboardAction;
  TextStyle? textStyle;
  double? radius;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isShowText
            ? isCompulsoryText
                ? Row(
                  children: [
                    Text(text, style: textStyle ?? Styles.txtBlackColorW60016),
                    Dimens.boxWidth3,
                    Text(
                      "*",
                      textAlign: TextAlign.start,
                      style: Styles.redColorW60014,
                    ),
                  ],
                )
                : Text(text, style: textStyle ?? Styles.txtBlackColorW60016)
            : Dimens.box0,
        Dimens.boxHeight4,
        InternationalPhoneNumberInput(
          textFieldController: textEditingController,
          validator: validation,
          onInputChanged: onInputChanged,
          onInputValidated: oninitialValidation,
          keyboardAction: keyboardAction,
          initialValue: initialvalue,
          autoValidateMode: AutovalidateMode.onUserInteraction,
          ignoreBlank: false,
          formatInput: false,
          selectorConfig: const SelectorConfig(
            selectorType: PhoneInputSelectorType.DROPDOWN,
            setSelectorButtonAsPrefixIcon: true,
            trailingSpace: false,
          ),
          selectorTextStyle: Styles.txtBlackColorW60014,
          textAlign: TextAlign.start,
          textStyle: Styles.txtBlackColorW60014,
          keyboardType: const TextInputType.numberWithOptions(
            signed: false,
            decimal: false,
          ),
          inputBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius ?? Dimens.eight),
            borderSide: BorderSide(
              width: Dimens.one,
              color: ColorsValue.blackColor,
            ),
          ),
          inputDecoration: InputDecoration(
            contentPadding: EdgeInsets.all(Dimens.thirteen),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius ?? Dimens.sixteen),
              borderSide: BorderSide(
                color: ColorsValue.blackColor,
                width: Dimens.two,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius ?? Dimens.sixteen),
              borderSide: BorderSide(
                color: ColorsValue.blackColor,
                width: Dimens.two,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius ?? Dimens.sixteen),
              borderSide: BorderSide(
                color: ColorsValue.blackColor,
                width: Dimens.two,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: Dimens.two,
                style: BorderStyle.solid,
                color: ColorsValue.redColor.withValues(alpha: 0.5),
              ),
              borderRadius: BorderRadius.circular(radius ?? Dimens.sixteen),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: Dimens.two,
                style: BorderStyle.solid,
                color: ColorsValue.redColor.withValues(alpha: 0.5),
              ),
              borderRadius: BorderRadius.circular(radius ?? Dimens.sixteen),
            ),
            hintText: hintText,
            hintStyle: Styles.txtColorGreyW40016,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius ?? Dimens.sixteen),
              borderSide: BorderSide(
                color: ColorsValue.blackColor,
                width: Dimens.two,
              ),
            ),
            errorStyle: Styles.redColorW40014,
            filled: true,
            fillColor: ColorsValue.whiteColor,
          ),
        ),
      ],
    );
  }
}
