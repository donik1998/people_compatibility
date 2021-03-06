import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:people_compatibility/presentation/theme/app_border_radius.dart';
import 'package:people_compatibility/presentation/theme/app_colors.dart';
import 'package:people_compatibility/presentation/utils/enums.dart';

class ComparisonGenderSwitcher extends StatelessWidget {
  final ValueChanged<GenderSwitcherState> onSwitched;
  final GenderSwitcherState initialState;

  const ComparisonGenderSwitcher({
    Key? key,
    required this.onSwitched,
    required this.initialState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: AppColors.grey.withOpacity(0.1),
        borderRadius: AppBorderRadius.max,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (initialState == GenderSwitcherState.female) {
                  onSwitched(GenderSwitcherState.male);
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
                decoration: BoxDecoration(
                  color: initialState == GenderSwitcherState.male ? AppColors.darkPurple : Colors.transparent,
                  borderRadius: AppBorderRadius.max,
                ),
                child: Center(
                  child: Text(
                    'male'.tr(),
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 16),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (initialState == GenderSwitcherState.male) {
                  onSwitched(GenderSwitcherState.female);
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
                decoration: BoxDecoration(
                  color: initialState == GenderSwitcherState.female ? AppColors.purple : Colors.transparent,
                  borderRadius: AppBorderRadius.max,
                ),
                child: Center(
                  child: Text(
                    'female'.tr(),
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 16),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
