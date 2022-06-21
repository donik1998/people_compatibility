import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:people_compatibility/core/models/person_details.dart';
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
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      final args = ModalRoute.of(context)!.settings.arguments as CalculateCompatibilityPageArguments;
      final state = context.read<CalculateCompatibilityPageState>();
      state.setInProgress(true);
      final result = await PeopleCompatibilityService.instance.getCompatibility(args.maleData, args.femaleData);
      result.fold(
        (l) => state.setError(true),
        (r) => state.setCalculationResponse(
          response: r,
          femaleName: args.femaleData.name,
          maleName: args.maleData.name,
        ),
      );
      state.setInProgress(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as CalculateCompatibilityPageArguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Результат',
          style: Theme.of(context).textTheme.headline5?.copyWith(fontSize: 20),
        ),
        leadingWidth: 64,
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            AppSpacing.horizontalSpace16,
            AppSpacing.horizontalSpace8,
            CustomBackButton(),
          ],
        ),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 24),
              child: CustomButton.child(
                height: 40,
                width: 40,
                onTap: () {},
                child: SvgPicture.asset('assets/images/svg/share.svg'),
              ),
            ),
          ),
        ],
      ),
      body: AppBodyBackground(
        child: Consumer<CalculateCompatibilityPageState>(
          builder: (context, state, child) {
            if (state.inProgress) return const Center(child: CircularProgressIndicator());
            return ListView(
              controller: state.scrollController,
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
                  'Ваш общий коэфициент совместимости ${state.calculationResponse?.koeffSum} балла',
                  style: Theme.of(context).textTheme.headline5,
                ),
                AppSpacing.verticalSpace24,
                CircleCoefficientBar(
                  coefficient: state.calculationResponse?.koeffSum ?? 0,
                ),
                AppSpacing.verticalSpace20,
                AppSpacing.verticalSpace20,
                const ExpandableDescriptionItem(
                  title: 'Более 400 баллов',
                  descriptionTitle: 'Идеальная совместимость, возможна полная гармония',
                  description:
                      'Позвольте вас поздравить, более высокой совместимости и представить себе нельзя. Вы - самые счастливые люди на Земле, наделенные божественным даром любви. Кому как не вам, следуя по жизни рука об руку, переворачивать вспять реки, сносить горы и понимать друг друга с полуслова. Ваш показатель совместимости превышает все допустимые нормы, столь высокий коэффициент - редкость, потому вам стоит задуматься о себе и своей избранности, вознести, по вашему выбору, хвалы высшим силам и как зеницу ока холить и лелеять зарождающееся светлое чувство любви.\n\nКоэффициент не показывает личностные качества человека, он дает оценку Ваших шансов быть вместе. Программа не учитывает воспитание, окружение, факторы наследственности. И, прежде всего, в делах сердечных прислушивайтесь к своей интуиции, тогда у Вас все получится!',
                ),
                AppSpacing.verticalSpace16,
                const ExpandableDescriptionItem(
                  title: 'От 300 до 400 баллов',
                  descriptionTitle: 'У вас много общего, вы отличная пара',
                  description:
                      'Замечательные показатели, таких счастливчиков как вы еще надо поискать. Подумать только, миллиарды человек живут на нашей планете, найти свою половинку невероятно трудно, но к вам судьба оказалась благосклонна. Отныне вы встретились и знаете, что созданы друг для друга. Остальное - в ваших руках. Вы друг для друга и пылкие влюбленные и товарищи по партии, одинаковый восторг испытаете и от уединенного пикника в живописной местности, и на выполнении секретной разведывательной миссии. Главное, держите себя в руках и помните, что даже высокие баллы совместимости не освобождают от ответственности. Будьте чутки и внимательны друг к другу.\n\nКоэффициент не показывает личностные качества человека, он дает оценку Ваших шансов быть вместе. Программа не учитывает воспитание, окружение, факторы наследственности. И, прежде всего, в делах сердечных прислушивайтесь к своей интуиции, тогда у Вас все получится',
                ),
                AppSpacing.verticalSpace16,
                const ExpandableDescriptionItem(
                  title: 'От 200 до 300 баллов',
                  descriptionTitle: 'У вас много общего, вы отличная пара',
                  description:
                      'Замечательные показатели, таких счастливчиков как вы еще надо поискать. Подумать только, миллиарды человек живут на нашей планете, найти свою половинку невероятно трудно, но к вам судьба оказалась благосклонна. Отныне вы встретились и знаете, что созданы друг для друга. Остальное - в ваших руках. Вы друг для друга и пылкие влюбленные и товарищи по партии, одинаковый восторг испытаете и от уединенного пикника в живописной местности, и на выполнении секретной разведывательной миссии. Главное, держите себя в руках и помните, что даже высокие баллы совместимости не освобождают от ответственности. Будьте чутки и внимательны друг к другу.\n\nКоэффициент не показывает личностные качества человека, он дает оценку Ваших шансов быть вместе. Программа не учитывает воспитание, окружение, факторы наследственности. И, прежде всего, в делах сердечных прислушивайтесь к своей интуиции, тогда у Вас все получится',
                ),
                AppSpacing.verticalSpace16,
                const ExpandableDescriptionItem(
                  title: 'От 100 до 200 баллов',
                  descriptionTitle: 'Вы неплохо подходите друг другу',
                  description:
                      'Ваши показатели самые земные, такие, как у большинства людей. Сила чувства и близости полностью зависят от вас. Вы - творцы своей судьбы. В этом нет ничего печального. Одни рождаются с божественными талантами, другие добиваются совершенства упорным трудом, но признание и слава для всех одинаковая. Когда вы, прикладывая усилия для достижения цели, с триумфом взберетесь на вершину пьедестала, то с необычайной силой почувствуете сладость победы. Если же благодаря чуткости и взаимопониманию, уважению и симпатии, вы сумеете из саженца вырастить чудесное дерево с райскими плодами, то честь вам и хвала.\n\nКоэффициент не показывает личностные качества человека, он дает оценку Ваших шансов быть вместе. Программа не учитывает воспитание, окружение, факторы наследственности. И, прежде всего, в делах сердечных прислушивайтесь к своей интуиции, тогда у Вас все получится',
                ),
                AppSpacing.verticalSpace16,
                const ExpandableDescriptionItem(
                  title: 'От 50 до 100 баллов',
                  descriptionTitle: 'Вам можно попробовать...',
                  description:
                      'Не стоит унывать и ставить крест на взаимоотношениях только потому, что показатели столь малы. Как бы там ни было, точки соприкосновения у вас есть, а уж раздуть совместными усилиями пламя любви и взаимопонимания - ваша задача. В данном случае стоит доверять не разуму, а сердцу. Если оно говорит вам, что вы видите перед собой своего человека, то игра стоит свеч. Совместными усилиями вы преодолеете все преграды. Кто-то ищет свое второе я, кто-то готов идти на компромиссы и подвергаться чужому влиянию, а кто-то лучше чувствуете себя рядом с полной своей противоположностью. Присмотритесь друг к другу, если ваши отношения безоблачны, то, скорее всего, кто-то из партнеров умеет держать себя в руках или любовь сотворила чудо. Помните сказку <Рикки-хохолок>? Когда Рикки одарил невесту толикой своего острого ума, а та, в свою очередь, поделилась с хромоногим горбуном своей красотой. Любовь способна на многое!\n\nКоэффициент не показывает личностные качества человека, он дает оценку Ваших шансов быть вместе. Программа не учитывает воспитание, окружение, факторы наследственности. И, прежде всего, в делах сердечных прислушивайтесь к своей интуиции, тогда у Вас все получится',
                ),
                AppSpacing.verticalSpace16,
                const ExpandableDescriptionItem(
                  title: 'От 0 до 50 баллов',
                  descriptionTitle: 'Низкая совместимость',
                  description:
                      'Нулевые показатели столь же редки, как снег летом или финиковые пальмы на Невском. Тем не менее, если ваш коэффициент столь низок, а претендент кажется многообещающим, то верить стоит своему сердцу. Согласитесь, презреть вердикт науки всегда приятно. Будто неизлечимый больной, поставивший врача в тупик, тем что наперекор медицине встал на ноги и зажил припеваючи. Попробуйте перехитрить судьбу, если, конечно, вы боец и вас не пугают трудности. Зато, в случае победы, вы будете счастливцем, уверенным в себе и в любимом человеке. Чем больше преград на пути к счастью, тем радостнее последующее почивание на лаврах.\n\nКоэффициент не показывает личностные качества человека, он дает оценку Ваших шансов быть вместе. Программа не учитывает воспитание, окружение, факторы наследственности. И, прежде всего, в делах сердечных прислушивайтесь к своей интуиции, тогда у Вас все получится',
                ),
                AppSpacing.verticalSpace32,
                TappableColoredCardWrap(
                  color: AppColors.white.withOpacity(0.1),
                  content: Text(
                    'Общий коэффициент совместимости - k - является основным показателем, определяющим отношения между людьми. Он состоит из суммы коэффициентов всех аспектов т.е. L1+L2+L3+L4+L5+L6+L7+L8+L9+L10+L11+L12 = k',
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 15),
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
                        'Поделиться',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      const SizedBox(),
                    ],
                  ),
                  onTap: () {},
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class CalculateCompatibilityPageArguments {
  final PersonDetails maleData, femaleData;

  CalculateCompatibilityPageArguments({
    required this.maleData,
    required this.femaleData,
  });
}
