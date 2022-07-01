import 'package:flutter/material.dart';
import 'package:people_compatibility/presentation/theme/app_border_radius.dart';
import 'package:people_compatibility/presentation/theme/app_colors.dart';
import 'package:people_compatibility/presentation/theme/app_spacing.dart';

class ExpandableDescriptionItem extends StatefulWidget {
  final String title;
  final String description;
  final String descriptionTitle;
  final bool initiallyExpanded;

  const ExpandableDescriptionItem({
    Key? key,
    required this.title,
    required this.description,
    required this.descriptionTitle,
    required this.initiallyExpanded,
  }) : super(key: key);

  @override
  State<ExpandableDescriptionItem> createState() => _ExpandableDescriptionItemState();
}

class _ExpandableDescriptionItemState extends State<ExpandableDescriptionItem> {
  late bool _expanded = widget.initiallyExpanded;

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
            onTap: () => setState(() => _expanded = !_expanded),
            borderRadius: AppBorderRadius.borderAll12,
            child: Ink(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 13),
              decoration: BoxDecoration(
                color: _expanded ? null : AppColors.white.withOpacity(0.1),
                borderRadius: AppBorderRadius.borderAll12,
                gradient: _expanded
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
                    widget.title,
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const Spacer(),
                  if (_expanded)
                    const Icon(
                      Icons.keyboard_arrow_up,
                      color: AppColors.white,
                    ),
                  if (!_expanded)
                    const Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.white,
                    ),
                ],
              ),
            ),
          ),
        ),
        if (_expanded) ...[
          AppSpacing.verticalSpace24,
          Text(
            widget.descriptionTitle,
            style: Theme.of(context).textTheme.headline6?.copyWith(fontSize: 18),
          ),
          AppSpacing.verticalSpace16,
          Text(
            widget.description,
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
