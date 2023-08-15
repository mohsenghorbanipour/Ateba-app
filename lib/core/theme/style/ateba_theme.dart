// ignore_for_file: deprecated_member_use
import 'package:ateba_app/core/resources/assets/assets.dart';
import 'package:ateba_app/core/theme/data/theme_cache.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:flutter/material.dart';

enum theme { system, light, dark }


class AtebaTheme {
  static bool isDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? true : false;

  static Future<String> getThemeId() async {
    String currentThemeId = await ThemeCache.getThemeId();
    if (currentThemeId == ThemeMode.light.toString() ||
        currentThemeId == ThemeMode.dark.toString()) {
      return currentThemeId;
    } else {
      return getThemeIdBySystem();
    }
  }

  static String getThemeIdBySystem() =>
      isSystemDark() ? ThemeMode.dark.toString() : ThemeMode.light.toString();

  static bool isSystemDark() =>
      WidgetsBinding.instance.window.platformBrightness == Brightness.dark;

  static final ThemeData light = ThemeData(
    useMaterial3: true,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: Assets.yekanBakhFont,
    brightness: Brightness.light,
    primaryColor: ColorPalette.light.primary,
    // shadowColor: ColorPalette.light.black.withOpacity(0.8),
    cardColor: ColorPalette.light.background,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    // dividerColor: ColorPalette.light.border,
    // hintColor: ColorPalette.light.border,
    // inputDecorationTheme: InputDecorationTheme(
    //   filled: true,
    //   fillColor: ColorPalette.light.scaffoldBackground,
    //   border: OutlineInputBorder(
    //     borderRadius: BorderRadius.circular(8),
    //     borderSide: BorderSide(color: ColorPalette.light.border, width: 1),
    //   ),
    // ),
    // elevatedButtonTheme: ElevatedButtonThemeData(
    //   style: ButtonStyle(
    //     backgroundColor: MaterialStateProperty.all(ColorPalette.light.primary),
    //     foregroundColor: MaterialStateProperty.all(Colors.white),
    //     elevation: MaterialStateProperty.all(0),
    //     shape: MaterialStateProperty.all(
    //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    //     ),
    //     textStyle: MaterialStateProperty.all(
    //       TextStyle(
    //         fontSize: 16,
    //         fontWeight: FontWeight.w700,
    //         color: ColorPalette.light.white,
    //         fontFamily: Assets.yekanBakhFont,
    //       ),
    //     ),
    //   ),
    // ),
    textTheme: TextTheme(
      labelSmall: Typography.englishLike2021.labelSmall?.copyWith(
        height: 1.5,
        letterSpacing: 0,
        color: ColorPalette.light.textPrimary,
        fontSize: 10,
        fontFamily: Assets.yekanBakhFont,
        fontWeight: FontWeight.w500,
      ),
      labelMedium: Typography.englishLike2021.labelMedium?.copyWith(
        height: 1.5,
        letterSpacing: 0,
        color: ColorPalette.light.textPrimary,
        fontSize: 12,
        fontFamily: Assets.yekanBakhFont,
        fontWeight: FontWeight.w400,
      ),
      labelLarge: Typography.englishLike2021.labelLarge?.copyWith(
        height: 1.5,
        letterSpacing: 0,
        color: ColorPalette.light.textPrimary,
        fontSize: 14,
        fontFamily: Assets.yekanBakhFont,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: Typography.englishLike2021.bodySmall?.copyWith(
        height: 1.5,
        letterSpacing: 0,
        color: ColorPalette.light.textPrimary,
        fontSize: 12,
        fontFamily: Assets.yekanBakhFont,
        fontWeight: FontWeight.w500,
      ),
      bodyMedium: Typography.englishLike2021.bodyMedium?.copyWith(
        height: 1.5,
        letterSpacing: 0,
        color: ColorPalette.light.textPrimary,
        fontSize: 14,
        fontFamily: Assets.yekanBakhFont,
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: Typography.englishLike2021.bodyLarge?.copyWith(
        height: 1.5,
        letterSpacing: 0,
        color: ColorPalette.light.textPrimary,
        fontSize: 16,
        fontFamily: Assets.yekanBakhFont,
        fontWeight: FontWeight.w400,
      ),
      headlineSmall: Typography.englishLike2021.headlineSmall?.copyWith(
        height: 1.5,
        letterSpacing: 0,
        color: ColorPalette.light.textPrimary,
        fontSize: 16,
        fontFamily: Assets.yekanBakhFont,
        fontWeight: FontWeight.w500,
      ),
      headlineMedium: Typography.englishLike2021.headlineMedium?.copyWith(
        height: 1.5,
        letterSpacing: 0,
        color: ColorPalette.light.textPrimary,
        fontSize: 20,
        fontFamily: Assets.yekanBakhFont,
        fontWeight: FontWeight.w400,
      ),
      headlineLarge: Typography.englishLike2021.headlineLarge?.copyWith(
        height: 1.5,
        letterSpacing: 0,
        color: ColorPalette.light.textPrimary,
        fontSize: 24,
        fontFamily: Assets.yekanBakhFont,
        fontWeight: FontWeight.w400,
      ),
      displaySmall: Typography.englishLike2021.displaySmall?.copyWith(
        height: 1.5,
        letterSpacing: 0,
        color: ColorPalette.light.textPrimary,
        fontSize: 24,
        fontFamily: Assets.yekanBakhFont,
        fontWeight: FontWeight.w500,
      ),
      displayMedium: Typography.englishLike2021.displayMedium?.copyWith(
        height: 1.5,
        letterSpacing: 0,
        color: ColorPalette.light.textPrimary,
        fontSize: 32,
        fontFamily: Assets.yekanBakhFont,
        fontWeight: FontWeight.w400,
      ),
      displayLarge: Typography.englishLike2021.displayLarge?.copyWith(
        height: 1.5,
        letterSpacing: 0,
        color: ColorPalette.light.textPrimary,
        fontSize: 48,
        fontFamily: Assets.yekanBakhFont,
        fontWeight: FontWeight.w400,
      ),
      titleSmall: Typography.englishLike2021.titleSmall?.copyWith(
        height: 1.5,
        letterSpacing: 0,
        color: ColorPalette.light.textPrimary,
        fontSize: 14,
        fontFamily: Assets.yekanBakhFont,
        fontWeight: FontWeight.w700,
      ),
      titleMedium: Typography.englishLike2021.titleMedium?.copyWith(
        height: 1.5,
        letterSpacing: 0,
        color: ColorPalette.light.textPrimary,
        fontSize: 16,
        fontFamily: Assets.yekanBakhFont,
        fontWeight: FontWeight.w700,
      ),
      titleLarge: Typography.englishLike2021.titleLarge?.copyWith(
        height: 1.5,
        letterSpacing: 0,
        color: ColorPalette.light.textPrimary,
        fontSize: 20,
        fontFamily: Assets.yekanBakhFont,
        fontWeight: FontWeight.w700,
      ),
    ).apply(),
  );

  static final ThemeData dark = ThemeData(
    useMaterial3: true,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: Assets.yekanBakhFont,
    brightness: Brightness.dark,
    hoverColor: Colors.transparent,
    primaryColor: ColorPalette.dark.primary,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(ColorPalette.dark.primary),
        foregroundColor:
            MaterialStateProperty.all(ColorPalette.dark.textPrimary),
        elevation: MaterialStateProperty.all(0),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    ),
    textTheme: TextTheme(
      labelSmall: Typography.englishLike2021.labelSmall?.copyWith(
        height: 1.5,
        letterSpacing: 0,
        color: ColorPalette.dark.textPrimary,
        fontSize: 10,
        fontFamily: Assets.yekanBakhFont,
        fontWeight: FontWeight.w500,
      ),
      labelMedium: Typography.englishLike2021.labelMedium?.copyWith(
        height: 1.5,
        letterSpacing: 0,
        color: ColorPalette.dark.textPrimary,
        fontSize: 12,
        fontFamily: Assets.yekanBakhFont,
        fontWeight: FontWeight.w400,
      ),
      labelLarge: Typography.englishLike2021.labelLarge?.copyWith(
        height: 1.5,
        letterSpacing: 0,
        color: ColorPalette.dark.textPrimary,
        fontSize: 14,
        fontFamily: Assets.yekanBakhFont,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: Typography.englishLike2021.bodySmall?.copyWith(
        height: 1.5,
        letterSpacing: 0,
        color: ColorPalette.dark.textPrimary,
        fontSize: 12,
        fontFamily: Assets.yekanBakhFont,
        fontWeight: FontWeight.w500,
      ),
      bodyMedium: Typography.englishLike2021.bodyMedium?.copyWith(
        height: 1.5,
        letterSpacing: 0,
        color: ColorPalette.dark.textPrimary,
        fontSize: 14,
        fontFamily: Assets.yekanBakhFont,
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: Typography.englishLike2021.bodyLarge?.copyWith(
        height: 1.5,
        letterSpacing: 0,
        color: ColorPalette.dark.textPrimary,
        fontSize: 16,
        fontFamily: Assets.yekanBakhFont,
        fontWeight: FontWeight.w400,
      ),
      headlineSmall: Typography.englishLike2021.headlineSmall?.copyWith(
        height: 1.5,
        letterSpacing: 0,
        color: ColorPalette.dark.textPrimary,
        fontSize: 16,
        fontFamily: Assets.yekanBakhFont,
        fontWeight: FontWeight.w500,
      ),
      headlineMedium: Typography.englishLike2021.headlineMedium?.copyWith(
        height: 1.5,
        letterSpacing: 0,
        color: ColorPalette.dark.textPrimary,
        fontSize: 20,
        fontFamily: Assets.yekanBakhFont,
        fontWeight: FontWeight.w400,
      ),
      headlineLarge: Typography.englishLike2021.headlineLarge?.copyWith(
        height: 1.5,
        letterSpacing: 0,
        color: ColorPalette.dark.textPrimary,
        fontSize: 24,
        fontFamily: Assets.yekanBakhFont,
        fontWeight: FontWeight.w400,
      ),
      displaySmall: Typography.englishLike2021.displaySmall?.copyWith(
        height: 1.5,
        letterSpacing: 0,
        color: ColorPalette.dark.textPrimary,
        fontSize: 24,
        fontFamily: Assets.yekanBakhFont,
        fontWeight: FontWeight.w500,
      ),
      displayMedium: Typography.englishLike2021.displayMedium?.copyWith(
        height: 1.5,
        letterSpacing: 0,
        color: ColorPalette.dark.textPrimary,
        fontSize: 32,
        fontFamily: Assets.yekanBakhFont,
        fontWeight: FontWeight.w400,
      ),
      displayLarge: Typography.englishLike2021.displayLarge?.copyWith(
        height: 1.5,
        letterSpacing: 0,
        color: ColorPalette.dark.textPrimary,
        fontSize: 48,
        fontFamily: Assets.yekanBakhFont,
        fontWeight: FontWeight.w400,
      ),
      titleSmall: Typography.englishLike2021.titleSmall?.copyWith(
        height: 1.5,
        letterSpacing: 0,
        color: ColorPalette.dark.textPrimary,
        fontSize: 14,
        fontFamily: Assets.yekanBakhFont,
        fontWeight: FontWeight.w700,
      ),
      titleMedium: Typography.englishLike2021.titleMedium?.copyWith(
        height: 1.5,
        letterSpacing: 0,
        color: ColorPalette.dark.textPrimary,
        fontSize: 16,
        fontFamily: Assets.yekanBakhFont,
        fontWeight: FontWeight.w700,
      ),
      titleLarge: Typography.englishLike2021.titleLarge?.copyWith(
        height: 1.5,
        letterSpacing: 0,
        color: ColorPalette.dark.textPrimary,
        fontSize: 20,
        fontFamily: Assets.yekanBakhFont,
        fontWeight: FontWeight.w700,
      ),
    ).apply(),
  );
}
