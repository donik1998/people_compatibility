import 'package:flutter/material.dart';
import 'package:people_compatibility/presentation/theme/app_colors.dart';
import 'package:people_compatibility/presentation/theme/app_gradient.dart';
import 'package:people_compatibility/presentation/theme/app_insets.dart';
import 'package:people_compatibility/presentation/theme/app_spacing.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: AppInsets.paddingAll4,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: AppGradient.buttonGradient,
          ),
          child: const Text(
            'Si',
            style: TextStyle(
              fontFamily: 'Monserat',
              fontWeight: FontWeight.w700,
              color: AppColors.white,
              fontSize: 24,
            ),
          ),
        ),
        AppSpacing.horizontalSpace4,
        const Text(
          'Astro.com',
          style: TextStyle(
            fontFamily: 'Monserat',
            fontWeight: FontWeight.w700,
            color: AppColors.white,
            fontSize: 22,
          ),
        ),
      ],
    );
  }
}
