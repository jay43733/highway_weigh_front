import 'package:flutter/material.dart';
import 'package:highway_weight/styles/colors.dart';

class TextStyles {
  // Headings
  static const TextStyle h1Semi = TextStyle(
    fontSize: 56,
    fontWeight: FontWeight.w600,
    color: AppColors.blackPrimary,
    height: 70 / 56,
  );

  static const TextStyle h2Semi = TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.w600,
    color: AppColors.blackPrimary,
    height: 64 / 48,
  );

  static const TextStyle h3Semi = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    color: AppColors.blackPrimary,
    height: 48 / 32,
  );

  static const TextStyle h3Reg = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w400,
    color: AppColors.blackPrimary,
    height: 48 / 32,
  );

  static const TextStyle h4Semi = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.blackPrimary,
    height: 36 / 24,
  );

  static const TextStyle h4Reg = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    color: AppColors.blackPrimary,
    height: 36 / 24,
  );

  // Titles
  static const TextStyle titleSemi = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.blackPrimary,
    height: 33 / 20,
  );

  // Subtitles
  static const TextStyle subtitleSemi = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.blackPrimary,
    height: 30 / 18,
  );

  static const TextStyle subtitleReg = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: AppColors.blackPrimary,
    height: 30 / 18,
  );

  // Body
  static const TextStyle bodySemi = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 26 / 16,
  );

  static const TextStyle bodyReg = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.blackPrimary,
    height: 26 / 16,
  );

  // Labels
  static const TextStyle labelSemi = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.blackPrimary,
    height: 23 / 14,
  );

  static const TextStyle labelReg = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.blackPrimary,
    height: 23 / 14,
  );

  // Captions
  static const TextStyle captionReg = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.blackPrimary,
    height: 20 / 12,
  );

  // Buttons
  static const TextStyle ctaBodySemi = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.blackPrimary,
    height: 26 / 16,
  );

  static const TextStyle ctaBodyReg = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.blackPrimary,
    height: 26 / 16,
  );

  static const TextStyle ctaLabelSemi = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.blackPrimary,
    height: 23 / 14,
  );

  // Text Link
  static const TextStyle textLinkBodySemi = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    decoration: TextDecoration.underline,
    color: AppColors.brandSecondary,
    height: 26 / 16,
  );
}
