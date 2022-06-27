import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:people_compatibility/presentation/theme/app_colors.dart';
import 'package:people_compatibility/presentation/theme/app_gradient.dart';
import 'package:people_compatibility/presentation/theme/app_insets.dart';

class AppBodyBackground extends StatelessWidget {
  final Widget child;

  const AppBodyBackground({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 0,
            right: -157,
            child: Container(
              height: 314,
              width: 314,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppGradient.buttonGradient,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: -157,
            child: Container(
              height: 314,
              width: 314,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [AppColors.purple, AppColors.darkBlue],
                ),
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: AppColors.deepBlue.withOpacity(0.9),
            ),
          ),
          Padding(
            padding: AppInsets.paddingAll24,
            child: child,
          ),
        ],
      ),
    );
  }
}
