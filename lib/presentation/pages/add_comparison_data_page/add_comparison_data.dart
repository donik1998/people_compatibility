import 'package:flutter/material.dart';
import 'package:people_compatibility/presentation/custom_widgets/app_body_back.dart';
import 'package:people_compatibility/presentation/custom_widgets/comparison_data_switcher.dart';
import 'package:people_compatibility/presentation/custom_widgets/content_card.dart';
import 'package:people_compatibility/presentation/custom_widgets/custom_back_button.dart';
import 'package:people_compatibility/presentation/custom_widgets/custom_button.dart';
import 'package:people_compatibility/presentation/custom_widgets/custom_text_field.dart';
import 'package:people_compatibility/presentation/pages/add_comparison_data_page/state/comparison_data_page_state.dart';
import 'package:people_compatibility/presentation/theme/app_border_radius.dart';
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
          child: ListView(
            children: [
              AppSpacing.verticalSpace20,
              AppSpacing.verticalSpace20,
              TappableColoredCardWrap(
                padding: AppInsets.paddingAll16,
                content: ClipRRect(
                  borderRadius: AppBorderRadius.borderAll16,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AppSpacing.verticalSpace16,
                      ComparisonDataSwitcher(
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
                              style: Theme.of(context).textTheme.headline6?.copyWith(
                                    fontWeight: FontWeight.w400,
                                  ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.calendar_month,
                                color: AppColors.white,
                              ),
                              onPressed: () => showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now().subtract(const Duration(days: 3650)),
                                lastDate: DateTime.now().add(const Duration(days: 3650)),
                              ).then((value) {
                                if (value != null) state.updateDate(value);
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
                        onChanged: (value) => state.onSearchRequested(value, 'country'),
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
                          onChanged: (value) => state.onSearchRequested(value, 'cities'),
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
                          content: state.searchResponse!.predictedCities.isEmpty
                              ? const Center(child: Text('Ничего не найдено'))
                              : ListView.separated(
                                  shrinkWrap: true,
                                  itemCount: state.searchResponse!.predictedCities.length,
                                  separatorBuilder: (context, index) => AppSpacing.verticalSpace12,
                                  itemBuilder: (context, index) => GestureDetector(
                                    onTap: () {
                                      state.setCity(
                                        state.searchResponse!.predictedCities.elementAt(index).structuredFormatting?.mainText ??
                                            'null',
                                      );
                                      FocusScope.of(context).unfocus();
                                    },
                                    child: Text(
                                      state.searchResponse!.predictedCities.elementAt(index).structuredFormatting?.mainText ?? 'null',
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
                        onChanged: (value) {},
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
                    ],
                  ),
                ),
                color: AppColors.deepBlue,
              ),
            ],
          ),
        ),
      ),
      bottomSheet: SafeArea(
        minimum: AppInsets.paddingAll16,
        child: CustomButton(
          onTap: () {},
          text: 'Далее',
        ),
      ),
    );
  }
}
