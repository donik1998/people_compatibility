import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:people_compatibility/presentation/theme/app_border_radius.dart';
import 'package:people_compatibility/presentation/theme/app_colors.dart';
import 'package:people_compatibility/presentation/theme/app_insets.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback? onTap;

  const CustomBackButton({
    Key? key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: AppBorderRadius.borderAll10,
        side: BorderSide(color: AppColors.titleText, width: 1),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          if (onTap != null) {
            onTap!.call();
          } else {
            Navigator.pop(context);
          }
        },
        child: Ink(
          height: 40,
          width: 40,
          color: Colors.transparent,
          padding: AppInsets.paddingAll12,
          child: SvgPicture.asset('assets/images/svg/arrow_back.svg'),
        ),
      ),
    );
  }
}
