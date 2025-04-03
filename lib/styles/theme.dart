import 'package:flutter/material.dart';
import 'package:highway_weight/styles/colors.dart';
import 'package:highway_weight/styles/text_styles.dart';

class AppTheme {
  static final IconThemeData _iconTheme = IconThemeData(
    color: AppColors.blackPlaceholder,
    size: 22.0,
  );

  static final DropdownMenuThemeData _dropdownMenuThemeData =
      DropdownMenuThemeData(
        menuStyle: MenuStyle(
          backgroundColor: WidgetStatePropertyAll(AppColors.whitePrimary),
          shape: WidgetStatePropertyAll(
            ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          alignment: Alignment(0, 32),
        ),
      );

  static final InputDecorationTheme
  _inputDecorationTheme = InputDecorationTheme(
    floatingLabelStyle: TextStyles.bodyReg.copyWith(color: AppColors.blackPure),
    floatingLabelBehavior: FloatingLabelBehavior.auto,
    labelStyle: TextStyles.bodyReg,
    alignLabelWithHint: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(color: AppColors.blackPrimary, width: 1.0),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(color: AppColors.redColor, width: 2.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(color: AppColors.blackPlaceholder, width: 1.0),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(color: AppColors.blackDisabled, width: 1.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(color: AppColors.brandSecondary, width: 2.0),
    ),
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 20.0,
      vertical: 16.0,
    ),
    suffixIconColor: AppColors.greyPrimary,
    hintStyle: TextStyles.bodyReg.copyWith(color: AppColors.blackPlaceholder),
    errorStyle: TextStyles.labelReg.copyWith(color: AppColors.redColor),
  );

  static final FilledButtonThemeData _filledButtonThemeData =
      FilledButtonThemeData(
        style: ButtonStyle(
          animationDuration: const Duration(milliseconds: 300),
          alignment: Alignment.center,
          elevation: const WidgetStatePropertyAll(2.0),
          padding: const WidgetStatePropertyAll(EdgeInsets.all(20.0)),
          foregroundColor: WidgetStatePropertyAll(AppColors.whitePrimary),
          backgroundColor: WidgetStatePropertyAll(AppColors.brandSecondary),
          shadowColor: WidgetStatePropertyAll(AppColors.whitePrimary),
          mouseCursor: WidgetStatePropertyAll(SystemMouseCursors.click),
          textStyle: WidgetStatePropertyAll(TextStyles.labelReg),
          shape: WidgetStatePropertyAll(
            ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
          ),
        ),
      );

  static final OutlinedButtonThemeData _outlinedButtonThemeData =
      OutlinedButtonThemeData(
        style: ButtonStyle(
          animationDuration: Duration(milliseconds: 300),
          mouseCursor: WidgetStatePropertyAll(SystemMouseCursors.click),
          textStyle: WidgetStatePropertyAll(
            TextStyles.labelReg.copyWith(color: AppColors.whitePrimary),
          ),
          overlayColor: WidgetStatePropertyAll(AppColors.blackPure),
        ),
      );

  static final TextButtonThemeData _textButtonThemeData = TextButtonThemeData(
    style: ButtonStyle(
      textStyle: WidgetStatePropertyAll(TextStyles.labelReg),
      foregroundColor: WidgetStatePropertyAll(AppColors.blackPrimary),
      overlayColor: WidgetStatePropertyAll(AppColors.blackPure),
      animationDuration: const Duration(milliseconds: 300),
    ),
  );

  static final PopupMenuThemeData _popupMenuThemeData = PopupMenuThemeData(
    color: AppColors.blackPrimary,
    elevation: 4.0,
    labelTextStyle: WidgetStatePropertyAll(
      TextStyles.labelReg.copyWith(color: AppColors.whitePrimary),
    ),
    position: PopupMenuPosition.under,
    mouseCursor: WidgetStatePropertyAll(SystemMouseCursors.click),
  );

  static final DataTableThemeData _dataTableThemeData = DataTableThemeData(
    dataTextStyle: TextStyles.labelReg.copyWith(
      overflow: TextOverflow.ellipsis,
    ),
    headingRowColor: WidgetStatePropertyAll(AppColors.brandPrimary),
    headingTextStyle: TextStyles.bodySemi.copyWith(
      overflow: TextOverflow.ellipsis,
    ),
  );

  static final DialogThemeData _dialogThemeData = DialogThemeData(
    actionsPadding: const EdgeInsets.symmetric(
      horizontal: 64.0,
      vertical: 20.0,
    ),
    backgroundColor: AppColors.whitePrimary,
    contentTextStyle: TextStyles.bodySemi,
    alignment: Alignment.center,
    elevation: 10.0,
    shadowColor: AppColors.blackPrimary,
    titleTextStyle: TextStyles.h4Semi,
  );

  static final SnackBarThemeData _snackBarThemeData = SnackBarThemeData(
    backgroundColor: AppColors.whitePrimary,
    behavior: SnackBarBehavior.floating,
    contentTextStyle: TextStyles.bodySemi,
    shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
    showCloseIcon: true,
    closeIconColor: AppColors.blackPrimary,
    elevation: 20.0,
  );

  static final TooltipThemeData _tooltipThemeData = TooltipThemeData(
    showDuration: Duration(milliseconds: 300),
    verticalOffset: -40,
    textStyle: TextStyles.bodyReg.copyWith(color: AppColors.whitePrimary),
  );

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.bgColor,
    inputDecorationTheme: _inputDecorationTheme,
    primaryColor: AppColors.brandPrimary,
    iconTheme: _iconTheme,
    filledButtonTheme: _filledButtonThemeData,
    textButtonTheme: _textButtonThemeData,
    popupMenuTheme: _popupMenuThemeData,
    tooltipTheme: _tooltipThemeData,
    dataTableTheme: _dataTableThemeData,
    outlinedButtonTheme: _outlinedButtonThemeData,
    dropdownMenuTheme: _dropdownMenuThemeData,
    dialogTheme: _dialogThemeData,
    snackBarTheme: _snackBarThemeData,
    fontFamily: 'IBMPlexSansThai',
  );
}
