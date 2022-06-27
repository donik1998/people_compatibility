import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:people_compatibility/presentation/theme/app_border_radius.dart';
import 'package:people_compatibility/presentation/theme/app_colors.dart';
import 'package:people_compatibility/presentation/theme/app_gradient.dart';
import 'package:people_compatibility/presentation/theme/app_spacing.dart';

class CoefficientChart extends StatelessWidget {
  final List<int> coefficients;
  final ValueChanged<int> onBarSelected;
  final int initialIndex;

  const CoefficientChart({
    Key? key,
    required this.coefficients,
    required this.onBarSelected,
    required this.initialIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 190,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int i = 0; i < 170 / 20; i++)
                Divider(
                  height: 20,
                  thickness: 1,
                  color: AppColors.white.withOpacity(0.1),
                ),
            ],
          ),
          if (coefficients.isEmpty)
            Center(
              child: Text(
                'no_data'.tr(),
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          if (coefficients.isNotEmpty)
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (int i = 0; i < coefficients.length; i++)
                  GestureDetector(
                    onTap: () {
                      onBarSelected(i);
                    },
                    child: SizedBox(
                      width: 20,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 20,
                            height: max((coefficients.elementAt(i) / maxCoefficient()) * 160, 24),
                            padding: const EdgeInsets.only(top: 6),
                            decoration: BoxDecoration(
                              color: initialIndex == i ? null : AppColors.chartBarColor,
                              gradient: initialIndex == i ? AppGradient.buttonGradient : null,
                              borderRadius: AppBorderRadius.borderAll4,
                            ),
                            child: Text(
                              coefficients.elementAt(i).toString(),
                              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 11,
                                    color: initialIndex == i ? AppColors.white : AppColors.white.withOpacity(0.4),
                                  ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          AppSpacing.verticalSpace6,
                          Text(
                            'L${i + 1}',
                            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 11,
                                  color: initialIndex == i ? AppColors.white : AppColors.white.withOpacity(0.4),
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }

  int maxCoefficient() {
    int max = 0;
    for (final coeff in coefficients) {
      if (coeff > max) max = coeff;
    }
    return max;
  }
}
