import 'package:flutter/material.dart';
import 'package:people_compatibility/core/models/birthday_data.dart';
import 'package:people_compatibility/core/routes/app_routes.dart';
import 'package:people_compatibility/presentation/custom_widgets/app_body_back.dart';
import 'package:people_compatibility/presentation/custom_widgets/calendar_dialog.dart';
import 'package:people_compatibility/presentation/custom_widgets/comparison_data_switcher.dart';
import 'package:people_compatibility/presentation/custom_widgets/content_card.dart';
import 'package:people_compatibility/presentation/custom_widgets/custom_back_button.dart';
import 'package:people_compatibility/presentation/custom_widgets/custom_button.dart';
import 'package:people_compatibility/presentation/custom_widgets/custom_text_field.dart';
import 'package:people_compatibility/presentation/pages/add_comparison_data_page/state/comparison_data_page_state.dart';
import 'package:people_compatibility/presentation/pages/calculate_compatibility_page/calculate_compatibility_page.dart';
import 'package:people_compatibility/presentation/theme/app_colors.dart';
import 'package:people_compatibility/presentation/theme/app_insets.dart';
import 'package:people_compatibility/presentation/theme/app_spacing.dart';
import 'package:people_compatibility/presentation/utils/enums.dart';
import 'package:provider/provider.dart';

class ComparisonDataPage extends StatelessWidget {
  const ComparisonDataPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Center(child: CustomBackButton()),
        title: const Text('Ваши данные'),
      ),
      body: Consumer<ComparisonDataPageState>(
        builder: (context, state, child) => AppBodyBackground(
          child: SingleChildScrollView(
            controller: state.scrollController,
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
                      ComparisonDataSwitcher(
                        initialState: state.genderSwitcherState,
                        onSwitched: (switcherState) => state.setGenderSwitcherState(switcherState),
                      ),
                      AppSpacing.verticalSpace16,
                      Text(
                        'Дата и время рождения',
                        style: Theme.of(context).textTheme.headline6,
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
                              style: Theme.of(context).textTheme.headline6?.copyWith(fontWeight: FontWeight.w400),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.calendar_month,
                                color: AppColors.white,
                              ),
                              onPressed: () => showDialog<BirthdayData>(
                                context: context,
                                builder: (context) => CalendarDialog(
                                  initialDate: state.selectedPersonDateOfBirth,
                                  exactTimeKnownInitially: state.selectedPersonExactTimeKnown,
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
                        'Место рождения',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      AppSpacing.verticalSpace16,
                      CustomTextField(
                        onChanged: (value) => state.onSearchRequested(
                          input: value,
                          type: 'country',
                          offset: context.findRenderObject()?.paintBounds.center.dy ?? 0,
                        ),
                        controller: state.countryController,
                        hint: 'Введите страну',
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
                          content: Center(child: Text(state.errorMessage)),
                        ),
                      if (state.canShowCountryResults) AppSpacing.verticalSpace16,
                      if (state.canShowCountryResults)
                        TappableColoredCardWrap(
                          content: state.searchResponse!.predictedCountries.isEmpty
                              ? const Center(child: Text('Ничего не найдено'))
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
                                        );
                                        FocusScope.of(context).unfocus();
                                      },
                                      child: Text(
                                        state.searchResponse!.predictedCountries.elementAt(index).structuredFormatting?.mainText ??
                                            'null',
                                        style:
                                            Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 15, fontWeight: FontWeight.w400),
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
                            input: value,
                            type: 'cities',
                            offset: context.findRenderObject()?.paintBounds.center.dy ?? 0,
                          ),
                          controller: state.cityController,
                          hint: 'Введите город',
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
                          content: Center(child: Text(state.errorMessage)),
                        ),
                      if (state.canShowCityResults) AppSpacing.verticalSpace16,
                      if (state.canShowCityResults)
                        TappableColoredCardWrap(
                          content: state.filteredCities.isEmpty
                              ? const Center(child: Text('Ничего не найдено'))
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
                                      state.filteredCities.elementAt(index).structuredFormatting?.mainText ?? 'null',
                                      style:
                                          Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 15, fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ),
                          color: AppColors.white.withOpacity(0.1),
                        ),
                      AppSpacing.verticalSpace24,
                      Text(
                        'Ваше имя',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      AppSpacing.verticalSpace16,
                      CustomTextField(
                        onChanged: (value) => state.changePartnerName(value),
                        controller: state.nameController,
                        hint: 'Введите имя',
                      ),
                      AppSpacing.verticalSpace20,
                      TextButton(
                        onPressed: () => state.resetData(),
                        child: Text(
                          'Сбросить',
                          style: Theme.of(context).textTheme.headline6?.copyWith(
                                fontWeight: FontWeight.normal,
                                color: AppColors.white.withOpacity(0.7),
                              ),
                        ),
                      ),
                      if (state.hasValidationError) AppSpacing.verticalSpace16,
                      if (state.hasValidationError)
                        Text(
                          state.validationErrorMessage,
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                    ],
                  ),
                  color: AppColors.deepBlue,
                ),
                if (state.hasKeyboard) ...[
                  SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
                ],
                AppSpacing.verticalSpace32,
                AppSpacing.verticalSpace32,
              ],
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: Consumer<ComparisonDataPageState>(
        builder: (context, state, child) {
          return SafeArea(
            minimum: AppInsets.paddingAll16,
            child: CustomButton.text(
              onTap: () {
                if (state.genderSwitcherState == GenderSwitcherState.male) {
                  state.validateMaleData();
                  state.setGenderSwitcherState(GenderSwitcherState.female);
                } else {
                  state.validateMaleData();
                  state.validateFemaleData();
                }
                if (state.maleDataIsValid && state.femaleDataIsValid) {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.calculateCompatibility,
                    arguments: CalculateCompatibilityPageArguments(
                      maleData: context.read<ComparisonDataPageState>().male,
                      femaleData: context.read<ComparisonDataPageState>().female,
                    ),
                  );
                }
              },
              text: state.genderSwitcherState == GenderSwitcherState.male ? 'Далее' : 'Рассчитать',
            ),
          );
        },
      ),
    );
  }
}
