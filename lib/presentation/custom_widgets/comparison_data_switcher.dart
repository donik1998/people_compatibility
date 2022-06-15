import 'package:flutter/material.dart';
import 'package:people_compatibility/presentation/theme/app_border_radius.dart';
import 'package:people_compatibility/presentation/theme/app_colors.dart';
import 'package:people_compatibility/presentation/utils/enums.dart';

class ComparisonDataSwitcher extends StatefulWidget {
  final ValueChanged<GenderSwitcherState> onSwitched;

  const ComparisonDataSwitcher({
    Key? key,
    required this.onSwitched,
  }) : super(key: key);

  @override
  State<ComparisonDataSwitcher> createState() => _ComparisonDataSwitcherState();
}

class _ComparisonDataSwitcherState extends State<ComparisonDataSwitcher> {
  GenderSwitcherState switcherState = GenderSwitcherState.male;

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
                setState(() => switcherState = GenderSwitcherState.male);
                widget.onSwitched(switcherState);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
                decoration: BoxDecoration(
                  color: switcherState == GenderSwitcherState.male ? AppColors.darkPurple : Colors.transparent,
                  borderRadius: AppBorderRadius.max,
                ),
                child: const Center(
                  child: Text('Мужчина'),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() => switcherState = GenderSwitcherState.female);
                widget.onSwitched(switcherState);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
                decoration: BoxDecoration(
                  color: switcherState == GenderSwitcherState.female ? AppColors.purple : Colors.transparent,
                  borderRadius: AppBorderRadius.max,
                ),
                child: const Center(
                  child: Text('Женщина'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
