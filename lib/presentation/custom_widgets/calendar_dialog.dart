import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:people_compatibility/core/models/birthday_data.dart';
import 'package:people_compatibility/presentation/custom_widgets/content_card.dart';
import 'package:people_compatibility/presentation/theme/app_border_radius.dart';
import 'package:people_compatibility/presentation/theme/app_colors.dart';
import 'package:people_compatibility/presentation/theme/app_insets.dart';
import 'package:people_compatibility/presentation/theme/app_spacing.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarDialog extends StatefulWidget {
  const CalendarDialog({Key? key}) : super(key: key);

  @override
  State<CalendarDialog> createState() => _CalendarDialogState();
}

class _CalendarDialogState extends State<CalendarDialog> {
  bool exactTimeKnown = false;
  DateTime _selectedDate = DateTime.now();

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
            TableCalendar(
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
                disabledTextStyle: Theme.of(context).textTheme.bodyText1!.copyWith(color: AppColors.dirtyWhite),
              ),
              onHeaderTapped: (focusedDate) {},
              currentDay: _selectedDate,
              focusedDay: _selectedDate,
              onDaySelected: (selectedDate, focusedDate) => setState(() => _selectedDate = selectedDate),
              firstDay: DateTime.now().subtract(const Duration(days: 36500)),
              lastDay: DateTime.now().add(const Duration(days: 36500)),
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
                Text(
                  'Неизвестно время рождения',
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: AppColors.white.withOpacity(0.6),
                      ),
                ),
              ],
            ),
            AppSpacing.verticalSpace12,
            TappableColoredCardWrap(
              content: Text(
                DateFormat('dd.MM.yyyy, HH:MM').format(_selectedDate),
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
