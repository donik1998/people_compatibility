import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:people_compatibility/core/models/birthday_data.dart';
import 'package:people_compatibility/core/routes/app_routes.dart';
import 'package:people_compatibility/presentation/custom_widgets/app_body_back.dart';
import 'package:people_compatibility/presentation/custom_widgets/calendar_dialog.dart';
import 'package:people_compatibility/presentation/custom_widgets/comparison_data_switcher.dart';
import 'package:people_compatibility/presentation/custom_widgets/content_card.dart';
import 'package:people_compatibility/presentation/custom_widgets/custom_back_button.dart';
import 'package:people_compatibility/presentation/custom_widgets/custom_button.dart';
import 'package:people_compatibility/presentation/custom_widgets/custom_text_field.dart';
import 'package:people_compatibility/presentation/pages/add_comparison_data_page/state/second_gender_comparison_data_state.dart';
import 'package:people_compatibility/presentation/theme/app_colors.dart';
import 'package:people_compatibility/presentation/theme/app_insets.dart';
import 'package:people_compatibility/presentation/theme/app_spacing.dart';
import 'package:people_compatibility/presentation/utils/enums.dart';
import 'package:provider/provider.dart';

class SecondComparisonDataPage extends StatelessWidget {
  const SecondComparisonDataPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Center(
          child: CustomBackButton(
            onTap: () => Navigator.pop(
              context,
              context.read<SecondPartnerDataState>().partnerData,
            ),
          ),
        ),
        title: Text('your_data'.tr()),
      ),
      body: Consumer<SecondPartnerDataState>(
        builder: (context, state, child) => AppBodyBackground(
          child: SingleChildScrollView(
            controller: state.scrollController,
            padding: AppInsets.horizontal24,
            child: Column(
              children: [
                AppSpacing.verticalSpace20,
                AppSpacing.verticalSpace20,
                TappableColoredCardWrap(
                  padding: AppInsets.paddingAll16,
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AppSpacing.verticalSpace16,
                      ComparisonGenderSwitcher(
                        initialState: state.genderSwitcherState,
                        onSwitched: (switcherState) => state.setGenderSwitcherState(switcherState),
                      ),
                      AppSpacing.verticalSpace16,
                      Text(
                        'date_and_time_of_birth'.tr(),
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 16),
                      ),
                      AppSpacing.verticalSpace16,
                      TappableColoredCardWrap(
                        padding: AppInsets.horizontal18,
                        content: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              state.selectedPersonBirthday,
                              style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 16),
                            ),
                            IconButton(
                              icon: SvgPicture.asset('assets/images/svg/calendar.svg'),
                              onPressed: () => showDialog<BirthdayData>(
                                context: context,
                                builder: (context) => CalendarDialog(
                                  initialDate: state.partnerData.dateOfBirth,
                                  exactTimeKnownInitially: state.partnerData.exactTimeUnknown,
                                ),
                              ).then((birthdayData) async {
                                if (birthdayData != null) state.updateBirthday(birthdayData);
                              }),
                            ),
                          ],
                        ),
                        color: AppColors.white.withOpacity(0.1),
                      ),
                      AppSpacing.verticalSpace24,
                      Text(
                        'place_of_birth'.tr(),
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 16),
                      ),
                      AppSpacing.verticalSpace16,
                      CustomTextField(
                        onChanged: (value) => state.onSearchRequested(
                          input: value,
                          type: 'country',
                          lang: context.locale.languageCode,
                          offset: context.findRenderObject()?.paintBounds.center.dy ?? 0,
                        ),
                        controller: state.countryController,
                        hint: 'choose_country'.tr(),
                      ),
                      if (state.inProgress && state.searchMode == PlaceSearchMode.country) AppSpacing.verticalSpace16,
                      if (state.inProgress && state.searchMode == PlaceSearchMode.country)
                        TappableColoredCardWrap(
                          color: AppColors.white.withOpacity(0.1),
                          content: const Center(child: CircularProgressIndicator()),
                        ),
                      if (state.searchError && state.searchMode == PlaceSearchMode.country) AppSpacing.verticalSpace16,
                      if (state.searchError && state.searchMode == PlaceSearchMode.country)
                        TappableColoredCardWrap(
                          color: AppColors.white.withOpacity(0.1),
                          content: Center(child: Text('request_error'.tr())),
                        ),
                      if (state.canShowCountryResults) AppSpacing.verticalSpace16,
                      if (state.canShowCountryResults)
                        TappableColoredCardWrap(
                          content: state.searchResponse!.predictedCountries.isEmpty
                              ? Center(
                                  child: Text(
                                    'nothing_found'.tr(),
                                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.white.withOpacity(0.5),
                                        ),
                                  ),
                                )
                              : ListView.separated(
                                  shrinkWrap: true,
                                  itemCount: state.searchResponse!.predictedCountries.length,
                                  separatorBuilder: (context, index) => AppSpacing.verticalSpace12,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        state.setCountry(
                                          state.searchResponse!.predictedCountries.elementAt(index).structuredFormatting?.mainText ??
                                              'null',
                                          placeId: state.searchResponse?.predictedCountries.elementAt(index).placeId,
                                          lang: context.locale.languageCode,
                                        );
                                        FocusScope.of(context).unfocus();
                                      },
                                      child: Text(
                                        state.searchResponse!.predictedCountries.elementAt(index).structuredFormatting?.mainText ??
                                            'null',
                                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.white.withOpacity(0.5),
                                            ),
                                      ),
                                    );
                                  },
                                ),
                          color: AppColors.white.withOpacity(0.1),
                        ),
                      AppSpacing.verticalSpace16,
                      if (state.canSearchForCity)
                        CustomTextField(
                          onChanged: (value) => state.onSearchRequested(
                            lang: context.locale.languageCode,
                            input: value,
                            type: 'cities',
                            offset: context.findRenderObject()?.paintBounds.center.dy ?? 0,
                          ),
                          controller: state.cityController,
                          hint: 'choose_city'.tr(),
                        ),
                      if (state.inProgress && state.searchMode == PlaceSearchMode.city) AppSpacing.verticalSpace16,
                      if (state.inProgress && state.searchMode == PlaceSearchMode.city)
                        TappableColoredCardWrap(
                          color: AppColors.white.withOpacity(0.1),
                          content: const Center(child: CircularProgressIndicator()),
                        ),
                      if (state.searchError && state.searchMode == PlaceSearchMode.city) AppSpacing.verticalSpace16,
                      if (state.searchError && state.searchMode == PlaceSearchMode.city)
                        TappableColoredCardWrap(
                          color: AppColors.white.withOpacity(0.1),
                          content: Center(child: Text('request_error'.tr())),
                        ),
                      if (state.canShowCityResults) AppSpacing.verticalSpace16,
                      if (state.canShowCityResults)
                        TappableColoredCardWrap(
                          content: state.filteredCities.isEmpty
                              ? Center(
                                  child: Text(
                                    'nothing_found'.tr(),
                                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.white.withOpacity(0.5),
                                        ),
                                  ),
                                )
                              : ListView.separated(
                                  shrinkWrap: true,
                                  itemCount: state.filteredCities.length,
                                  separatorBuilder: (context, index) => AppSpacing.verticalSpace12,
                                  itemBuilder: (context, index) => GestureDetector(
                                    onTap: () {
                                      state.setCity(
                                        placeId: state.filteredCities.elementAt(index).placeId ?? '',
                                        cityTitle: state.filteredCities.elementAt(index).structuredFormatting?.mainText ?? '',
                                      );
                                      FocusScope.of(context).unfocus();
                                    },
                                    child: Text(
                                      state.filteredCities
                                              .elementAt(index)
                                              .description
                                              ?.substring(0, state.filteredCities.elementAt(index).description?.lastIndexOf(',')) ??
                                          'null',
                                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.white.withOpacity(0.5),
                                          ),
                                    ),
                                  ),
                                ),
                          color: AppColors.white.withOpacity(0.1),
                        ),
                      AppSpacing.verticalSpace24,
                      Text(
                        'your_name'.tr(),
                        style: Theme.of(context).textTheme.headline5?.copyWith(fontSize: 18),
                      ),
                      AppSpacing.verticalSpace16,
                      CustomTextField(
                        onChanged: (value) => state.changePartnerName(value),
                        controller: state.nameController,
                        hint: 'enter_name'.tr(),
                      ),
                      AppSpacing.verticalSpace16,
                      // AppSpacing.verticalSpace20,
                      // TextButton(
                      //   onPressed: () => state.resetData(),
                      //   child: Text(
                      //     'reset'.tr(),
                      //     style: Theme.of(context).textTheme.headline6?.copyWith(
                      //           fontWeight: FontWeight.normal,
                      //           color: AppColors.white.withOpacity(0.7),
                      //         ),
                      //   ),
                      // ),
                      if (!state.partnerDataIsValid) ...[
                        AppSpacing.verticalSpace16,
                        Text(
                          state.partnerValidationErrorMessage,
                          style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 16, color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ],
                  ),
                  color: AppColors.deepBlue,
                ),
              ],
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: Consumer<SecondPartnerDataState>(
        builder: (context, state, child) {
          return SafeArea(
            minimum: AppInsets.bottomButton,
            child: CustomButton.text(
              onTap: () {
                state.validatePartnerData();
                if (state.partnerDataIsValid) {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.calculateCompatibility,
                    arguments: CalculateCompatibilityPageArguments(
                      maleData: state.firstPartnerData,
                      femaleData: state.partnerData,
                    ),
                  );
                }
              },
              text: 'calculate'.tr(),
            ),
          );
        },
      ),
    );
  }
}
