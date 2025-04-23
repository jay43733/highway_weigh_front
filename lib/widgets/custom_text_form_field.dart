import 'package:flutter/material.dart';
import 'package:highway_weight/styles/colors.dart';
import 'package:highway_weight/styles/text_styles.dart';

class CustomTextFormField extends StatelessWidget {
  final String? labelText;
  final String? initialValue;
  final String? hintText;
  final IconData? suffixIcon;
  final bool? obscureText;
  final Function()? onSuffixPressed;
  final Function()? onTap;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final int? maxLines;
  final bool? enabled;
  final bool? readOnly;
  final bool? useCursorClick;
  final TextEditingController? controller;

  const CustomTextFormField({
    super.key,
    this.onChanged,
    this.labelText,
    this.hintText,
    this.suffixIcon,
    this.obscureText,
    this.onSuffixPressed,
    this.validator,
    this.maxLines,
    this.initialValue,
    this.enabled = true,
    this.readOnly = false,
    this.useCursorClick = false,
    this.onTap,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onTap: onTap,
      mouseCursor:
          useCursorClick == true
              ? SystemMouseCursors.click
              : SystemMouseCursors.text,
      readOnly: readOnly ?? false,
      initialValue: controller == null ? initialValue : null,
      cursorColor: AppColors.brandSecondary,
      enableSuggestions: true,
      autocorrect: true,
      onChanged: onChanged,
      obscureText: obscureText ?? false,
      enabled: enabled ?? true,
      validator: validator,
      style:
          enabled == true
              ? TextStyles.labelSemi
              : TextStyles.labelSemi.copyWith(color: AppColors.greyPrimary),
      decoration: InputDecoration(
        label: Text(
          labelText ?? "",
          style:
              enabled == true
                  ? TextStyles.bodyReg.copyWith(color: AppColors.blackPure)
                  : TextStyles.bodyReg.copyWith(
                    color: AppColors.blackPlaceholder,
                  ),
        ),
        hintText: hintText,
        suffixIcon: IconButton(
          onPressed: onSuffixPressed,
          icon: Icon(suffixIcon),
        ),
      ),
      maxLines: maxLines ?? 1,
    );
  }
}
