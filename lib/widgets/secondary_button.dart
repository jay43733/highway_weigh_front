import 'package:flutter/material.dart';
import 'package:highway_weight/styles/colors.dart';
import 'package:highway_weight/styles/text_styles.dart';

class SecondaryButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final Function() onPressed;
  const SecondaryButton({
    super.key,
    required this.text,
    this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      animationDuration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.all(20.0),
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: BorderSide(color: AppColors.blackPrimary, width: 1),
      ),
      onPressed: onPressed,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) Icon(icon),
          SizedBox(width: 4.0),
          Text(text, style: TextStyles.labelReg),
        ],
      ),
    );
  }
}
