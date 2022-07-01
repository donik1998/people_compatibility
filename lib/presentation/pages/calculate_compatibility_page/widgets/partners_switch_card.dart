import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:people_compatibility/core/models/person_details.dart';
import 'package:people_compatibility/presentation/custom_widgets/content_card.dart';
import 'package:people_compatibility/presentation/pages/calculate_compatibility_page/widgets/partner_switcher_tab.dart';
import 'package:people_compatibility/presentation/theme/app_colors.dart';
import 'package:people_compatibility/presentation/theme/app_insets.dart';
import 'package:people_compatibility/presentation/theme/app_spacing.dart';

class PartnersSwitchCard extends StatefulWidget {
  final PersonDetails male, female;

  const PartnersSwitchCard({
    Key? key,
    required this.male,
    required this.female,
  }) : super(key: key);

  @override
  State<PartnersSwitchCard> createState() => _PartnersSwitchCardState();
}

class _PartnersSwitchCardState extends State<PartnersSwitchCard> {
  late PersonDetails _selectedDetails = widget.male;
  bool canShow = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            PartnerSwitcherTab(
              onTap: () => setState(() {
                _selectedDetails = widget.male;
                canShow = true;
              }),
              enabled: _selectedDetails == widget.male,
              color: AppColors.nightBlue,
              name: widget.male.name,
              zodiacIcon: SvgPicture.asset(
                'assets/images/svg/zodiac_${widget.male.zodiac().pathName}.svg',
                color: _selectedDetails == widget.male ? AppColors.white : AppColors.white.withOpacity(0.5),
              ),
              zodiacName: widget.male.zodiac().title,
            ),
            PartnerSwitcherTab(
              onTap: () => setState(() {
                _selectedDetails = widget.female;
                canShow = true;
              }),
              enabled: _selectedDetails == widget.female,
              color: AppColors.nightPurple,
              name: widget.female.name,
              zodiacIcon: SvgPicture.asset(
                'assets/images/svg/zodiac_${widget.female.zodiac().pathName}.svg',
                color: _selectedDetails == widget.female ? AppColors.white : AppColors.white.withOpacity(0.5),
              ),
              zodiacName: widget.female.zodiac().title,
            ),
          ],
        ),
        if (canShow)
          TappableColoredCardWrap(
            padding: AppInsets.horizontal18,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                AppSpacing.verticalSpace24,
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Дата рождения: ',
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                              color: AppColors.white.withOpacity(0.5),
                              fontSize: 16,
                            ),
                      ),
                      TextSpan(
                        text: DateFormat('dd.MM.yyyy').format(_selectedDetails.dateOfBirth),
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                              fontSize: 16,
                            ),
                      ),
                      TextSpan(
                        text: ' (${DateTime.now().difference(_selectedDetails.dateOfBirth).inDays ~/ 365})',
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                              fontSize: 16,
                            ),
                      ),
                    ],
                  ),
                ),
                AppSpacing.verticalSpace8,
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Время рождения: ',
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(color: AppColors.white.withOpacity(0.5), fontSize: 16),
                      ),
                      TextSpan(
                        text: _selectedDetails.exactTimeUnknown
                            ? 'unknown'.tr()
                            : DateFormat('HH:mm').format(_selectedDetails.dateOfBirth),
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                              fontSize: 16,
                            ),
                      ),
                    ],
                  ),
                ),
                AppSpacing.verticalSpace8,
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${'place_of_birth'.tr()}: ',
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                              color: AppColors.white.withOpacity(0.5),
                              fontSize: 16,
                            ),
                      ),
                      TextSpan(
                        text: '${_selectedDetails.country}, ${_selectedDetails.city.title}',
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                              fontSize: 16,
                            ),
                      ),
                    ],
                  ),
                ),
                AppSpacing.verticalSpace24,
              ],
            ),
            color: _selectedDetails == widget.male ? AppColors.nightBlue : AppColors.nightPurple,
          ),
      ],
    );
  }
}
