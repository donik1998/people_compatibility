import 'dart:math';

import 'package:flutter/material.dart';
import 'package:people_compatibility/presentation/theme/app_border_radius.dart';
import 'package:people_compatibility/presentation/theme/app_colors.dart';
import 'package:people_compatibility/presentation/theme/app_spacing.dart';

class CoefficientChart extends StatefulWidget {
  final List<int> coefficients;
  final ValueChanged<int> onBarSelected;
  final int? initialIndex;

  const CoefficientChart({
    Key? key,
    required this.coefficients,
    required this.onBarSelected,
    this.initialIndex,
  }) : super(key: key);

  @override
  State<CoefficientChart> createState() => _CoefficientChartState();
}

class _CoefficientChartState extends State<CoefficientChart> {
  late int _selectedIndex = widget.initialIndex ?? -1;

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
          if (widget.coefficients.isEmpty)
            Center(
              child: Text(
                'Нет данных',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          if (widget.coefficients.isNotEmpty)
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (int i = 0; i < widget.coefficients.length; i++)
                  GestureDetector(
                    onTap: () {
                      widget.onBarSelected(i);
                      setState(() => _selectedIndex = i);
                    },
                    child: SizedBox(
                      width: 20,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 20,
                            height: max((widget.coefficients.elementAt(i) / maxCoefficient()) * 160, 24),
                            padding: const EdgeInsets.only(top: 6),
                            decoration: BoxDecoration(
                              color: _selectedIndex == i ? null : AppColors.chartBarColor,
                              gradient: _selectedIndex == i
                                  ? const LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        AppColors.darkBlue,
                                        AppColors.purple,
                                      ],
                                    )
                                  : null,
                              borderRadius: AppBorderRadius.borderAll4,
                            ),
                            child: Text(
                              widget.coefficients.elementAt(i).toString(),
                              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 11,
                                    color: _selectedIndex == i ? AppColors.white : AppColors.white.withOpacity(0.4),
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
                                  color: _selectedIndex == i ? AppColors.white : AppColors.white.withOpacity(0.4),
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
    for (final coeff in widget.coefficients) {
      if (coeff > max) max = coeff;
    }
    return max;
  }
}
