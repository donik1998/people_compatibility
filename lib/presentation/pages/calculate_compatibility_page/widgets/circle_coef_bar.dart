import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:people_compatibility/presentation/theme/app_colors.dart';
import 'package:people_compatibility/presentation/theme/app_insets.dart';

class CircleCoefficientButton extends StatelessWidget {
  final int coefficient;
  final VoidCallback onTap;

  const CircleCoefficientButton({
    Key? key,
    required this.coefficient,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              AppColors.darkBlue,
              AppColors.purple,
            ],
          ),
          border: Border.all(
            width: 10,
            color: AppColors.almostBlackPurple,
          ),
        ),
        padding: AppInsets.paddingAll24,
        child: Center(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'K\n',
                  style: Theme.of(context).textTheme.headline4?.copyWith(fontSize: 22),
                ),
                TextSpan(
                  text: coefficient.toString(),
                  style: Theme.of(context).textTheme.headline4?.copyWith(fontSize: 32),
                ),
                TextSpan(
                  text: '\n${'points'.plural(coefficient)}',
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 18),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
