import 'package:flutter/material.dart';
import 'package:people_compatibility/presentation/theme/app_border_radius.dart';
import 'package:people_compatibility/presentation/theme/app_colors.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final double? width;
  const CustomButton({
    Key? key,
    required this.onTap,
    required this.text,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: AppBorderRadius.borderAll12,
      elevation: 0,
      child: InkWell(
        borderRadius: AppBorderRadius.borderAll12,
        onTap: onTap,
        child: Ink(
          height: 48,
          width: width ?? MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(13),
          decoration: const BoxDecoration(
            borderRadius: AppBorderRadius.borderAll12,
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                AppColors.darkBlue,
                AppColors.purple,
              ],
            ),
          ),
          child: Center(
            child: Text(
              text,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ),
      ),
    );
  }
}
