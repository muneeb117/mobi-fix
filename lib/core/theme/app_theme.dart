import 'package:flutter/material.dart';
import 'package:mobi_fix/core/theme/text_style.dart';
import 'package:mobi_fix/core/theme/text_theme.dart';

import 'app_colors.dart';

class AppTheme {
  final BuildContext context;

  AppTheme({required this.context});
  ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      fontFamily: AppTextStyles.fontFamily,
      primaryColor: AppColors.surface,
      primarySwatch: AppColors.primarySwatch,
      hintColor: AppColors.hint,
      shadowColor: AppColors.shadow,
      cardColor: AppColors.card,
      scaffoldBackgroundColor: AppColors.background,
      textTheme: TextThemes(context: context).darkTextTheme,
      primaryTextTheme: TextThemes(context: context).primaryTextTheme,
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: AppColors.background,
        titleTextStyle: AppTextStyles.titleLarge,
      ),
      colorScheme: const ColorScheme.dark(
        secondary: AppColors.secondary,
        surface: AppColors.background,
        primary: AppColors.primary,
        error: AppColors.error,
        scrim: AppColors.surface,
      ),
    );
  }
}
