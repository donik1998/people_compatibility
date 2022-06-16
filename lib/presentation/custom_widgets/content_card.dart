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

  const TappableColoredCardWrap({
    Key? key,
    required this.content,
    this.onTap,
    this.gradient,
    this.color,
    this.padding = AppInsets.paddingAll16,
    this.borderRadius = AppBorderRadius.borderAll16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding,
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
