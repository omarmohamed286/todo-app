import 'package:flutter/material.dart';

import '../../utils/custom_border.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.labelText,
    this.onSaved,
    this.textInputAction = TextInputAction.next,
    this.onChanged,
    this.initialValue,
  });

  final String labelText;
  final void Function(String?)? onSaved;
  final TextInputAction? textInputAction;
  final void Function(String)? onChanged;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return '$labelText cannot be null';
        }
        return null;
      },
      onSaved: onSaved,
      onChanged: onChanged,
      textInputAction: textInputAction,
      initialValue: initialValue,
      decoration: InputDecoration(
        focusedBorder: customBorder(),
        enabledBorder: customBorder(),
        labelText: labelText,
      ),
    );
  }
}
