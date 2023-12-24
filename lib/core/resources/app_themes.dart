import 'package:cleanex/core/resources/color_manager.dart';
import 'package:flutter/material.dart';

class AppThemes {
  static final ThemeData light = ThemeData.light().copyWith(
    primaryColor: AppColors.deepPurple,
    primaryColorLight: AppColors.deepPurple,
    primaryColorDark: AppColors.deepPurple,
    useMaterial3: false,
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.transparent),
    colorScheme: const ColorScheme.light().copyWith(
      primary: AppColors.deepPurple,
      secondary: AppColors.deepPurple,
    ),
  );
}
