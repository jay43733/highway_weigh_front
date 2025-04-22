import 'package:flutter/material.dart';
import 'package:highway_weight/styles/text_styles.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final Function() onPressed;
  const CustomTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child:
          icon != null
              ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Icon(icon, size: 20.0),
                  SizedBox(width: 8.0),
                  Text(text, style: TextStyles.labelReg,),
                ],
              )
              : Text(text, textAlign: TextAlign.center,),
    );
  }
}
