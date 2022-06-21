import 'dart:math';

import 'package:flutter/material.dart';
import 'package:people_compatibility/core/models/comparison.dart';
import 'package:people_compatibility/core/routes/app_routes.dart';
import 'package:people_compatibility/presentation/custom_widgets/app_body_back.dart';
import 'package:people_compatibility/presentation/custom_widgets/comparison_card.dart';
import 'package:people_compatibility/presentation/custom_widgets/content_card.dart';
import 'package:people_compatibility/presentation/custom_widgets/custom_button.dart';
import 'package:people_compatibility/presentation/pages/calculate_compatibility_page/calculate_compatibility_page.dart';
import 'package:people_compatibility/presentation/pages/main_page/state/main_page_state.dart';
import 'package:people_compatibility/presentation/theme/app_colors.dart';
import 'package:people_compatibility/presentation/theme/app_insets.dart';
import 'package:people_compatibility/presentation/theme/app_spacing.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<MainPageState>(
        builder: (context, state, child) => AppBodyBackground(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (!state.fullSizedMode) AppSpacing.verticalSpace24,
              if (!state.fullSizedMode) AppSpacing.verticalSpace24,
              if (!state.fullSizedMode) AppSpacing.verticalSpace24,
              if (!state.fullSizedMode)
                TappableColoredCardWrap(
                  color: AppColors.white.withOpacity(0.1),
                  content: RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyText1,
                      children: const [
                        TextSpan(text: 'Пройдите тест на совместимость со своим настоящим, прошлым или будущим партнёром.\n'),
                        TextSpan(
                          text:
                              '\nКоэффициент не показывает личностные качества человека, он даёт оценку ваших шансов быть вместе. Программа не учитывает воспитание, окружение, факторы наследственности. И прежде всего, в делах сердечных прислушайтесь к своей интуиции, тогда у вас все получится!',
                        ),
                      ],
                    ),
                  ),
                ),
              AppSpacing.verticalSpace24,
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'История сравнений',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  if (state.fullSizedMode)
                    TextButton(
                      onPressed: () => state.setFullSized(false),
                      child: Text(
                        'Свернуть',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                ],
              ),
              AppSpacing.verticalSpace24,
              if (state.history != null)
                if (state.history!.isNotEmpty)
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        final calculationData = state.history!.elementAt(index);
                        if ((index + 1 == min(2, state.history!.length)) && !state.fullSizedMode) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              TappableColoredCardWrap(
                                color: AppColors.white.withOpacity(0.1),
                                onTap: () => _gotoCalculationsResultPage(context, calculationData),
                                content: ComparisonCard(data: calculationData),
                              ),
                              AppSpacing.verticalSpace16,
                              TappableColoredCardWrap(
                                color: AppColors.white.withOpacity(0.1),
                                onTap: () => state.setFullSized(true),
                                content: Text(
                                  'Нажмите чтобы открыть весь список',
                                  style: Theme.of(context).textTheme.headline6,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          );
                        } else {
                          return TappableColoredCardWrap(
                            color: AppColors.white.withOpacity(0.1),
                            onTap: () => _gotoCalculationsResultPage(context, calculationData),
                            content: ComparisonCard(data: calculationData),
                          );
                        }
                      },
                      separatorBuilder: (context, index) => AppSpacing.verticalSpace16,
                      itemCount: state.fullSizedMode ? state.history!.length : min(2, state.history!.length),
                    ),
                  ),
              if (state.history != null)
                if (state.history!.isEmpty)
                  TappableColoredCardWrap(
                    content: const Center(child: Text('Здесь пока ничего нет')),
                    color: AppColors.white.withOpacity(0.1),
                  ),
              if (state.inProgress)
                TappableColoredCardWrap(
                  content: const Center(child: CircularProgressIndicator()),
                  color: AppColors.white.withOpacity(0.1),
                ),
              AppSpacing.verticalSpace32,
            ],
          ),
        ),
      ),
      bottomSheet: SafeArea(
        minimum: AppInsets.paddingAll16,
        child: CustomButton.text(
          text: 'Рассчитать совместимость',
          onTap: () => Navigator.pushNamed(context, AppRoutes.comparisonData),
        ),
      ),
    );
  }

  void _gotoCalculationsResultPage(BuildContext context, CompatibilityData data) {
    Navigator.pushNamed(
      context,
      AppRoutes.calculateCompatibility,
      arguments: CalculateCompatibilityPageArguments(
        maleData: data.male,
        femaleData: data.female,
        shouldSaveToLocalDb: false,
      ),
    );
  }
}
