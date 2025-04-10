import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final Color? color;
  final Function() onPressed;
  const PrimaryButton({
    super.key,
    required this.text,
    this.icon,
    required this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(color)),
      onPressed: onPressed,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) Icon(icon, size: 22.0,),
          SizedBox(width: 4.0),
          Text(text),
        ],
      ),
    );
  }
}
