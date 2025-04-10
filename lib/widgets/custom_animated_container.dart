import 'dart:typed_data';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:highway_weight/styles/colors.dart';

class CustomAnimatedContainer extends StatelessWidget {
  final Uint8List? imagePath;
  final String? imageUrl;
  final Function() onPressed;

  const CustomAnimatedContainer({
    super.key,
    this.imagePath,
    required this.onPressed,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    print("Url: $imageUrl");
    // print("Image: $imagePath");
    return Stack(
      children: [
        DottedBorder(
          color: AppColors.brandSecondary,
          radius: Radius.circular(10.0),
          borderType: BorderType.RRect,
          strokeWidth: 2,
          dashPattern: [18, 20],
          child: Center(
            child: Container(
              height: 400,
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 8.0,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child:
                  imagePath != null
                      ? Image.memory(
                        imagePath!,
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.fitHeight,
                      )
                      : Image.network(
                        imageUrl!,
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.cover,
                      ),
            ),
          ),
        ),
        Positioned(
          top: 2,
          right: 2,
          child: IconButton(
            onPressed: onPressed,
            icon: Icon(Icons.cancel, size: 32.0, color: AppColors.redColor),
          ),
        ),
      ],
    );
  }
}
