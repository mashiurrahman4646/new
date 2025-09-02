import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Settings/appearance/ThemeController.dart' show ThemeController;
import '../Settings/language/language_controller.dart';
import '../routes/app_routes.dart';
import '../translation_rag.dart';


class AppColors {
  static const Color primary = Color(0xFF4CAF50);
  static const Color text900 = Color(0xFF212121);
  static const Color text50 = Color(0xFFFAFAFA);
}

class AppConfig {
  static final app = Obx(() {
    final themeController = Get.find<ThemeController>();
    final langController = Get.find<LanguageController>();

    // Force rebuild when language changes
    final currentLocale = langController.locale.value;
    final currentThemeMode = themeController.themeMode;

    return GetMaterialApp(
      title: 'Your Expense',
      debugShowCheckedModeBanner: false,

      // Multi-language support
      translations: AppTranslations(),
      locale: currentLocale,
      fallbackLocale: const Locale('en', 'US'),

      // Theme configuration
      theme: ThemeData(
        textTheme: GoogleFonts.interTextTheme(),
        scaffoldBackgroundColor: AppColors.text900,
        appBarTheme: const AppBarTheme(
          foregroundColor: AppColors.text50,
          backgroundColor: AppColors.text900,
          elevation: 0,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        textTheme: GoogleFonts.interTextTheme(),
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.white,
          backgroundColor: Colors.black,
          elevation: 0,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: currentThemeMode,

      initialRoute: AppRoutes.initial,
      getPages: AppRoutes.routes,
      navigatorObservers: [GetObserver()],
      defaultTransition: Transition.cupertino,
      opaqueRoute: Get.isOpaqueRouteDefault,
      popGesture: Get.isPopGestureEnable,
    );
  });
}