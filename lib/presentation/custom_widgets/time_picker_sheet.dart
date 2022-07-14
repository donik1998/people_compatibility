import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:people_compatibility/presentation/theme/app_colors.dart';
import 'package:people_compatibility/presentation/utils/extensions.dart';

class TimePickerSheet extends StatefulWidget {
  final int hour;
  final int minute;

  const TimePickerSheet({
    Key? key,
    required this.hour,
    required this.minute,
  }) : super(key: key);

  @override
  State<TimePickerSheet> createState() => _TimePickerSheetState();
}

class _TimePickerSheetState extends State<TimePickerSheet> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        color: AppColors.deepBlue,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 50,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Отмена',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, _selectedDate),
                  child: Text(
                    'Готово',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 200,
            color: AppColors.deepBlue,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: CupertinoPicker.builder(
                    scrollController: FixedExtentScrollController(initialItem: widget.hour),
                    itemExtent: 48,
                    useMagnifier: true,
                    onSelectedItemChanged: (index) => setState(() => _selectedDate = _selectedDate.copyWith(hour: index)),
                    itemBuilder: (context, index) {
                      return Text(
                        '$index'.padLeft(2, '0'),
                        style: Theme.of(context).textTheme.headline6,
                      );
                    },
                    childCount: 24,
                  ),
                ),
                Center(
                  child: Text(
                    ':',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                Expanded(
                  child: CupertinoPicker.builder(
                    scrollController: FixedExtentScrollController(initialItem: widget.minute),
                    itemExtent: 48,
                    useMagnifier: true,
                    onSelectedItemChanged: (index) => setState(() => _selectedDate = _selectedDate.copyWith(minute: index)),
                    itemBuilder: (context, index) {
                      return Text(
                        '$index'.padLeft(2, '0'),
                        style: Theme.of(context).textTheme.headline6,
                      );
                    },
                    childCount: 60,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
