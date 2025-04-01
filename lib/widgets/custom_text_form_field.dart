import 'package:flutter/material.dart';
import 'package:highway_weight/styles/colors.dart';
import 'package:highway_weight/styles/text_styles.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final String? hintText;
  final IconData? suffixIcon;
  final bool? obscureText;
  final Function()? onSuffixPressed;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final int? maxLines;

  const CustomTextFormField({
    super.key,
    this.onChanged,
    required this.labelText,
    this.hintText,
    this.suffixIcon,
    this.obscureText,
    this.onSuffixPressed,
    this.validator,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColors.brandSecondary,
      enableSuggestions: true,
      autocorrect: true,
      onChanged: onChanged,
      obscureText: obscureText ?? false,
      validator: validator,
      style: TextStyles.labelSemi,
      decoration: InputDecoration(
        label: Text(labelText),
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
