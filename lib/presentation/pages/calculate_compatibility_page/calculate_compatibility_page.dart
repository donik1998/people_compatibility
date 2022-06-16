import 'package:flutter/material.dart';
import 'package:people_compatibility/core/models/person_details.dart';

class CalculateCompatibilityPage extends StatelessWidget {
  const CalculateCompatibilityPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class CalculateCompatibilityPageArguments {
  final PersonDetails maleData, femaleData;

  CalculateCompatibilityPageArguments({
    required this.maleData,
    required this.femaleData,
  });
}
