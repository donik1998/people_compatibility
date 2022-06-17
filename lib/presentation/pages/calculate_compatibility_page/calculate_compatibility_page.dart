import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:people_compatibility/core/models/person_details.dart';
import 'package:people_compatibility/presentation/custom_widgets/custom_back_button.dart';
import 'package:people_compatibility/presentation/custom_widgets/custom_button.dart';

class CalculateCompatibilityPage extends StatelessWidget {
  const CalculateCompatibilityPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as CalculateCompatibilityPageArguments;
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        actions: [
          CustomButton.child(
            width: 40,
            onTap: () {},
            child: SvgPicture.asset('assets/images/svg/share.svg'),
          ),
        ],
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
