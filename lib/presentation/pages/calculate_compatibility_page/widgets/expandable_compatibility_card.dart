import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:people_compatibility/presentation/custom_widgets/content_card.dart';
import 'package:people_compatibility/presentation/pages/calculate_compatibility_page/widgets/responsive_text.dart';
import 'package:people_compatibility/presentation/theme/app_colors.dart';
import 'package:people_compatibility/presentation/theme/app_gradient.dart';
import 'package:people_compatibility/presentation/theme/app_spacing.dart';

class ExpandableCompatibilityCard extends StatefulWidget {
  final int levelNumber;
  final String title;
  final String description;
  final int score;

  const ExpandableCompatibilityCard({
    Key? key,
    required this.levelNumber,
    required this.score,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  State<ExpandableCompatibilityCard> createState() => _ExpandableCompatibilityCardState();
}

class _ExpandableCompatibilityCardState extends State<ExpandableCompatibilityCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return TappableColoredCardWrap(
      color: AppColors.white.withOpacity(0.1),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 24,
                width: 24,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppGradient.buttonGradient,
                ),
                child: Center(
                  child: Container(
                    height: 22,
                    width: 22,
                    decoration: const BoxDecoration(
                      color: AppColors.deepBlue,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: ResponsiveText(
                        text: 'L${widget.levelNumber}',
                        style: Theme.of(context).textTheme.headline5?.copyWith(fontSize: 12),
                      ),
                    ),
                  ),
                ),
              ),
              AppSpacing.horizontalSpace12,
              Expanded(
                child: Text(
                  widget.title,
                  style: Theme.of(context).textTheme.headline5?.copyWith(fontSize: 14),
                ),
              ),
            ],
          ),
          AppSpacing.verticalSpace12,
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              AppSpacing.horizontalSpace18,
              Container(
                width: 36,
                height: 36,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppGradient.buttonGradient,
                ),
                child: Center(
                  child: Text(
                    '${widget.score}',
                    style: Theme.of(context).textTheme.headline5?.copyWith(fontSize: 15),
                  ),
                ),
              ),
              AppSpacing.horizontalSpace12,
              Expanded(
                child: TappableColoredCardWrap(
                  onTap: () => setState(() => _expanded = !_expanded),
                  color: AppColors.grey.withOpacity(0.1),
                  content: Center(
                    child: Text(
                      'details'.tr(),
                      style: Theme.of(context).textTheme.headline5?.copyWith(fontSize: 14),
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (_expanded) AppSpacing.verticalSpace20,
          if (_expanded)
            Text(
              widget.description,
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    fontSize: 16,
                    color: AppColors.white.withOpacity(0.5),
                  ),
            ),
          if (_expanded) AppSpacing.verticalSpace16,
          if (_expanded)
            Text(
              'index_caution'.tr(),
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    fontSize: 16,
                    color: AppColors.white.withOpacity(0.5),
                  ),
            ),
        ],
      ),
    );
  }
}
