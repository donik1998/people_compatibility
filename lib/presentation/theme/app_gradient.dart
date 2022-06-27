import 'package:flutter/widgets.dart';
import 'package:people_compatibility/presentation/theme/app_colors.dart';

class AppGradient {
  AppGradient._();

  static const buttonGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      AppColors.darkBlue,
      AppColors.purple,
    ],
  );
}
