import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:highway_weight/styles/colors.dart';
import 'package:highway_weight/styles/text_styles.dart';

class CustomDottedContainer extends StatefulWidget {
  final String? imagePath;
  final String buttonName;
  final Function() onPressed;
  const CustomDottedContainer({
    super.key,
    this.imagePath,
    required this.buttonName,
    required this.onPressed,
  });

  @override
  State<CustomDottedContainer> createState() => _CustomDottedContainerState();
}

class _CustomDottedContainerState extends State<CustomDottedContainer> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onExit: (event) {
          setState(() {
            isHovered = false;
          });
        },
        onEnter: (event) {
          setState(() {
            isHovered = true;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color:
                isHovered
                    ? AppColors.greyPrimary.withValues(alpha: 0.1)
                    : Colors.transparent,
          ),
          child: DottedBorder(
            color: AppColors.greyPrimary,
            radius: Radius.circular(10.0),
            borderType: BorderType.RRect,
            strokeWidth: 1.5,
            dashPattern: [24, 18],
            padding: const EdgeInsets.symmetric(
              horizontal: 80.0,
              vertical: 60.0,
            ),
            child: Center(
              child: SizedBox(
                width: 400,
                child: Column(
                  children: [
                    if (widget.imagePath != null)
                      Image.asset(widget.imagePath!, width: 100.0),
                    SizedBox(height: 20.0),
                    Text(widget.buttonName, style: TextStyles.ctaBodySemi,),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
