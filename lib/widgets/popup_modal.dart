import 'package:flutter/material.dart';
import 'package:highway_weight/styles/colors.dart';
import 'package:highway_weight/styles/text_styles.dart';
import 'package:highway_weight/widgets/primary_button.dart';
import 'package:highway_weight/widgets/secondary_button.dart';

class PopupModal extends StatelessWidget {
  final String? title;
  final String? caption;
  final String? boldText;
  final String? secondaryButtonText;
  final String? primaryButtonText;
  final IconData? icon;
  final Function()? secondaryButtonOnPressed;
  final Function()? primaryButtonOnPressed;
  const PopupModal({
    super.key,
    this.title,
    this.caption,
    this.secondaryButtonText,
    this.primaryButtonText,
    this.secondaryButtonOnPressed,
    this.primaryButtonOnPressed,
    this.icon,
    this.boldText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 320.0, vertical: 180.0),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.whitePrimary,
              borderRadius: BorderRadius.circular(24.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 20.0,
                  offset: Offset(0, 10),
                ),
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 40.0,
                  offset: Offset(0, 24),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (title != null)
                  Center(
                    child: Text(
                      title!,
                      style: TextStyles.h3Semi.copyWith(
                        color: AppColors.blackPure,
                      ),
                    ),
                  ),
                SizedBox(height: 8.0),
                if (icon != null)
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          primaryButtonText == 'DELETE'
                              ? AppColors.redColor
                              : AppColors.greenColor,
                    ),
                    padding: const EdgeInsets.all(32.0),
                    child: Icon(
                      icon,
                      size: 48.0,
                      color: AppColors.whitePrimary,
                    ),
                  ),
                SizedBox(height: 32.0),
                if (caption != null)
                  Text(
                    caption!,
                    style: TextStyles.subtitleReg.copyWith(
                      color:
                          primaryButtonText == 'DELETE'
                              ? AppColors.redColor
                              : AppColors.blackPrimary,
                    ),
                    textAlign: TextAlign.center,
                    softWrap: true,
                  ),
                if (boldText != null) SizedBox(height: 10.0),
                Text(
                  boldText!,
                  style: TextStyles.titleSemi.copyWith(
                    color: AppColors.blackPrimary,
                  ),
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
                SizedBox(height: 32.0),
                if (secondaryButtonText != null &&
                    secondaryButtonOnPressed != null &&
                    primaryButtonText != null &&
                    primaryButtonOnPressed != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SecondaryButton(
                        text: secondaryButtonText!,
                        onPressed: secondaryButtonOnPressed!,
                      ),
                      SizedBox(width: 64.0),
                      PrimaryButton(
                        color:
                            primaryButtonText == 'DELETE'
                                ? AppColors.redColor
                                : AppColors.brandSecondary,
                        text: primaryButtonText!,
                        onPressed: primaryButtonOnPressed!,
                      ),
                    ],
                  ),
              ],
            ),
          ),
          Positioned(
            top: 4,
            right: 4,
            child: IconButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
              },
              icon: Icon(
                Icons.close,
                size: 28.0,
                color: AppColors.blackPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Future<void> showModal(
    BuildContext context, {
    String? primaryButtonText,
    Function()? secondaryButtonOnPressed,
    Function()? primaryButtonOnPressed,
    String? title,
    String? caption,
    String? boldText,
    String? secondaryButtonText,
    IconData? icon,
  }) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder:
          (context) => PopupModal(
            title: title,
            caption: caption,
            boldText: boldText,
            primaryButtonText: primaryButtonText,
            primaryButtonOnPressed: primaryButtonOnPressed,
            secondaryButtonText: secondaryButtonText,
            secondaryButtonOnPressed: secondaryButtonOnPressed,
            icon: icon,
          ),
    );
  }
}
