import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:people_compatibility/core/routes/app_routes.dart';
import 'package:people_compatibility/presentation/pages/add_comparison_data_page/add_comparison_data.dart';
import 'package:people_compatibility/presentation/pages/add_comparison_data_page/state/comparison_data_page_state.dart';
import 'package:people_compatibility/presentation/pages/calculate_compatibility_page/calculate_compatibility_page.dart';
import 'package:people_compatibility/presentation/pages/calculate_compatibility_page/state/calculate_compatibility_page_state.dart';
import 'package:people_compatibility/presentation/pages/main_page/main_page.dart';
import 'package:people_compatibility/presentation/pages/main_page/state/main_page_state.dart';
import 'package:people_compatibility/presentation/theme/app_border_radius.dart';
import 'package:people_compatibility/presentation/theme/app_colors.dart';
import 'package:people_compatibility/presentation/theme/app_insets.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting();
  // final sp = await SharedPreferences.getInstance();
  // await sp.clear();
  // sp.setString(
  //   SharedPreferencesKeys.history,
  //   jsonEncode(
  //     [
  //       Comparison(
  //         femaleName: 'femaleName',
  //         maleName: 'maleName',
  //         date: DateTime.now().subtract(const Duration(days: 3650)),
  //       ).toMap,
  //       Comparison(
  //         femaleName: 'femaleName',
  //         maleName: 'maleName',
  //         date: DateTime.now().subtract(const Duration(days: 3650)),
  //       ).toMap,
  //       Comparison(
  //         femaleName: 'femaleName',
  //         maleName: 'maleName',
  //         date: DateTime.now().subtract(const Duration(days: 3650)),
  //       ).toMap,
  //       Comparison(
  //         femaleName: 'femaleName',
  //         maleName: 'maleName',
  //         date: DateTime.now().subtract(const Duration(days: 3650)),
  //       ).toMap,
  //     ],
  //   ),
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          elevation: 0,
          color: Colors.transparent,
          centerTitle: true,
        ),
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.transparent,
        ),
        scaffoldBackgroundColor: AppColors.deepBlue,
        textTheme: const TextTheme(
          headline1: TextStyle(
            color: AppColors.titleText,
            fontSize: 64,
            fontWeight: FontWeight.bold,
          ),
          headline2: TextStyle(
            color: AppColors.titleText,
            fontSize: 56,
            fontWeight: FontWeight.bold,
          ),
          headline3: TextStyle(
            color: AppColors.titleText,
            fontSize: 48,
            fontWeight: FontWeight.bold,
          ),
          headline4: TextStyle(
            color: AppColors.titleText,
            fontSize: 36,
            fontWeight: FontWeight.bold,
          ),
          headline5: TextStyle(
            color: AppColors.titleText,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          headline6: TextStyle(
            color: AppColors.titleText,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          bodyText1: TextStyle(
            color: AppColors.textGray,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          bodyText2: TextStyle(
            color: AppColors.textGray,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          fillColor: AppColors.white.withOpacity(0.1),
          filled: true,
          contentPadding: AppInsets.paddingAll16,
          hintStyle: TextStyle(
            fontSize: 16,
            color: AppColors.white.withOpacity(0.5),
            fontWeight: FontWeight.w400,
          ),
          border: const OutlineInputBorder(
            borderRadius: AppBorderRadius.borderAll16,
          ),
          disabledBorder: const OutlineInputBorder(
            borderRadius: AppBorderRadius.borderAll16,
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: AppBorderRadius.borderAll16,
          ),
          errorBorder: const OutlineInputBorder(
            borderRadius: AppBorderRadius.borderAll16,
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderRadius: AppBorderRadius.borderAll16,
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: AppBorderRadius.borderAll16,
          ),
        ),
      ),
      routes: {
        AppRoutes.initial: (context) => ChangeNotifierProvider(
              create: (context) => MainPageState(),
              child: const MainPage(),
            ),
        AppRoutes.comparisonData: (context) => ChangeNotifierProvider(
              create: (_) => ComparisonDataPageState(),
              child: const ComparisonDataPage(),
            ),
        AppRoutes.calculateCompatibility: (context) => ChangeNotifierProvider(
              create: (_) => CalculateCompatibilityPageState(),
              child: const CalculateCompatibilityPage(),
            ),
      },
      initialRoute: '/',
    );
  }
}
