import 'package:flutter/material.dart';
import 'custom_button.dart';
import 'custom_text_field.dart';

class BottomSheetBody extends StatelessWidget {
  const BottomSheetBody({super.key, this.onChanged, required this.onPressed});

  final void Function(String)? onChanged;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
              labelText: 'Title',
              textInputAction: TextInputAction.done,
              onChanged: onChanged,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomButton(
              text: 'Add',
              onPressed: onPressed,
            )
          ],
        ),
      ),
    );
  }
}
