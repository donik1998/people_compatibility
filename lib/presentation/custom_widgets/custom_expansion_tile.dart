import 'package:flutter/material.dart';
import 'package:people_compatibility/presentation/theme/app_border_radius.dart';
import 'package:people_compatibility/presentation/theme/app_colors.dart';
import 'package:people_compatibility/presentation/theme/app_spacing.dart';

class ExpandableDescriptionItem extends StatelessWidget {
  final String title;
  final String description;
  final String descriptionTitle;
  final bool expanded;
  final VoidCallback onExpansionChanged;

  const ExpandableDescriptionItem({
    Key? key,
    required this.title,
    required this.description,
    required this.onExpansionChanged,
    required this.descriptionTitle,
    required this.expanded,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Material(
          elevation: 0,
          borderRadius: AppBorderRadius.borderAll12,
          color: AppColors.white.withOpacity(0.1),
          child: InkWell(
            onTap: onExpansionChanged,
            borderRadius: AppBorderRadius.borderAll12,
            child: Ink(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 13),
              decoration: BoxDecoration(
                color: expanded ? null : AppColors.white.withOpacity(0.1),
                borderRadius: AppBorderRadius.borderAll12,
                gradient: expanded
                    ? const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          AppColors.darkBlue,
                          AppColors.purple,
                        ],
                      )
                    : null,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const Spacer(),
                  if (expanded)
                    const Icon(
                      Icons.keyboard_arrow_up,
                      color: AppColors.white,
                    ),
                  if (!expanded)
                    const Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.white,
                    ),
                ],
              ),
            ),
          ),
        ),
        if (expanded) ...[
          AppSpacing.verticalSpace24,
          Text(
            descriptionTitle,
            style: Theme.of(context).textTheme.headline6?.copyWith(fontSize: 18),
          ),
          AppSpacing.verticalSpace16,
          Text(
            description,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  fontSize: 16,
                  color: AppColors.white.withOpacity(0.5),
                ),
          ),
        ],
      ],
    );
  }
}
