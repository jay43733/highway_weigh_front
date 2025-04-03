import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:highway_weight/styles/colors.dart';
import 'package:highway_weight/styles/text_styles.dart';

class SuccessSnackBar extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;
  const SuccessSnackBar({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ToastCard(
      shadowColor: Colors.black12,
      color: AppColors.whitePure,
      leading:
          icon != null
              ? Icon(icon)
              : Icon(
                Icons.check_circle_rounded,
                size: 32,
                color: AppColors.greenColor,
              ),
      title: Text(title, style: TextStyles.bodySemi),
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
      animationCurve: Curves.easeInOut,
      snackbarDuration: const Duration(seconds: 2),
      animationDuration: const Duration(milliseconds: 300),
      position: DelightSnackbarPosition.top,
      builder: (context) {
        return SuccessSnackBar(title: title, subtitle: subtitle, icon: icon);
      },
    ).show(context);
  }
}
