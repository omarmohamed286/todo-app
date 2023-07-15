import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/change_password_icon_cubit/change_password_icon_cubit.dart';
import '../../utils/custom_border.dart';

class CustomPasswordTextFormField extends StatelessWidget {
  const CustomPasswordTextFormField(
      {super.key, required this.labelText, this.onSaved, this.onChanged});

  final String labelText;
  final void Function(String?)? onSaved;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangePasswordIconCubit, ChangePasswordIconState>(
      builder: (context, state) {
        IconData currentIcon =
            BlocProvider.of<ChangePasswordIconCubit>(context).getIcon();
        bool obscureText =
            BlocProvider.of<ChangePasswordIconCubit>(context).obscureText;
        return TextFormField(
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return '$labelText cannot be null';
            }
          },
          onSaved: onSaved,
          onChanged: onChanged,
          textInputAction: TextInputAction.done,
          obscureText: obscureText,
          decoration: InputDecoration(
            suffixIcon: IconButton(
                onPressed: () {
                  BlocProvider.of<ChangePasswordIconCubit>(context)
                      .changePasswordIcon();
                },
                icon: Icon(currentIcon)),
            focusedBorder: customBorder(),
            enabledBorder: customBorder(),
            labelText: labelText,
          ),
        );
      },
    );
  }
}
