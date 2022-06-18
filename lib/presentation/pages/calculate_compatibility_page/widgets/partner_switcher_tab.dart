import 'package:flutter/material.dart';
import 'package:people_compatibility/presentation/theme/app_spacing.dart';

class PartnerSwitcherTab extends StatelessWidget {
  final String name;
  final String zodiacName;
  final Widget zodiacIcon;
  final Color color;
  final VoidCallback onTap;

  const PartnerSwitcherTab({
    Key? key,
    required this.name,
    required this.onTap,
    required this.color,
    required this.zodiacName,
    required this.zodiacIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipPath(
        clipper: _TabClipper(),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
          decoration: BoxDecoration(
            color: color,
          ),
          width: 148,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                name,
                style: Theme.of(context).textTheme.bodyText1?.copyWith(fontWeight: FontWeight.w600),
              ),
              AppSpacing.verticalSpace6,
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  zodiacIcon,
                  AppSpacing.horizontalSpace8,
                  Text(
                    zodiacName,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TabClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final width = size.width;
    final height = size.height;
    final path = Path();
    path.moveTo(width, height);
    path.lineTo(width - 10, 20);
    path.quadraticBezierTo(width - 15, 0, width - 30, 0);
    path.lineTo(15, 0);
    path.quadraticBezierTo(0, 5, 0, 20);
    path.lineTo(0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
