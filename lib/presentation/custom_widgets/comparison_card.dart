import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:people_compatibility/core/models/comparison.dart';
import 'package:people_compatibility/presentation/theme/app_spacing.dart';

class ComparisonCard extends StatelessWidget {
  final CompatibilityData data;

  const ComparisonCard({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset('assets/images/svg/female.svg'),
            SvgPicture.asset('assets/images/svg/line.svg'),
            SvgPicture.asset('assets/images/svg/male.svg'),
          ],
        ),
        AppSpacing.horizontalSpace16,
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                data.female.name,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              AppSpacing.verticalSpace24,
              AppSpacing.verticalSpace24,
              Text(
                data.male.name,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
        ),
        Text(
          DateFormat('dd.MM.yyyy').format(data.date),
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    );
  }
}
