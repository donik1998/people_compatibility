import 'package:flutter/material.dart';
import 'package:people_compatibility/presentation/theme/app_border_radius.dart';
import 'package:people_compatibility/presentation/theme/app_colors.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final double? width;
  final double? height;
  final Widget? child;

  const CustomButton._({
    Key? key,
    required this.onTap,
    this.text = '',
    this.width,
    this.height,
    this.child,
  }) : super(key: key);

  factory CustomButton.text({
    required String text,
    required VoidCallback onTap,
    double? width,
    double? height,
  }) =>
      CustomButton._(
        onTap: onTap,
        text: text,
        height: height,
        width: width,
      );

  factory CustomButton.child({
    required Widget child,
    required VoidCallback onTap,
    double? width,
    double? height,
  }) =>
      CustomButton._(
        onTap: onTap,
        child: child,
        width: width,
        height: height,
      );

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: AppBorderRadius.borderAll12,
      elevation: 0,
      child: InkWell(
        borderRadius: AppBorderRadius.borderAll12,
        onTap: onTap,
        child: Ink(
          height: height ?? 48,
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
            child: child ??
                Text(
                  text,
                  style: Theme.of(context).textTheme.headline6,
                ),
          ),
        ),
      ),
    );
  }
}
