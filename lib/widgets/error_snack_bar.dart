import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:highway_weight/styles/colors.dart';
import 'package:highway_weight/styles/text_styles.dart';

class ErrorSnackBar extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;
  const ErrorSnackBar({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ToastCard(
      shadowColor: Colors.black12,
      color: AppColors.redColor,
      leading:
          icon != null
              ? Icon(icon)
              : Icon(
                FontAwesomeIcons.circleXmark,
                size: 28,
                color: AppColors.whitePrimary,
              ),
      title: Text(title, style: TextStyles.bodySemi.copyWith(color: AppColors.whitePrimary)),
      subtitle:
          subtitle != null ? Text(subtitle!, style: TextStyles.captionReg) : null,
    );
  }

  static void show(
    BuildContext context, {
    required String title,
    String? subtitle,
    IconData? icon,
  }) {
    DelightToastBar(
      autoDismiss: true,
      animationCurve: Curves.ease,
      snackbarDuration: const Duration(seconds: 2),
      animationDuration: const Duration(milliseconds: 300),
      position: DelightSnackbarPosition.top,
      builder: (context) {
        return ErrorSnackBar(title: title, subtitle: subtitle, icon: icon);
      },
    ).show(context);
  }
}
