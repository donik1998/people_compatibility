import 'package:flutter/material.dart';
import 'package:people_compatibility/presentation/theme/app_border_radius.dart';
import 'package:people_compatibility/presentation/theme/app_insets.dart';

class TappableColoredCardWrap extends StatelessWidget {
  final Widget content;
  final Color? color;
  final EdgeInsets padding;
  final BorderRadius borderRadius;
  final VoidCallback? onTap;
  final Gradient? gradient;
  final double? width;
  final double? height;

  const TappableColoredCardWrap({
    Key? key,
    required this.content,
    this.onTap,
    this.gradient,
    this.color,
    this.padding = AppInsets.paddingAll16,
    this.borderRadius = AppBorderRadius.borderAll16,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: padding,
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          gradient: gradient,
          borderRadius: borderRadius,
        ),
        child: content,
      ),
    );
  }
}
