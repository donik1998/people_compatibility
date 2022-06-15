import 'package:flutter/material.dart';
import 'package:people_compatibility/presentation/theme/app_border_radius.dart';
import 'package:people_compatibility/presentation/theme/app_insets.dart';

class TappableColoredCardWrap extends StatelessWidget {
  final Widget content;
  final Color color;
  final EdgeInsets? padding;
  final VoidCallback? onTap;

  const TappableColoredCardWrap({
    Key? key,
    required this.content,
    this.onTap,
    required this.color,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding ?? AppInsets.paddingAll16,
        decoration: BoxDecoration(
          color: color,
          borderRadius: AppBorderRadius.borderAll16,
        ),
        child: content,
      ),
    );
  }
}
