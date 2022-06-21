import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:people_compatibility/core/models/birthday_data.dart';
import 'package:people_compatibility/presentation/custom_widgets/content_card.dart';
import 'package:people_compatibility/presentation/custom_widgets/custom_button.dart';
import 'package:people_compatibility/presentation/theme/app_border_radius.dart';
import 'package:people_compatibility/presentation/theme/app_colors.dart';
import 'package:people_compatibility/presentation/theme/app_insets.dart';
import 'package:people_compatibility/presentation/theme/app_spacing.dart';
import 'package:people_compatibility/presentation/utils/extensions.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarDialog extends StatefulWidget {
  const CalendarDialog({Key? key}) : super(key: key);

  @override
  State<CalendarDialog> createState() => _CalendarDialogState();
}

class _CalendarDialogState extends State<CalendarDialog> {
  bool exactTimeKnown = false;
  DateTime _selectedDate = DateTime.now();
  CalendarDialogMode _dialogMode = CalendarDialogMode.month;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: AppInsets.paddingAll16,
      shape: const RoundedRectangleBorder(
        borderRadius: AppBorderRadius.borderAll30,
      ),
      backgroundColor: AppColors.deepBlue,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedCrossFade(
              crossFadeState: _dialogMode == CalendarDialogMode.month ? CrossFadeState.showFirst : CrossFadeState.showSecond,
              firstChild: TableCalendar(
                locale: Localizations.localeOf(context).languageCode,
                calendarStyle: CalendarStyle(
                  todayDecoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        AppColors.darkBlue,
                        AppColors.purple,
                      ],
                    ),
                  ),
                  weekendTextStyle: Theme.of(context).textTheme.bodyText1!.copyWith(color: AppColors.grey),
                  disabledTextStyle: Theme.of(context).textTheme.bodyText1!.copyWith(color: AppColors.grey.withOpacity(0.1)),
                ),
                onHeaderTapped: (focusedDate) => setState(() => _dialogMode = CalendarDialogMode.year),
                currentDay: _selectedDate,
                focusedDay: _selectedDate,
                onDaySelected: (selectedDate, focusedDate) => setState(() => _selectedDate = selectedDate),
                firstDay: DateTime.now().subtract(const Duration(days: 36500)),
                lastDay: DateTime.now(),
                headerVisible: true,
                startingDayOfWeek: StartingDayOfWeek.monday,
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: Theme.of(context).textTheme.bodyText1!.copyWith(color: AppColors.grey),
                  weekendStyle: Theme.of(context).textTheme.bodyText1!.copyWith(color: AppColors.grey),
                ),
                headerStyle: HeaderStyle(
                  titleCentered: true,
                  formatButtonVisible: false,
                  formatButtonShowsNext: false,
                  titleTextStyle: Theme.of(context).textTheme.headline6!.copyWith(
                        fontSize: 18,
                        color: AppColors.dirtyWhite,
                        fontWeight: FontWeight.w400,
                      ),
                  headerMargin: const EdgeInsets.only(bottom: 36),
                  leftChevronIcon: const Icon(Icons.chevron_left, color: AppColors.dirtyWhite, size: 24),
                  rightChevronIcon: const Icon(Icons.chevron_right, color: AppColors.dirtyWhite, size: 24),
                ),
              ),
              secondChild: SizedBox(
                height: 276,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: (MediaQuery.of(context).size.width / 3) / 64,
                  ),
                  itemCount: 100,
                  itemBuilder: (context, index) => TappableColoredCardWrap(
                    content: Center(child: Text('${_selectedDate.year - index}')),
                    color: AppColors.deepPurple,
                    onTap: () => setState(() {
                      _dialogMode = CalendarDialogMode.month;
                      _selectedDate = DateTime(_selectedDate.year - index);
                    }),
                  ),
                ),
              ),
              duration: const Duration(milliseconds: 250),
            ),
            if (!exactTimeKnown) AppSpacing.verticalSpace16,
            if (!exactTimeKnown)
              CustomButton.text(
                text: 'Выбрать время',
                onTap: () => DatePicker.showTimePicker(
                  context,
                  locale: LocaleType.ru,
                  currentTime: _selectedDate,
                  theme: DatePickerTheme(
                    backgroundColor: AppColors.deepBlue,
                    headerColor: AppColors.deepPurple,
                    itemStyle: Theme.of(context).textTheme.bodyText1!,
                    cancelStyle: Theme.of(context).textTheme.headline6!,
                    doneStyle: Theme.of(context).textTheme.headline6!,
                  ),
                  showSecondsColumn: false,
                  onConfirm: (newTime) {
                    setState(() {
                      _selectedDate = _selectedDate.copyWith(hour: newTime.hour, minute: newTime.minute);
                    });
                  },
                ),
              ),
            AppSpacing.verticalSpace16,
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Checkbox(
                  value: exactTimeKnown,
                  onChanged: (value) => setState(() => exactTimeKnown = value ?? exactTimeKnown),
                  shape: const RoundedRectangleBorder(borderRadius: AppBorderRadius.borderAll6),
                  activeColor: AppColors.white.withOpacity(0.5),
                  checkColor: AppColors.deepBlue,
                  side: BorderSide(color: AppColors.white.withOpacity(0.5), width: 2),
                ),
                AppSpacing.horizontalSpace8,
                GestureDetector(
                  onTap: () => setState(() => exactTimeKnown = !exactTimeKnown),
                  child: Text(
                    'Неизвестно время рождения',
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: AppColors.white.withOpacity(0.6),
                        ),
                  ),
                ),
              ],
            ),
            AppSpacing.verticalSpace12,
            TappableColoredCardWrap(
              content: Text(
                DateFormat('dd.MM.yyyy, HH:mm').format(_selectedDate),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1?.copyWith(color: AppColors.dirtyWhite),
              ),
              color: AppColors.deepPurple,
            ),
            AppSpacing.verticalSpace12,
            SizedBox(
              height: 25,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: TappableColoredCardWrap(
                      onTap: () => Navigator.pop(context),
                      padding: EdgeInsets.zero,
                      content: Center(
                        child: Text(
                          'Удалить',
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(color: AppColors.textGray),
                        ),
                      ),
                      color: AppColors.deepPurple,
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  AppSpacing.horizontalSpace16,
                  Expanded(
                    child: TappableColoredCardWrap(
                      borderRadius: BorderRadius.zero,
                      onTap: () => Navigator.pop(
                        context,
                        BirthdayData(
                          date: _selectedDate,
                          exactTimeKnown: exactTimeKnown,
                        ),
                      ),
                      gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          AppColors.darkBlue,
                          AppColors.purple,
                        ],
                      ),
                      padding: EdgeInsets.zero,
                      content: Center(
                        child: Text(
                          'Подтвердить',
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(color: AppColors.textGray),
                        ),
                      ),
                      color: AppColors.deepPurple,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum CalendarDialogMode { month, year }
