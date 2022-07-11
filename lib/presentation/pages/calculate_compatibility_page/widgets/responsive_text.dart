import 'package:flutter/material.dart';

class ResponsiveText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;

  const ResponsiveText({
    Key? key,
    required this.text,
    this.style,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hasSmallScreen = MediaQuery.of(context).size.width < 400;
    return Text(
      text,
      style: style?.copyWith(fontSize: hasSmallScreen ? 8 : style?.fontSize),
      textAlign: textAlign,
    );
  }
}
