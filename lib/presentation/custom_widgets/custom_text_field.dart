import 'package:flutter/material.dart';
import 'package:people_compatibility/presentation/theme/app_colors.dart';
import 'package:people_compatibility/presentation/theme/app_insets.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final void Function(String)? onChanged;
  final bool? readOnly;
  final bool? enabled;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hint,
    this.onChanged,
    this.readOnly,
    this.enabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 16),
      controller: controller,
      readOnly: readOnly ?? false,
      onChanged: onChanged,
      decoration: InputDecoration(
        fillColor: enabled ?? true ? AppColors.white.withOpacity(0.1) : AppColors.white.withOpacity(0.25),
        contentPadding: AppInsets.horizontal18,
        hintText: hint,
      ),
    );
  }
}
