import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:people_compatibility/core/models/compatibility_response.dart';
import 'package:people_compatibility/core/models/person_details.dart';
import 'package:people_compatibility/core/routes/app_routes.dart';
import 'package:people_compatibility/domain/remote/people_compatibility_service.dart';
import 'package:people_compatibility/presentation/custom_widgets/app_body_back.dart';
import 'package:people_compatibility/presentation/custom_widgets/content_card.dart';
import 'package:people_compatibility/presentation/custom_widgets/custom_back_button.dart';
import 'package:people_compatibility/presentation/custom_widgets/custom_button.dart';
import 'package:people_compatibility/presentation/custom_widgets/custom_expansion_tile.dart';
import 'package:people_compatibility/presentation/pages/calculate_compatibility_page/state/calculate_compatibility_page_state.dart';
import 'package:people_compatibility/presentation/pages/calculate_compatibility_page/widgets/circle_coef_bar.dart';
import 'package:people_compatibility/presentation/pages/calculate_compatibility_page/widgets/coefficient_chart.dart';
import 'package:people_compatibility/presentation/pages/calculate_compatibility_page/widgets/expandable_compatibility_card.dart';
import 'package:people_compatibility/presentation/pages/calculate_compatibility_page/widgets/partners_switch_card.dart';
import 'package:people_compatibility/presentation/theme/app_colors.dart';
import 'package:people_compatibility/presentation/theme/app_insets.dart';
import 'package:people_compatibility/presentation/theme/app_spacing.dart';
import 'package:provider/provider.dart';

class CalculateCompatibilityPage extends StatefulWidget {
  const CalculateCompatibilityPage({Key? key}) : super(key: key);

  @override
  State<CalculateCompatibilityPage> createState() => _CalculateCompatibilityPageState();
}

class _CalculateCompatibilityPageState extends State<CalculateCompatibilityPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final args = ModalRoute.of(context)!.settings.arguments as CalculateCompatibilityPageArguments;
      final state = context.read<CalculateCompatibilityPageState>();
      state.setInProgress(true);
      PeopleCompatibilityService.instance.getCompatibility(args.maleData, args.femaleData).then((result) {
        result.fold((l) => state.setError(true), (r) {
          state.setCalculationResponse(
            response: r,
            female: args.femaleData,
            male: args.maleData,
            shouldSaveToDd: args.shouldSaveToLocalDb,
          );
        });
      });
      state.setInProgress(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as CalculateCompatibilityPageArguments;
    return Scaffold(
      body: AppBodyBackground(
        child: Consumer<CalculateCompatibilityPageState>(
          builder: (context, state, child) {
            return CustomScrollView(
              controller: state.scrollController,
              slivers: [
                SliverAppBar(
                  title: Text('result'.tr()),
                  leadingWidth: 64,
                  leading: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppSpacing.horizontalSpace16,
                      AppSpacing.horizontalSpace8,
                      CustomBackButton(
                        onTap: () => Navigator.pushNamedAndRemoveUntil(
                          context,
                          AppRoutes.initial,
                          (route) => false,
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 24),
                        child: CustomButton.child(
                          height: 40,
                          width: 40,
                          onTap: () => _shareLink(
                            response: context.read<CalculateCompatibilityPageState>().calculationResponse,
                            context: context,
                            args: args,
                          ),
                          child: SvgPicture.asset('assets/images/svg/share.svg'),
                        ),
                      ),
                    ),
                  ],
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      if (state.inProgress || state.calculationResponse == null)
                        Container(
                          padding: AppInsets.horizontal24,
                          height: MediaQuery.of(context).size.height * 0.75,
                          width: MediaQuery.of(context).size.width,
                          child: const Center(child: CircularProgressIndicator()),
                        ),
                      if ((state.calculationResponse?.koeff?.isEmpty ?? false) && !state.inProgress)
                        Container(
                          padding: AppInsets.horizontal24,
                          height: MediaQuery.of(context).size.height * 0.75,
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: Text(
                              'request_error'.tr(),
                              style: Theme.of(context).textTheme.headline5,
                            ),
                          ),
                        ),
                      if (state.calculationResponse != null)
                        Padding(
                          padding: AppInsets.horizontal24,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AppSpacing.verticalSpace20,
                              AppSpacing.verticalSpace16,
                              PartnersSwitchCard(
                                male: args.maleData,
                                female: args.femaleData,
                              ),
                              AppSpacing.verticalSpace20,
                              AppSpacing.verticalSpace20,
                              Text(
                                'total_index'.tr(namedArgs: {'value': '${state.calculationResponse?.koeffSum}'}),
                                style: Theme.of(context).textTheme.headline5?.copyWith(
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                              AppSpacing.verticalSpace24,
                              CircleCoefficientBar(
                                coefficient: state.calculationResponse?.koeffSum ?? 0,
                              ),
                              AppSpacing.verticalSpace20,
                              AppSpacing.verticalSpace20,
                              ExpandableDescriptionItem(
                                initiallyExpanded: (state.calculationResponse?.koeffSum ?? 0) > 400,
                                title: 'more_than_400_index_title'.tr(),
                                descriptionTitle: 'more_than_400_index_description_title'.tr(),
                                description: 'more_than_400_index_description_body'.tr(),
                              ),
                              AppSpacing.verticalSpace16,
                              ExpandableDescriptionItem(
                                initiallyExpanded: (state.calculationResponse?.koeffSum ?? 0) >= 300 &&
                                    (state.calculationResponse?.koeffSum ?? 0) < 400,
                                title: 'more_than_300_index_title'.tr(),
                                descriptionTitle: 'more_than_300_index_description_title'.tr(),
                                description: 'more_than_300_index_description_body'.tr(),
                              ),
                              AppSpacing.verticalSpace16,
                              ExpandableDescriptionItem(
                                initiallyExpanded: (state.calculationResponse?.koeffSum ?? 0) >= 200 &&
                                    (state.calculationResponse?.koeffSum ?? 0) < 300,
                                title: 'more_than_200_index_title'.tr(),
                                descriptionTitle: 'more_than_200_index_description_title'.tr(),
                                description: 'more_than_200_index_description_body'.tr(),
                              ),
                              AppSpacing.verticalSpace16,
                              ExpandableDescriptionItem(
                                initiallyExpanded: (state.calculationResponse?.koeffSum ?? 0) >= 100 &&
                                    (state.calculationResponse?.koeffSum ?? 0) < 200,
                                title: 'more_than_100_index_title'.tr(),
                                descriptionTitle: 'more_than_100_index_description_title'.tr(),
                                description: 'more_than_100_index_description_body'.tr(),
                              ),
                              AppSpacing.verticalSpace16,
                              ExpandableDescriptionItem(
                                initiallyExpanded: (state.calculationResponse?.koeffSum ?? 0) >= 50 &&
                                    (state.calculationResponse?.koeffSum ?? 0) < 100,
                                title: 'more_than_50_index_title'.tr(),
                                descriptionTitle: 'more_than_50_index_description_title'.tr(),
                                description: 'more_than_50_index_description_body'.tr(),
                              ),
                              AppSpacing.verticalSpace16,
                              ExpandableDescriptionItem(
                                initiallyExpanded:
                                    (state.calculationResponse?.koeffSum ?? 0) >= 0 && (state.calculationResponse?.koeffSum ?? 0) < 50,
                                title: 'more_than_0_index_title'.tr(),
                                descriptionTitle: 'more_than_0_index_description_title'.tr(),
                                description: 'more_than_0_index_description_body'.tr(),
                              ),
                              AppSpacing.verticalSpace32,
                              TappableColoredCardWrap(
                                color: AppColors.white.withOpacity(0.1),
                                content: Text(
                                  'index_k_description'.tr(),
                                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                                        fontSize: 15,
                                        color: AppColors.white.withOpacity(0.8),
                                      ),
                                ),
                              ),
                              AppSpacing.verticalSpace20,
                              AppSpacing.verticalSpace20,
                              CoefficientChart(
                                initialIndex: state.selectedIndex,
                                onBarSelected: (index) {
                                  state.setSelectedIndex(index);
                                  state.scrollController.animateTo(
                                    state.scrollController.offset + index * 150,
                                    duration: const Duration(milliseconds: 250),
                                    curve: Curves.decelerate,
                                  );
                                },
                                coefficients: state.calculationResponse?.koeff ?? [],
                              ),
                              AppSpacing.verticalSpace20,
                              AppSpacing.verticalSpace20,
                              for (int i = 0; i < 12; i++)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: ExpandableCompatibilityCard(
                                    score: state.calculationResponse?.koeff?.elementAt(i) ?? 0,
                                    levelNumber: i + 1,
                                    title: state.compatibilityLevelTitles.elementAt(i),
                                    description: state.compatibilityDescriptions.elementAt(i),
                                  ),
                                ),
                              CustomButton.child(
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SvgPicture.asset('assets/images/svg/share.svg'),
                                    Text(
                                      'share'.tr(),
                                      style: Theme.of(context).textTheme.headline6,
                                    ),
                                    const SizedBox(),
                                  ],
                                ),
                                onTap: () => _shareLink(
                                  response: state.calculationResponse,
                                  context: context,
                                  args: args,
                                ),
                              ),
                              AppSpacing.verticalSpace20,
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _shareLink({
    CompatibilityResponse? response,
    required BuildContext context,
    required CalculateCompatibilityPageArguments args,
  }) {
    final uri = Uri.parse(response?.requestUrl ?? '');
    Map<String, dynamic> parameters = Map<String, dynamic>.from(uri.queryParameters);
    parameters.addAll({
      'city1_name': args.maleData.city.title,
      'city2_name': args.femaleData.city.title,
      'lang': context.locale.languageCode,
    });
    parameters.remove('key');
    // final properUri = Uri.parse(
    //     'https://siastro.com/result.php?sex1=M&sex2=F&day1=04&day2=06&month1=05&month2=06&year1=1985&year2=2020&hour1=00&hour2=00&minute1=00&minute2=00&notime1=0&notime2=0&name1=Имя1&name2=Имя2&long1=37.6167&long2=37.6167&city1_name=Москва&city2_name=Владивосток&lang=ru');
    // print('properUri.authority == endUri.authority: ${properUri.authority == endUri.authority}');
    // print(endUri.toString());
    // for (var element in endUri.queryParameters.keys) {
    //   print('properUri has $element: ${properUri.queryParameters.containsKey(element)}');
    final endUri = Uri.https(uri.authority, 'result.php', parameters);
    if (response != null) {
      FlutterShare.share(
        title: 'share'.tr(),
        linkUrl: endUri.toString(),
      );
    }
  }
}

class SecondPartnerDataPageArguments {
  final PersonDetails maleData;

  SecondPartnerDataPageArguments({required this.maleData});
}

class CalculateCompatibilityPageArguments {
  final PersonDetails maleData, femaleData;
  final bool shouldSaveToLocalDb;

  CalculateCompatibilityPageArguments({
    required this.maleData,
    required this.femaleData,
    this.shouldSaveToLocalDb = true,
  });
}
